indexing
	description	: "Final state of the wizard."

class
	WIZARD_FINAL_STATE

inherit
	BENCH_WIZARD_FINAL_STATE_WINDOW
		redefine
			proceed_with_current_info
		end
	
create
	make

feature -- Basic Operations

	proceed_with_current_info is
		local
			project_name_lowercase: STRING
			project_location: STRING
			ec_command_line: STRING
		do
			project_generator.generate_code
			write_bench_notification_ok (wizard_information)
			
				-- Compilation
			if wizard_information.compile_project then
				project_name_lowercase := clone (wizard_information.project_name)
				project_name_lowercase.to_lower
				project_location := wizard_information.project_location
				
				ec_command_line := ec_location
				ec_command_line.append (" -ace " + project_location + "\" + project_name_lowercase + ".ace -project_path " + project_location)
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
				message.set_text (Common_message +
					"External assemblies: %N" + selected_assemblies_string + "%N%
					%%N%
					%%N%				
					%%N%	
					%Click Finish to generate" + word + "this project")
			else
				message.set_text (Common_message +
					"Click Finish to generate" + word + "this project")			
			end
		end

	final_message: STRING is
		do
		end

feature {NONE} -- Implementation

	pixmap_icon_location: FILE_NAME is
			-- Icon for the Eiffel Dotnet Wizard.
		once
			 create Result.make_from_string ("eiffel_wizard_icon")
			 Result.add_extension (pixmap_extension)
		end
	
	selected_assemblies_string: STRING is
			-- String from `selected_assemblies'
		require
			non_void_selected_assemblies: wizard_information.selected_assemblies /= Void
			not_empty_selected_assemblies: not wizard_information.selected_assemblies.is_empty
		local
			selected_assemblies: LINKED_LIST [ASSEMBLY_INFORMATION]
			an_assembly: ASSEMBLY_INFORMATION
		do
			selected_assemblies := wizard_information.selected_assemblies
			if selected_assemblies.count > 0 then
				from
					create Result.make (1024)
					selected_assemblies.start
				until
					selected_assemblies.after
				loop
					an_assembly := selected_assemblies.item
					Result.append ("%T" + an_assembly.name + ", " + an_assembly.version + "%N")
					selected_assemblies.forth
				end
			else
				Result.append ("%TOnly kernel assembly (in `base.net')")
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
					%Creation routine name: %T" + wizard_information.creation_routine_name + "%N%N%N"	
		ensure
			non_void_message: Result /= Void
			not_empty_message: not Result.is_empty
		end			

end -- class WIZARD_FINAL_STATE
