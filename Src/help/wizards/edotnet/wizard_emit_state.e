indexing
	description	: "Fourth state of the .NET wizard"

class
	WIZARD_EMIT_STATE

inherit
	BENCH_WIZARD_INTERMEDIARY_STATE_WINDOW
		redefine
			update_state_information,
			proceed_with_current_info,
			build,
			make
		end
		
	ISE_DIRECTORY_UTILITIES
		export
			{NONE} all
		end
		
create
	make

feature {NONE} -- Implementation

	make (an_info: like wizard_information) is
			-- Set `help_filename' with `h_filename'.
		do
			set_help_filename (h_filename)
			Precursor {BENCH_WIZARD_INTERMEDIARY_STATE_WINDOW} (an_info) 
		end

feature -- Access

	h_filename: STRING is "help/wizards/edotnet/docs/reference/30_assembly_selection/index.html"
			-- Path to HTML help filename
			
feature -- Basic Operation

	build is 
			-- Build entries.
		do 
			create dotnet_assembly.make (Current)
			dotnet_assembly.set_label_string_and_size (interface_names.l_Dotnet_assembly, 10)
			dotnet_assembly.set_textfield_string (wizard_information.dotnet_assembly_filename)				
			dotnet_assembly.enable_file_browse_button (Assembly_filter)
			dotnet_assembly.generate
				
			create emit_directory.make (Current)
			emit_directory.set_label_string_and_size (interface_names.l_Emit_directory, 10)
			emit_directory.set_textfield_string (wizard_information.emit_directory)	
			emit_directory.enable_directory_browse_button	
			emit_directory.generate

			create eiffel_formatting_b.make_with_text (interface_names.l_Eiffel_formatting)
			if wizard_information.eiffel_formatting then
				eiffel_formatting_b.enable_select
			else
				eiffel_formatting_b.disable_select
			end
			
			choice_box.set_padding (dialog_unit_to_pixels(10))
			choice_box.extend (dotnet_assembly.widget)
			choice_box.disable_item_expand (dotnet_assembly.widget)
			choice_box.extend (emit_directory.widget)
			choice_box.disable_item_expand (emit_directory.widget)
			choice_box.extend (eiffel_formatting_b)
			choice_box.extend (create {EV_CELL}) -- expandable item

			set_updatable_entries(<<
				dotnet_assembly.change_actions,
				emit_directory.change_actions,
				eiffel_formatting_b.select_actions>>)
		end
		
	proceed_with_current_info is 
		local
			next_window: WIZARD_STATE_WINDOW
			rescued: BOOLEAN
			an_emit_directory: DIRECTORY_NAME
		do
			if not rescued then
				if not is_assembly_filename_valid (dotnet_assembly.text) then
					create {WIZARD_ERROR_FILE_NAME} next_window.make (wizard_information)
				else
					an_emit_directory := validate_directory_string (emit_directory.text)
					if an_emit_directory.is_empty then
						create {WIZARD_ERROR_LOCATION} next_window.make (wizard_information)
					else
							-- create the directory
						recursive_create_directory (an_emit_directory)
						copy_assembly
						emit 
						update_local_assemblies
						create {WIZARD_THIRD_STATE} next_window.make (wizard_information)
					end
				end
			else
					-- Something went wrong when checking that the selected directory exists
					-- or when trying to create the directory, go to error.
				create {WIZARD_ERROR_LOCATION} next_window.make (wizard_information)
			end
			Precursor
			proceed_with_new_state (next_window)
		rescue
			rescued := True
			retry
		end

	update_state_information is
			-- Check User Entries
		local
			an_emit_directory: DIRECTORY_NAME
		do
			wizard_information.set_dotnet_assembly_filename (dotnet_assembly.text)			
			an_emit_directory := validate_directory_string (emit_directory.text)
			wizard_information.set_emit_directory (an_emit_directory)
			wizard_information.set_eiffel_formatting (eiffel_formatting_b.is_selected)
			Precursor
		end

