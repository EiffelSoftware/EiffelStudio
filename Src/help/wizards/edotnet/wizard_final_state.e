indexing
	description	: "Final state of the wizard."

class
	WIZARD_FINAL_STATE

inherit
	BENCH_WIZARD_FINAL_STATE_WINDOW
		redefine
			proceed_with_current_info,
			make,
			build
		end
	
create
	make

feature {NONE} -- Implementation

	make (an_info: like wizard_information) is
			-- Set `help_filename' with `h_filename'.
		do
			set_help_filename (h_filename)
			Precursor {BENCH_WIZARD_FINAL_STATE_WINDOW} (an_info) 
		end

	build is
			-- Special display box for the first and the last state
		local
			vertical_separator: EV_VERTICAL_SEPARATOR
			local_pixmap: EV_PIXMAP
			interior_box: EV_HORIZONTAL_BOX
			message_and_title_box: EV_VERTICAL_BOX
			tuple: TUPLE
		do
			first_window.set_final_state ("Finish")
			create title
			title.set_background_color (white_color)
			title.align_text_left
			title.set_font (welcome_title_font)
			title.set_minimum_height (dialog_unit_to_pixels(40))

			create message	
			message.align_text_left
			message.set_background_color (white_color)
			
			create message_text_field
			message_text_field.set_background_color (white_color)
		
			create choice_box
			choice_box.set_background_color (white_color)	
			choice_box.extend (message_text_field)

			display_state_text
			create message_and_title_box
			message_and_title_box.set_background_color (white_color)			
			message_and_title_box.set_border_width (Default_border_size)
			message_and_title_box.set_padding (Default_padding_size)
			message_and_title_box.extend (title)
			message_and_title_box.disable_item_expand (title)
			message_and_title_box.extend (choice_box)
			message_and_title_box.extend (message)
			message_and_title_box.disable_item_expand (message)

			local_pixmap := pixmap.ev_clone
			local_pixmap.set_minimum_height (dialog_unit_to_pixels(312))
			local_pixmap.set_minimum_width (165)
			local_pixmap.draw_pixmap (91, 9, pixmap_icon)

			create vertical_separator

			create interior_box
			interior_box.extend (local_pixmap)
			interior_box.disable_item_expand (local_pixmap)
			interior_box.extend (vertical_separator)
			interior_box.disable_item_expand (vertical_separator)
			interior_box.extend (message_and_title_box) 
			main_box.extend (interior_box)
			create tuple.make
			choice_box.set_help_context (~create_help_context (tuple))
		end	
	
