indexing
	description	: "Page in which the user choose where he wants to generate the sources."

class
	WIZARD_THIRD_STATE

inherit
	BENCH_WIZARD_INTERMEDIARY_STATE_WINDOW
		redefine
			update_state_information,
			proceed_with_current_info,
			build,
			make
		end

	WEL_PROCESS_CREATION_CONSTANTS
		export
			{NONE} all
		end

	WEL_SW_CONSTANTS
		export
			{NONE} all
		end

	WEL_STARTUP_CONSTANTS
		export
			{NONE} all
		end
		
create
	make

feature {NONE} -- Implementation

	make (an_info: like wizard_information) is
			-- Set `help_filename' with `h_filename.
		do
			set_help_filename (h_filename)
			Precursor {BENCH_WIZARD_INTERMEDIARY_STATE_WINDOW} (an_info) 
		end
		
feature -- Access

	h_filename: STRING is "help/wizards/edotnet/docs/reference/30_assembly_selection/index.html"
			-- Path to HTML help file
			
feature -- Basic Operation

	build is 
			-- Build entries.
		local
			add_button_box: EV_VERTICAL_BOX
			remove_button_box: EV_VERTICAL_BOX
			import_button_box: EV_HORIZONTAL_BOX
			padding_cell: EV_CELL
			references_to_add_box: EV_HORIZONTAL_BOX
			added_references_box: EV_HORIZONTAL_BOX
			default_column_widths: ARRAY [INTEGER]
		do 
				-- Compute default width for columns and column names
			default_column_widths := <<
				Dialog_unit_to_pixels(157), 
				Dialog_unit_to_pixels(70), 
				Dialog_unit_to_pixels(70), 
				Dialog_unit_to_pixels(100)>>
				
				-- Create tables.
			create references_to_add
			references_to_add.set_column_titles (<< "Available assemblies Name", "Version", "Culture", "Public Key" >>)
			references_to_add.set_column_widths (default_column_widths)
			references_to_add.set_minimum_height (Dialog_unit_to_pixels(110))
			references_to_add.select_actions.extend (agent update_buttons_state)
			references_to_add.deselect_actions.extend (agent update_buttons_state)
			
			create added_references
			added_references.set_column_titles (<< "Selected assemblies Name", "Version", "Culture", "Public Key" >>)
			added_references.set_column_widths (default_column_widths)
			added_references.set_minimum_height (Dialog_unit_to_pixels(70))
			added_references.select_actions.extend (agent update_buttons_state)
			added_references.deselect_actions.extend (agent update_buttons_state)
			fill_lists
			
				-- Create buttons.
			create add_button.make_with_text ("Add")
			add_button.select_actions.extend (agent select_assembly)
			set_default_size_for_button (add_button)
			
			create remove_button.make_with_text ("Remove")
			remove_button.select_actions.extend (agent unselect_assembly)
			set_default_size_for_button (remove_button)

			create import_button.make_with_text ("ISE Assembly manager")
			import_button.select_actions.extend (agent import_assembly)
			set_default_size_for_button (import_button)

				-- Layout buttons						
			create add_button_box
			add_button_box.extend (add_button)
			add_button_box.disable_item_expand (add_button)
			add_button_box.extend (create {EV_CELL})
			
			create remove_button_box
			remove_button_box.extend (remove_button)
			remove_button_box.disable_item_expand (remove_button)
			remove_button_box.extend (create {EV_CELL})

			create import_button_box
			import_button_box.extend (create {EV_CELL})
			import_button_box.extend (import_button)
			import_button_box.disable_item_expand (import_button)
			
				-- Layout Tables with their resp. "Add/Remove" buttons.
			create references_to_add_box
			references_to_add_box.set_padding (Small_padding_size)
			references_to_add_box.extend (references_to_add)
			references_to_add_box.extend (add_button_box)
			references_to_add_box.disable_item_expand (add_button_box)
			
			create added_references_box
			added_references_box.set_padding (Small_padding_size)
			added_references_box.extend (added_references)
			added_references_box.extend (remove_button_box)
			added_references_box.disable_item_expand (remove_button_box)
			
				-- Add widgets to `choice_box'.
			choice_box.set_padding (Small_padding_size)
			choice_box.extend (references_to_add_box)
			choice_box.extend (added_references_box)
			choice_box.extend (import_button_box)
			
			if not references_to_add.is_empty then
				references_to_add.first.enable_select
			end
			update_buttons_state (Void)

			set_updatable_entries(<<add_button.select_actions,
									remove_button.select_actions, 
									import_button.select_actions>>)
		end

	proceed_with_current_info is 
			-- Commit current info
		do
			Precursor
			proceed_with_new_state (create {WIZARD_FINAL_STATE}.make (wizard_information))
			message_box.show
		end

	update_state_information is
			-- Check User Entries
		do
			Precursor
		end

feature {NONE} -- Vision2 controls

	references_to_add: EV_MULTI_COLUMN_LIST
			-- List of all available assembly.

	added_references: EV_MULTI_COLUMN_LIST
			-- List of all selected assembly.

	add_button: EV_BUTTON
			-- Button to select an assembly

	remove_button: EV_BUTTON
			-- Button to remove a selected assembly
	
	import_button: EV_BUTTON
			-- Button labeled "ISE Assemblies manager"
	
feature {NONE} -- Implementation

	display_state_text is
			-- Disable the caption text for this state.
		do
			title.set_text ("Assembly selection")
			subtitle.set_text ("Choose the external assemblies the Eiffel project should include")
			message_box.hide
		end

	fill_lists is
			-- Fill 
		local
			assemblies: LIST [ASSEMBLY_INFORMATION]
		do
			assemblies := wizard_information.available_assemblies
			from
				assemblies.start
			until
				assemblies.after
			loop
				references_to_add.extend (build_list_row_from_assembly (assemblies.item))
				assemblies.forth
			end

			assemblies := wizard_information.selected_assemblies
			from
				assemblies.start
			until
				assemblies.after
			loop
				added_references.extend (build_list_row_from_assembly (assemblies.item))
				assemblies.forth
			end
		end
		
	select_assembly is
			-- Add the selected assembly in `selected_assemblies'
		local
			selected_item: EV_MULTI_COLUMN_LIST_ROW
			assembly_info: ASSEMBLY_INFORMATION
		do
			selected_item := references_to_add.selected_item
			if selected_item /= Void then
					-- Modify the multi-column lists
				references_to_add.prune_all (selected_item)
				added_references.extend (selected_item)
				
					-- Modify the internal data
				assembly_info ?= selected_item.data
				check
					assembly_info_not_void: assembly_info /= Void 
				end
				wizard_information.available_assemblies.prune_all (assembly_info)
				wizard_information.selected_assemblies.extend (assembly_info)
			end
		end
		
	unselect_assembly is
			-- Check and remove the selected assembly from `selected_assemblies'
		local
			selected_item: EV_MULTI_COLUMN_LIST_ROW
			assembly_info: ASSEMBLY_INFORMATION
			--warning_dialog: EV_CONFIRMATION_DIALOG
		do
			selected_item := added_references.selected_item
			if selected_item /= Void then
				assembly_info ?= selected_item.data
				check
					assembly_info_not_void: assembly_info /= Void 
				end
				
			--	if assembly_info.name.is_equal ("mscorlib") then
			--		create warning_dialog.make_with_text (
			--			"The assembly `mscorlib' contains the Eiffel# kernel and must not be removed.%N%
			--			% %N%
			--			%Are you sure you want to remove it?")
			--		warning_dialog.show_modal_to_window (first_window)
			--		if warning_dialog.selected_button.is_equal ("OK") then
			--			remove_assembly (selected_item)
			--		end
			--	else
					remove_assembly (selected_item)
			--	end
			end
		end

	remove_assembly (a_list_item: EV_MULTI_COLUMN_LIST_ROW) is
			-- Remove the selected assembly from `selected_assemblies'
		local
			assembly_info: ASSEMBLY_INFORMATION
		do
				-- Modify the multi-column lists
			added_references.prune_all (a_list_item)
			references_to_add.extend (a_list_item)
			
				-- Modify the internal data
			assembly_info ?= a_list_item.data
			check
				assembly_info_not_void: assembly_info /= Void 
			end
			wizard_information.selected_assemblies.prune_all (assembly_info)
			wizard_information.available_assemblies.extend (assembly_info)
		end

	import_assembly is
			-- Launch ISE Assembly Manager.
		local
			an_integer: INTEGER
			cursor_pixmap: EV_STOCK_PIXMAPS
		do
			create cursor_pixmap
			first_window.set_pointer_style (cursor_pixmap.Wait_cursor)
			launch (ISE_assembly_manager_filename)
			an_integer := cwin_wait_for_single_object (process_info.process_handle, cwin_infinite)
			check
				valid_external_call_1: an_integer = cwin_wait_object_0
			end
			terminate_process
			first_window.set_pointer_style (cursor_pixmap.Standard_cursor)
			update_gui
		end
		
	launch (a_command_line: STRING) is
			-- Spawn process described in `a_command_line'.
		require
			non_void_command_line: a_command_line /= Void
			not_empty_command_line: not a_command_line.is_empty
		local
			a_wel_string: WEL_STRING
			last_launch_successful: BOOLEAN
		do
			create process_info.make
			create a_wel_string.make (a_command_line)
			last_launch_successful := cwin_create_process (default_pointer, a_wel_string.item,
				default_pointer, default_pointer, True, cwin_detached_process, default_pointer, default_pointer,
				startup_info.item, process_info.item)
		end

	terminate_process is
			-- Terminate current process (corresponding to `process_info').
		local
			a_boolean: BOOLEAN
			last_process_result: INTEGER
			terminated: BOOLEAN		
		do
			a_boolean := cwin_exit_code_process (process_info.process_handle, $last_process_result)
			check
				valid_external_call_2: a_boolean
			end
			a_boolean := cwin_close_handle (process_info.process_handle)
			check
				valid_external_call_3: a_boolean
			end
			if last_process_result = cwin_still_active then
				terminated := cwin_terminate_process (process_info.process_handle, 0)
				check
					valid_external_call_3: terminated
				end
			end
		end
		
	input_pipe_input_handle: INTEGER
			-- Input pipe input handle

	input_pipe_output_handle: INTEGER
			-- Input pipe output handle

	output_pipe_input_handle: INTEGER
			-- Output pipe input handle

	output_pipe_output_handle: INTEGER
			-- Output pipe output handle
			
	startup_info: WEL_STARTUP_INFO is
			-- Process startup information
		local
			security_attributes: WEL_SECURITY_ATTRIBUTES
			exists: BOOLEAN
		do
			create security_attributes.make
		       	security_attributes.set_inherit_handle (True)
                        exists := cwin_create_pipe ($input_pipe_output_handle, $input_pipe_input_handle, security_attributes.item, 0)
                        exists := cwin_create_pipe ($output_pipe_output_handle, $output_pipe_input_handle, security_attributes.item, 0)
			create Result.make
			Result.set_flags (Startf_use_std_handles)
			Result.set_std_input (input_pipe_input_handle)
			Result.set_std_output(output_pipe_input_handle)
		end
		
	process_info: WEL_PROCESS_INFO
			-- Process information
			
	update_gui is
			-- Update list of assemblies
		local
			last_available_assemblies: LINKED_LIST [ASSEMBLY_INFORMATION]
			assemblies: LINKED_LIST [ASSEMBLY_INFORMATION]
			assemblies_to_remove: LINKED_LIST [ASSEMBLY_INFORMATION]
			an_assembly: ASSEMBLY_INFORMATION
			selected_assemblies: LINKED_LIST [ASSEMBLY_INFORMATION]
		do
			last_available_assemblies := clone (wizard_information.available_assemblies)
			wizard_information.available_assemblies.wipe_out
			wizard_information.retrieve_available_assemblies
			assemblies := wizard_information.available_assemblies
			wizard_information.remove_kernel_assembly
			selected_assemblies := wizard_information.selected_assemblies
			from
				create assemblies_to_remove.make
				assemblies.start
			until
				assemblies.after
			loop
				an_assembly := assemblies.item
				if not has_assembly (last_available_assemblies, an_assembly) then
					selected_assemblies.extend (an_assembly)
					assemblies_to_remove.extend (an_assembly)
				end
				assemblies.forth
			end
			from
				assemblies_to_remove.start
			until
				assemblies_to_remove.after
			loop
				an_assembly := assemblies_to_remove.item
				assemblies.prune_all (an_assembly)
				assemblies_to_remove.forth
			end
			references_to_add.wipe_out
			added_references.wipe_out
			fill_lists			
		end
	
	has_assembly (a_list: LINKED_LIST [ASSEMBLY_INFORMATION]; an_assembly: ASSEMBLY_INFORMATION): BOOLEAN is
			-- Does `a_list' contain `an_assembly'?
		require
			non_void_list: a_list /= Void
			non_void_assembly_info: an_assembly /= Void
		local
			an_info: ASSEMBLY_INFORMATION
		do
			from
				a_list.start
			until
				a_list.after or Result
			loop
				an_info := a_list.item
				Result := an_info.name.is_equal (an_assembly.name) and an_info.version.is_equal (an_assembly.version)
						and an_info.culture.is_equal (an_assembly.culture) and an_info.public_key.is_equal (an_assembly.public_key) 
						and an_info.eiffel_cluster_path.is_equal (an_assembly.eiffel_cluster_path)
				a_list.forth
			end
		end
	
	update_buttons_state (a_row: EV_MULTI_COLUMN_LIST_ROW)is
			-- Update the state of `Add' and `Remove' buttons
		do
			synchronize_button_state_with_list_selection (add_button, references_to_add)
			synchronize_button_state_with_list_selection (remove_button, added_references)
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
		
	build_list_row_from_assembly (an_assembly_info: ASSEMBLY_INFORMATION): EV_MULTI_COLUMN_LIST_ROW is
			-- Create an EV_MULTI_COLUMN_LIST_ROW object representing `an_assembly_info'.
		require
			valid_assembly_info: an_assembly_info.valid_assembly
		do
			create Result
			Result.extend (an_assembly_info.name)
			Result.extend (an_assembly_info.version)
			Result.extend (an_assembly_info.culture)
			Result.extend (an_assembly_info.public_key)
			
			Result.set_data (an_assembly_info)
		end
	
	ISE_assembly_manager_filename: STRING is 
			-- Path (relatively to Eiffel delivery) to ISE Assembly Manager
		once
			Result := clone (Eiffel_installation_dir_name)
			Result.append (ISE_assembly_manager_relative_filename)
		ensure
			non_void_filename: Result /= Void
			not_empty_filename: not Result.is_empty
		end
			
	ISE_assembly_manager_relative_filename: STRING is "\wizards\dotnet\ISE.AssemblyManager.exe"
			-- Path (relatively to Eiffel delivery) to ISE Assembly Manager
	
feature {NONE} -- Externals

	cwin_create_process (a_name, a_command_line, a_sec_attributes1, a_sec_attributes2: POINTER;
							a_herit_handles: BOOLEAN; a_flags: INTEGER; an_environment, a_directory,
							a_startup_info, a_process_info: POINTER): BOOLEAN is
			-- SDK CreateProcess
		external
			"C [macro <winbase.h>] (LPCTSTR, LPTSTR, LPSECURITY_ATTRIBUTES, LPSECURITY_ATTRIBUTES, BOOL, DWORD, LPVOID, LPCTSTR, LPSTARTUPINFO, LPPROCESS_INFORMATION) :EIF_BOOLEAN"
		alias
			"CreateProcess"
		end

	cwin_wait_for_single_object (handle, type: INTEGER): INTEGER is
		external
			"C [macro <winbase.h>] (HANDLE, DWORD): EIF_INTEGER"
		alias
			"WaitForSingleObject"
		end	

	cwin_wait_object_0: INTEGER is
			-- SDK WAIT_OBJECT_0 constant
		external
			"C [macro <windows.h>]: EIF_INTEGER"
		alias
			"WAIT_OBJECT_0"
		end

	cwin_infinite: INTEGER is
			-- SDK INFINITE constant
		external
			"C [macro <winbase.h>]: EIF_INTEGER"
		alias
			"INFINITE"
		end

	cwin_detached_process: INTEGER is
			-- SDK DETACHED_PROCESS constant
		external
			"C [macro <winbase.h>]: EIF_INTEGER"
		alias
			"DETACHED_PROCESS"
		end
		
	cwin_create_pipe (a_read_handle_pointer, a_write_handle_pointer, a_pointer: POINTER; a_size: INTEGER): BOOLEAN is
			-- SDK CreatePipe
		external
			"C [macro <winbase.h>] (PHANDLE, PHANDLE, LPSECURITY_ATTRIBUTES, DWORD): BOOL"
		alias
			"CreatePipe"
		end

	cwin_exit_code_process (handle: INTEGER; ptr: POINTER): BOOLEAN is
		external
			"C [macro <winbase.h>] (HANDLE, LPDWORD): EIF_BOOLEAN"
		alias
			"GetExitCodeProcess"
		end

	cwin_still_active: INTEGER is
			-- SDK STILL_ACTIVE constant
		external
			"C [macro <windows.h>]: EIF_INTEGER"
		alias
			"STILL_ACTIVE"
		end
		
	cwin_close_handle (a_handle: INTEGER): BOOLEAN is
			-- SDK CloseHandle
		external
			"C [macro <winbase.h>] (HANDLE): EIF_BOOLEAN"
		alias
			"CloseHandle"
		end
		
	cwin_terminate_process (handle, exit_code: INTEGER): BOOLEAN is
			-- SDK TerminateProcess
		external
			"C [macro <winbase.h>] (HANDLE, DWORD): EIF_BOOLEAN"
		alias
			"TerminateProcess"
		end
		
end -- class WIZARD_THIRD_STATE
