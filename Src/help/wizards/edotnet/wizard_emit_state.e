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
		
	DIRECTORY
		rename
			make as old_make
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
		local
			button_box: EV_HORIZONTAL_BOX
		do 
				-- Button creation.
			create add_assembly_button.make_with_text ("Add assembly")
			layout_implementation.set_default_size_for_button (add_assembly_button)
			add_assembly_button.select_actions.extend (agent on_add_assembly)

			create remove_assembly_button.make_with_text ("Remove assembly")
			layout_implementation.set_default_size_for_button (remove_assembly_button)
			remove_assembly_button.select_actions.extend (agent on_remove_assembly)

			create dotnet_assembly.make (Current)
			dotnet_assembly.set_label_string_and_size (interface_names.l_Dotnet_assembly, 10)
			dotnet_assembly.set_textfield_string (wizard_information.dotnet_assembly_filename)				
			dotnet_assembly.enable_file_browse_button (Assembly_filter)
			dotnet_assembly.generate
			dotnet_assembly.change_actions.extend (agent update_buttons_state)
			
				-- Table creation.
			create local_assemblies
			local_assemblies.set_column_titles (<< "Local assemblies" >>)
			local_assemblies.set_column_width (398, 1)
			local_assemblies.select_actions.force_extend (agent update_buttons_state)
			local_assemblies.deselect_actions.force_extend (agent update_buttons_state)

			create button_box.default_create
			button_box.extend (add_assembly_button)
			button_box.extend (create {EV_CELL}.default_create)
			button_box.extend (remove_assembly_button)
			button_box.disable_item_expand (add_assembly_button)
			button_box.disable_item_expand (remove_assembly_button)
			
			choice_box.set_padding (dialog_unit_to_pixels(10))
			choice_box.extend (dotnet_assembly.widget)
			choice_box.disable_item_expand (dotnet_assembly.widget)
			choice_box.extend (button_box)
--			choice_box.extend (add_assembly_button)
--			choice_box.extend (remove_assembly_button)
			choice_box.extend (local_assemblies)
			choice_box.disable_item_expand (local_assemblies)

			fill_list
			update_buttons_state

			set_updatable_entries(<<
				dotnet_assembly.change_actions,
				add_assembly_button.select_actions,
				remove_assembly_button.select_actions>>)
		end
		
	proceed_with_current_info is 
		local
			a_path: STRING
			rescued: BOOLEAN
		do
			if not rescued then
				from
					local_assemblies.start
					wizard_information.local_assemblies.wipe_out
				until
					local_assemblies.after
				loop
					a_path ?= local_assemblies.item.data
					if a_path /= Void then
						wizard_information.local_assemblies.extend (a_path)
					end
					local_assemblies.forth
				end
	
				Precursor
				proceed_with_new_state (create {WIZARD_FINAL_STATE}.make (wizard_information))
			end
		rescue
			rescued := True
			retry
		end

	update_state_information is
			-- Check User Entries
		local
			a_path: STRING
		do
			Precursor
			from
				local_assemblies.start
				wizard_information.local_assemblies.wipe_out
			until
				local_assemblies.after
			loop
				a_path ?= local_assemblies.item.data
				if a_path /= Void then
					wizard_information.local_assemblies.extend (a_path)
				end

				local_assemblies.forth
			end
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
--				a_directory_name := validate_directory_name (a_directory_name)
--				if a_directory_name /= Void then
					Result := a_directory_name