feature -- Basic Operations

	proceed_with_current_info is
		local
			project_name_lowercase: STRING
			project_location: STRING
			ec_command_line: STRING
			eifgen_directory: DIRECTORY
			epr_file: RAW_FILE
		do
			project_generator.generate_code
			write_bench_notification_ok (wizard_information)
			
				-- Compilation
			if wizard_information.compile_project then
				project_name_lowercase := clone (wizard_information.project_name)
				project_name_lowercase.to_lower
				project_location := wizard_information.project_location
				
				ec_command_line := ec_location
				if is_incremental_compilation_possible then
					ec_command_line.append (" -project " + project_location + "\" + project_name_lowercase + ".epr")
				else
					create eifgen_directory.make (project_location + "\EIFGEN")
					if eifgen_directory.exists then
						eifgen_directory.recursive_delete
					end
					create epr_file.make (project_location + "\" + project_name_lowercase + ".epr")
					if epr_file.exists then
						epr_file.delete
					end
					ec_command_line.append (" -ace " + project_location + "\" + project_name_lowercase + ".ace -project_path " + project_location)
				end
				(create {EXECUTION_ENVIRONMENT}).launch (ec_command_line)		
			end
			Precursor
		end

feature -- Access

	display_state_text is
		local
			word: STRING
		do
			title.set_text (Interface_names.m_Final_title)
			if wizard_information.compile_project then
				word :=" and compile "
			else
				word := " "
			end
			if not wizard_information.selected_assemblies.is_empty then
				if not wizard_information.dependencies.is_empty then
					message_text_field.set_text (Common_message +
						"External assemblies: %N" + assemblies_string (wizard_information.selected_assemblies) + "%N%	
						%Dependencies: %N" + assemblies_string (wizard_information.dependencies))
				else
					message_text_field.set_text (Common_message +
						"External assemblies: %N" + assemblies_string (wizard_information.selected_assemblies))				
				end
			else
				message_text_field.set_text (Common_message)			
			end
			message.set_text ("Click Finish to generate" + word + "this project.")
		end

	final_message: STRING is
		do
		end

	h_filename: STRING is "help/wizards/edotnet/docs/reference/40_settings_summary/index.html"
			-- Path to HTML help file
			
feature {NONE} -- Implementation

	message_text_field: EV_TEXT
			-- Text field summarizing the project settings
			
	instruction: EV_LABEL
			-- Message telling the user how to launch code generation and compilation
			
	pixmap_icon_location: FILE_NAME is
			-- Icon for the Eiffel Dotnet Wizard.
		once
			 create Result.make_from_string ("eiffel_wizard_icon")
			 Result.add_extension (pixmap_extension)
		end
	
	assemblies_string (a_list: LINKED_LIST [ASSEMBLY_INFORMATION]): STRING is
			-- String from `a_list'
		require
			non_void_assemblies: a_list /= Void
			not_empty_assemblies: not a_list.is_empty
		local
			an_assembly: ASSEMBLY_INFORMATION
		do
			from
				create Result.make (1024)
				a_list.start
			until
				a_list.after
			loop
				an_assembly := a_list.item
				Result.append ("%T" + an_assembly.name + ", " + an_assembly.version + "%N")
				a_list.forth
			end
		ensure
			non_void_text: Result /= Void
			not_empty_text: not Result.is_empty
		end

	ec_location: STRING is
			-- Path to `ec.exe'
		once
			Result := Eiffel_installation_dir_name
			Result.append ("\bench\spec\windows\bin\ec.exe")
		ensure
			non_void_path: Result /= Void
			not_empty_path: not Result.is_empty
		end
	
	Common_message: STRING is 
			-- Message to the user (no matter if there are selected assemblies)
		once
			Result := "You have specified the following settings:%N%N%
					%Project name: %T" + wizard_information.project_name + "%N%
					%Location:     %T" + wizard_information.project_location + "%N%N%
					%Root class name: %T" + wizard_information.root_class_name + "%N%
					%Creation routine name: %T" + wizard_information.creation_routine_name + "%N%N"	
		ensure
			non_void_message: Result /= Void
			not_empty_message: not Result.is_empty
		end			

	is_incremental_compilation_possible: BOOLEAN is
			-- Is an incremental compilation possible?
		local
			epr_file: RAW_FILE
			project_name_lowercase: STRING
			project_location: STRING
		do
			project_location := wizard_information.project_location
			if directory_exists (project_location + "\EIFGEN") 
				and then directory_exists (project_location + "\EIFGEN\W_code") 
				and directory_exists (project_location + "\EIFGEN\F_code") 
				and directory_exists (project_location + "\EIFGEN\COMP") 
				and then directory_exists (project_location + "\EIFGEN\COMP\S1") then
				
				project_name_lowercase := clone (wizard_information.project_name)
				project_name_lowercase.to_lower
				create epr_file.make (project_location + "\" + project_name_lowercase + ".epr")
				Result := epr_file.exists 
			else
				Result := False
			end
		end
	
	directory_exists (a_filename: STRING): BOOLEAN is
			-- Does a directory with filename `a_filename' exist?
		require
			non_void_filename: a_filename /= Void
			not_empty_filename: not a_filename.is_empty
		do
			Result := (create {DIRECTORY}.make (a_filename)).exists
		end
			
end -- class WIZARD_FINAL_STATE
