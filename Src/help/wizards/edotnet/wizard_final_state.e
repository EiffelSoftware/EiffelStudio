indexing
	description	: "Final state of the wizard."

class
	WIZARD_FINAL_STATE

inherit
	BENCH_WIZARD_FINAL_STATE_WINDOW
		redefine
			proceed_with_current_info,
			make,
			fill_message_and_title_box,
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

feature -- Basic Operations

	build is
			-- Special display box for the first and the last state
		do
			create message_text_field
			message_text_field.set_background_color (white_color)
			
			Precursor
		end
		
	proceed_with_current_info is
		--local
		--	project_name_lowercase: STRING
		--	project_location: STRING
		--	ec_command_line: STRING
		--	eifgen_directory: DIRECTORY
		--	epr_file: RAW_FILE
		do
			project_generator.generate_code
			write_bench_notification_ok (wizard_information)
			
				-- Compilation
		--	if wizard_information.compile_project then
		--		project_name_lowercase := clone (wizard_information.project_name)
		--		project_name_lowercase.to_lower
		--		project_location := wizard_information.project_location
		--		
		--		ec_command_line := ec_location
		--		if is_incremental_compilation_possible then
		--			ec_command_line.append (Space + Project_compilation_option + Space + project_location + Back_slash + project_name_lowercase + Epr_extension)
		--		else
		--			create eifgen_directory.make (project_location + Back_slash + Eifgen)
		--			if eifgen_directory.exists then
		--				eifgen_directory.recursive_delete
		--			end
		--			create epr_file.make (project_location + Back_slash + project_name_lowercase + Epr_extension)
		--			if epr_file.exists then
		--				epr_file.delete
		--			end
		--			ec_command_line.append (Space + Ace_compilation_option + Space + project_location + Back_slash + project_name_lowercase + Ace_extension + Space + Project_path_compilation_option + Space + project_location)
		--		end
		--		(create {EXECUTION_ENVIRONMENT}).launch (ec_command_line)		
		--	end
			Precursor
		end