feature {NONE} -- Implementation
		
	validate_directory_string (a_directory: STRING): DIRECTORY_NAME is
			-- Validate the directory `a_directory' and return the
			-- validated version of `a_directory'.
		local
			a_directory_name: DIRECTORY_NAME
		do
			if a_directory /= Void then
				create a_directory_name.make_from_string (a_directory)
				a_directory_name := validate_directory_name (a_directory_name)
				if a_directory_name /= Void then
					Result := a_directory_name
				end
			end
			if Result = Void then
				create Result.make_from_string (Empty_string)
			end
		ensure
			valid_Result: Result /= Void
		end
		
	is_assembly_filename_valid (a_filename: STRING): BOOLEAN is
			-- Is `a_filename' a valid assembly filename?
		local
			assembly_filename: FILE_NAME
		do
			if a_filename = Void or else a_filename.is_empty then
				Result := False
			else
				create assembly_filename.make_from_string (a_filename)
				Result := assembly_filename.is_valid
			end
		end

	copy_assembly is
			-- Copy assembly with filename `dotnet_assembly.text' in current project directory.
		local
			assembly_filename: STRING
			original_assembly_file: RAW_FILE
			assembly_name: STRING
			new_assembly_file: RAW_FILE
		do
			assembly_filename := clone (dotnet_assembly.text)
			create original_assembly_file.make_open_read (assembly_filename)
			assembly_name := assembly_filename.substring (assembly_filename.last_index_of ('\', assembly_filename.count) + 1, assembly_filename.count)
			local_assembly_filename := clone (wizard_information.project_location)
			if local_assembly_filename @ local_assembly_filename.count /= '\' then
				local_assembly_filename.append ("\")
			end

			local_assembly_filename.append (assembly_name)
			create new_assembly_file.make_create_read_write (local_assembly_filename)
			original_assembly_file.copy_to (new_assembly_file)			
			original_assembly_file.close
			new_assembly_file.close
		end
	
	local_assembly_filename: STRING
			-- Filename of local assembly that will be imported
			
	emit is
			-- Emit assembly corresponding to `dotnet_assembly.text' in directory `emit_directory.text'.
			-- Generate Eiffel friendly names if `eiffel_formatting_b.is_selected'.
		require
			valid_filename: is_assembly_filename_valid (dotnet_assembly.text)
			valid_directory: validate_directory_string (emit_directory.text).is_valid
		local
			a_message_box: WIZARD_MESSAGE_BOX
			emit_command_line: STRING
			cursor_pixmap: EV_STOCK_PIXMAPS
			process_launcher: WEL_PROCESS_LAUNCHER
		do
			create cursor_pixmap
			first_window.set_pointer_style (cursor_pixmap.Wait_cursor)
			create a_message_box.make (Message_dialog_title, first_window)
			(create {EV_ENVIRONMENT}).application.process_events

			create process_launcher
			emit_command_line := clone (Emitter_filename) + clone (Target_switch) + clone (dotnet_assembly.text) + clone (Destination_switch) + clone (emit_directory.text)
			if not eiffel_formatting_b.is_selected then
				emit_command_line.append (Formatting_switch)
				emit_command_line.append (Default_formatting_value)
			end			
			if not wizard_information.proxy.is_signed (dotnet_assembly.text) then
				emit_command_line.append (Generation_switch)
				emit_command_line.append (Default_generation_value)
			end
			process_launcher.launch_and_refresh (emit_command_line, Empty_string, ~on_refresh)
			
			a_message_box.message_dialog.destroy
			first_window.set_pointer_style (cursor_pixmap.Standard_cursor)
			emit_succeeded := True
		end

	emit_succeeded: BOOLEAN
			-- Has emit succeeded?
			
	update_local_assemblies is
			-- Update `wizard_information.local_assemblies'.
		require
			emit_succeeded: emit_succeeded
		do
			if not wizard_information.proxy.is_signed (local_assembly_filename) then
				wizard_information.local_assemblies.extend (clone (emit_directory.text), clone (local_assembly_filename))
			else
				wizard_information.update_lists
			end
		end
		
	on_refresh is
			-- Action performed while the emitter is running
		do
		end
		
	display_state_text is
		do
			title.set_text (State_title)
			subtitle.set_text (State_subtitle)
			message.set_text (State_message)
		end

	dotnet_assembly: WIZARD_SMART_TEXT_FIELD
			-- Text field to enter the .NET assembly filename

	emit_directory: WIZARD_SMART_TEXT_FIELD
			-- Text field to enter the directory to generate external Eiffel classes

	eiffel_formatting_b: EV_CHECK_BUTTON
			-- Should the emitter generate Eiffel-friendly names?
			
	Emitter_filename: STRING is 
			-- Emitter filename
		once
			Result := clone (Eiffel_installation_dir_name)
			Result.append (Emitter_relative_filename)
		ensure
			non_void_filename: Result /= Void 
			not_empty_filename: not Result.is_empty
		end
	
	Emitter_relative_filename: STRING is "\dotnet\assembly_manager\ISE.Reflection.Emitter.exe"
			-- Emitter filename relatively to the Eiffel delivery path
			
	Target_switch: STRING is " /t "
			-- Target switch for the emitter
		
	Destination_switch: STRING is " /d "
			-- Destination switch for the emitter
	
	Formatting_switch: STRING is " /f "
			-- Formatting switch
	
	Default_formatting_value: STRING is "default"
			-- Default formatting value (not Eiffel formatting)

	Generation_switch: STRING is " /g "
			-- Generation switch
	
	Default_generation_value: STRING is "default"
			-- Default generation value (no XML generation)
			
	State_title: STRING is "Import local assemblies."
			-- Title of current state window
	
	State_subtitle: STRING is "You can choose the local assembly you want to include and %N%
							%the directory where the Eiffel classes should be generated."
			-- Subtitle of current state window
		
	State_message: STRING is "Please choose:%N%
							%%T The .NET assembly the Eiffel project should include.%N%
							%%T The directory where you want the Eiffel sources to be generated."
	
	Assembly_filter: STRING is "*.dll; *.exe"
			-- Filter for assemblies

	Message_dialog_title: STRING is "Importing local assembly..."
			-- `message_dialog' title
			
end -- class WIZARD_EMIT_STATE