--				end
			end
			if Result = Void then
				create Result.make_from_string (Empty_string)
			end
		ensure
			valid_Result: Result /= Void
		end
		
	fill_list is
			-- fill `local_assemblies' list.
		local
			l_row: EV_MULTI_COLUMN_LIST_ROW
		do
			from
				wizard_information.local_assemblies.start
			until
				wizard_information.local_assemblies.after
			loop
				create l_row.default_create
				l_row.extend (wizard_information.local_assemblies.item)
				l_row.set_data (wizard_information.local_assemblies.item)
				local_assemblies.extend (l_row)
				
				wizard_information.local_assemblies.forth
			end
		end
		
	is_assembly_filename_valid (a_file_name: STRING): BOOLEAN is
			-- Is `a_file_name' a valid assembly file_name?
		local
			l_file: PLAIN_TEXT_FILE
			rescued: BOOLEAN
		do
			if not rescued then
				if a_file_name = Void or else a_file_name.is_empty then
					Result := False
				else
					create l_file.make_open_read (a_file_name)
					if l_file.exists then
						Result := True
					else
						Result := False							
					end
				end
			end
		rescue
			Result := False
			rescued := True
			retry
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

	update_buttons_state is
			-- Update the state of `Add' and `Remove' buttons
		do
			synchronize_button_state_with_list_selection (remove_assembly_button, local_assemblies)
			--synchronize_button_state_with_list_selection (remove_assembly_button, added_references)
			if dotnet_assembly.text.is_empty then
				add_assembly_button.disable_sensitive
			else
				add_assembly_button.enable_sensitive
			end
		end
		
	synchronize_button_state_with_list_selection (a_button: EV_BUTTON; a_list: EV_MULTI_COLUMN_LIST) is
			-- Synchronize `a_button' state with selected state of `a_list'.
		local
			selected_item: EV_MULTI_COLUMN_LIST_ROW
			button_sensitive: BOOLEAN
		do
			selected_item := a_list.selected_item
			button_sensitive := a_button.is_sensitive
			if selected_item = Void and then button_sensitive then
				a_button.disable_sensitive
			elseif selected_item /= Void and then not button_sensitive then
				a_button.enable_sensitive
			end
		end
			
	on_add_assembly is
			-- action performed when `add_assembly_button' is pressed.
		local
			rescued: BOOLEAN
			a_row: EV_MULTI_COLUMN_LIST_ROW
			a_path: STRING
		do
			if not rescued then
				a_path := dotnet_assembly.text
				if not is_assembly_filename_valid (a_path) then
					update_state_information
					proceed_with_new_state (create {WIZARD_ERROR_FILE_NAME}.make (wizard_information))
				else
					create a_row.default_create
					a_row.extend (a_path)
					a_row.set_data (a_path)
					local_assemblies.extend (a_row)
					
					wizard_information.local_assemblies.extend (a_path)
					
					-- clear text field
					dotnet_assembly.set_text ("")
				end
			else
					-- Something went wrong when checking that the selected directory exists
					-- or when trying to create the directory, go to error.
				update_state_information
				proceed_with_new_state (create {WIZARD_ERROR_LOCATION}.make (wizard_information))
			end
		rescue
			rescued := True
			retry
		end

	on_remove_assembly is
			-- action performed when `remove_assembly_button' is pressed.
		local
			a_path: STRING
		do
			if local_assemblies.selected_item /= Void then
				a_path ?= local_assemblies.selected_item.data
				if a_path /= Void then
					wizard_information.local_assemblies.prune (a_path)
				end
				local_assemblies.prune (local_assemblies.selected_item)
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

	local_assemblies: EV_MULTI_COLUMN_LIST
			-- List of local assemblies.

	add_assembly_button: EV_BUTTON
			-- Add assembly button.
			
	remove_assembly_button: EV_BUTTON
			-- Remove assembly button.
			
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
	
	State_subtitle: STRING is "You can choose the local assembly you want to include"
			-- Subtitle of current state window
		
	State_message: STRING is "Please choose:%N%
							%%T The .NET assembly the Eiffel project should include.%N%
							%%T Click add to add it to your project."
	
	Assembly_filter: STRING is "*.dll; *.exe"
			-- Filter for assemblies

	Message_dialog_title: STRING is "Importing local assembly..."
			-- `message_dialog' title

		
end -- class WIZARD_EMIT_STATE

