indexing
	description	: "Page in which the user choose the .NET assemblies he wants to include in his project."

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
			import_button_box.extend (import_button)
			import_button_box.disable_item_expand (import_button)
			import_button_box.extend (create {EV_CELL})
			
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
			subtitle.set_text ("Choose the .NET assemblies the Eiffel project should include")
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
		do
			selected_item := added_references.selected_item
			if selected_item /= Void then
				assembly_info ?= selected_item.data
				check
					assembly_info_not_void: assembly_info /= Void 
				end
				remove_assembly (selected_item)
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
			cursor_pixmap: EV_STOCK_PIXMAPS
			process_launcher: WEL_PROCESS_LAUNCHER
		do
			create cursor_pixmap
			first_window.set_pointer_style (cursor_pixmap.Wait_cursor)
			import_button.disable_sensitive 
			create process_launcher
			process_launcher.launch_and_refresh (ISE_assembly_manager_filename, "", ~on_refresh)
			first_window.set_pointer_style (cursor_pixmap.Standard_cursor)
			import_button.enable_sensitive
			update_gui
		end
		
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
			wizard_information.remove_kernel_assembly
			wizard_information.remove_system_assembly
			assemblies := wizard_information.available_assemblies
			selected_assemblies := wizard_information.selected_assemblies
			from
				create assemblies_to_remove.make
				assemblies.start
			until
				assemblies.after
			loop
				an_assembly := assemblies.item
				if not wizard_information.has_assembly (last_available_assemblies, an_assembly) then
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
			-- Filename of `ISE.AssemblyManager.exe'
		once
			Result := clone (Eiffel_installation_dir_name)
			Result.append (ISE_assembly_manager_relative_filename)
		ensure
			non_void_filename: Result /= Void
			not_empty_filename: not Result.is_empty
		end
		
	ISE_assembly_manager_relative_filename: STRING is "\wizards\dotnet\ISE.AssemblyManager.exe"
			-- Filename of `ISE.AssemblyManager.exe' (relatively to Eiffel delivery path) 

	on_refresh is
			-- Action performed while ISE Assembly Manager is active to refresh EiffelStudio development window
		do
			(create {EV_ENVIRONMENT}).application.process_events
		end

end -- class WIZARD_THIRD_STATE