feature -- Access

	display_state_text is
			-- Display message text relative to current state.
		local
			word: STRING
		do
			title.set_text (Interface_names.m_Final_title)
			if wizard_information.compile_project then
				word := Space + Text_if_compile + Space
			else
				word := Space
			end
			if not wizard_information.selected_assemblies.is_empty then
				if not wizard_information.dependencies.is_empty then
					if not wizard_information.local_assemblies.is_empty then
						message_text := Common_message +
							l_External_assemblies + Space + New_line + assemblies_string (wizard_information.selected_assemblies) + New_line + local_assemblies_string + New_line +	
							l_Dependencies + Space + New_line + assemblies_string (wizard_information.dependencies) + New_line
						message_text.append (local_dependencies_string)
					else
						message_text := Common_message +
							l_External_assemblies + Space + New_line + assemblies_string (wizard_information.selected_assemblies) + New_line + l_Dependencies + Space + New_line + assemblies_string (wizard_information.dependencies)
					end
				else
					if not wizard_information.local_assemblies.is_empty then
						message_text := Common_message +
							l_External_assemblies + Space + New_line + assemblies_string (wizard_information.selected_assemblies) + New_line + local_assemblies_string + New_line +	
							l_Dependencies + Space + New_line 
						message_text.append (local_dependencies_string)
					else
						message_text := Common_message +
							l_External_assemblies + Space + New_line + assemblies_string (wizard_information.selected_assemblies)					
					end
				end
				message_text_field.set_text (message_text)
			else
				message_text_field.set_text (Common_message)			
			end
			message.set_text (final_state_message (word))
		end

	final_message: STRING is
		do
		end

	final_state_message (a_word: STRING): STRING is
			-- Final state message according to `a_word'
		require
			non_void_word: a_word /= Void
		do
			Result := "Click Finish to generate" + a_word + "this project."
		ensure
			non_void_message: Result /= Void
			not_empty_message: not Result.is_empty
		end
		
feature {NONE} -- Widgets

	message_text_field: EV_TEXT
			-- Text field summarizing the project settings
			
	instruction: EV_LABEL
			-- Message telling the user how to launch code generation and compilation
			
feature {NONE} -- Implementation

	message_text: STRING
			-- Final message 
			
	fill_message_and_title_box (message_and_title_box: EV_VERTICAL_BOX) is
			-- Fill `message_and_title_box' with needed widgets.
		do
			message_and_title_box.extend (message_text_field) -- Expandable item
			message_and_title_box.extend (message)
			message_and_title_box.disable_item_expand (message)
		end

	pixmap_icon_location: FILE_NAME is
			-- Icon for the Eiffel Dotnet Wizard.
		once
			 create Result.make_from_string (Wizard_icon_name)
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
				Result.append (Tab + an_assembly.name + ", " + an_assembly.version + New_line)
				a_list.forth
			end
			Result.right_adjust
		ensure
			non_void_text: Result /= Void
			not_empty_text: not Result.is_empty
		end

	local_dependencies_string: STRING is
			-- String from `wizard_information.local_dependencies'
		local
			local_dependencies: LINKED_LIST [STRING]
			an_assembly_name: STRING
		do
			local_dependencies := wizard_information.local_dependencies
			if local_dependencies /= Void then
				from
					create Result.make (1024)
					local_dependencies.start
				until
					local_dependencies.after
				loop
					an_assembly_name := local_dependencies.item
					if message_text.substring_index (an_assembly_name, 1) < 1 then
						Result.append (Tab + an_assembly_name + New_line)
					end
					local_dependencies.forth
					if not local_dependencies.after then
						local_dependencies.forth
					end
				end
				Result.right_adjust
			end
		end

	local_assemblies_string: STRING is
			-- String from `wizard_information.local_assemblies'
		require
			non_void_local_assemblies: wizard_information.local_assemblies /= Void 
		local
			local_assemblies: HASH_TABLE [STRING, STRING]
			a_local_assembly: STRING
			last_backslash_index: INTEGER
		do
			local_assemblies := wizard_information.local_assemblies
			from
				create Result.make (1024)
				local_assemblies.start
			until
				local_assemblies.off
			loop
				a_local_assembly := clone (local_assemblies.key_for_iteration)
				if a_local_assembly /= Void and then not a_local_assembly.is_empty then
					last_backslash_index := a_local_assembly.last_index_of ('\', a_local_assembly.count)
					if last_backslash_index > 1 then
						a_local_assembly := a_local_assembly.substring (last_backslash_index + 1, a_local_assembly.count)
					end
					Result.append (Tab + a_local_assembly + New_line)
				end
				local_assemblies.forth
			end
			Result.right_adjust
		ensure
			non_void_text: Result /= Void
		end
			
	is_incremental_compilation_possible: BOOLEAN is
			-- Is an incremental compilation possible?
		local
			epr_file: RAW_FILE
			project_name_lowercase: STRING
			project_location: STRING
		do
			project_location := wizard_information.project_location
			if directory_exists (project_location + Back_slash + Eifgen) 
				and then directory_exists (project_location + Back_slash + Eifgen + Back_slash + W_code) 
				and directory_exists (project_location + Back_slash + Eifgen + Back_slash + F_code) 
				and directory_exists (project_location + Back_slash + Eifgen + Back_slash + Comp) 
				and then directory_exists (project_location + Back_slash + Eifgen + Back_slash + Comp + Back_slash + S1) then
				
				project_name_lowercase := clone (wizard_information.project_name)
				project_name_lowercase.to_lower
				create epr_file.make (project_location + Back_slash + project_name_lowercase + Epr_extension)
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

feature {NONE} -- Constants

	h_filename: STRING is "help/wizards/edotnet/docs/reference/40_settings_summary/index.html"
			-- Path to HTML help file
			
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
		local
			root_class_external_name: STRING
			creation_routine_name: STRING
			creation_routine_external_name: STRING
		once
			Result := "You have specified the following settings:" + New_line + New_line +
					"Project name: " + Tab + wizard_information.project_name + New_line +
					"Location: " + Tab + wizard_information.project_location + New_line + New_line +
					"Root class name: " + Tab + wizard_information.root_class_name + New_line 
			root_class_external_name := wizard_information.root_class_external_name
			if root_class_external_name /= Void and then not root_class_external_name.is_empty and then not root_class_external_name.is_equal (Unrelevant_data) then
				Result.append ("Root class external name: " + Tab + root_class_external_name + New_line)
			end
			creation_routine_name := wizard_information.creation_routine_name
			if creation_routine_name /= Void and then not creation_routine_name.is_empty and then not creation_routine_name.is_equal (Unrelevant_data) then
				Result.append ("Creation routine name: " + Tab + wizard_information.creation_routine_name + New_line)
			end
			creation_routine_external_name := wizard_information.creation_routine_external_name
			if creation_routine_external_name /= Void and then not creation_routine_external_name.is_empty and then not creation_routine_external_name.is_equal (Unrelevant_data) then
				Result.append ("Creation routine external name: " + Tab + wizard_information.creation_routine_external_name + New_line)
			end
			Result.append (New_line)
		ensure
			non_void_message: Result /= Void
			not_empty_message: not Result.is_empty
		end			

	Space: STRING is " "
			-- Space
			
	Epr_extension: STRING is ".epr"
			-- Eiffel projects extension
	
	Eifgen: STRING is "EIFGEN"
			-- EIFGEN directory
	
	Comp: STRING is "COMP"
			-- COMP directory
	
	W_code: STRING is "W_code"
			-- W_code directory
	
	F_code: STRING is "F_code"
			-- F_code directory
	
	S1: STRING is "S1"
			-- S1 directory
	
	Back_slash: STRING is "\"
			-- Back slash
	
	Project_compilation_option: STRING is "-project"
			-- ec option to specify an existing project
	
	Ace_compilation_option: STRING is "-ace"
			-- ec option to specify the project Ace file
	
	Project_path_compilation_option: STRING is "-project_path"
			-- ec option to specify the path to generate project into
	
	Ace_extension: STRING is ".ace"
			-- Ace files extension
	
	l_External_assemblies: STRING is ".NET assemblies:"
			-- Label before displaying the selected .NET assemblies
	
	l_Dependencies: STRING is "Dependencies:"
			-- Label before displaying the dependencies of the selected .NET assemblies
	
	Text_if_compile: STRING is "and compile"
			-- Text appended to the current state text in case the user asked for project compilation
			
end -- class WIZARD_FINAL_STATE
