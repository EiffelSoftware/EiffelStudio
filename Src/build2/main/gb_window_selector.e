indexing
	description: 
		"[
			Objects that allow a user to select/manipulate all the windows in a project.
			Each item contained will be generated as a seperate class.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	GB_WINDOW_SELECTOR
	
inherit
		
	GB_STORABLE_TOOL
		redefine
			default_create, as_widget
		end
		
	GB_SHARED_TOOLS
		export
			{NONE} all
		redefine
			default_create
		end
		
	GB_SHARED_OBJECT_HANDLER
		export
			{NONE} all
		redefine
			default_create
		end
		
	GB_SHARED_COMMAND_HANDLER
		export
			{NONE} all
		redefine
			default_create
		end
		
	GB_SHARED_SYSTEM_STATUS
		export
			{NONE} all
		redefine
			default_create
		end
	
	GB_WIDGET_UTILITIES
		export
			{NONE} all
		redefine
			default_create
		end
		
	GB_SHARED_SYSTEM_STATUS
		export
			{NONE} all
		redefine
			default_create
		end
		
	GB_GENERAL_UTILITIES
		export
			{NONE} all
		redefine
			default_create
		end
		
	GB_FILE_UTILITIES
		export
			{NONE} all
		redefine
			default_create
		end
		
	GB_COMMAND_HANDLER
		export
			{NONE} all
		redefine
			default_create
		end
		
	GB_CONSTANTS
		export
			{NONE} all
		redefine
			default_create
		end
		
	GB_NAMING_UTILITIES
		export
			{NONE} all
		redefine
			default_create
		end
		
	EV_KEY_CONSTANTS
		export
			{NONE} all
		redefine
			default_create
		end
	
	GB_SHARED_PREFERENCES	
		export
			{NONE} all
		redefine
			default_create
		end
		
	GB_SHARED_PIXMAPS
		export
			{NONE} all
		redefine
			default_create
		end
		
	EIFFEL_RESERVED_WORDS
		export
			{NONE} all
		redefine
			default_create
		end
		
	BUILD_RESERVED_WORDS
		export
			{NONE} all
		redefine
			default_create
		end
		
	GB_SHARED_CONSTANTS
		export
			{NONE} all
		redefine
			default_create
		end
		
	GB_SHARED_PIXMAPS
		export
			{NONE} all
		redefine
			default_create
		end
		
	GB_WINDOW_SELECTOR_COMMON_ITEM
		rename
			name as item_name
		redefine
			add_alphabetically, default_create
		end
		
feature {NONE} -- Implementation

	default_create is
			-- Create `Current' in correct default state.
		do
			create widget
			create children.make (50)
			widget.set_minimum_height (tool_minimum_height)
			widget.drop_actions.set_veto_pebble_function (agent veto_drop)
			widget.drop_actions.extend (agent add_new_object)			
			widget.key_press_actions.extend (agent check_for_object_delete)
			widget.select_actions.extend (agent update_select_root_window_command)
		end

feature -- Access

	widget: EV_TREE
		-- Widget representing `Current'.
	
	as_widget: EV_WIDGET is
			-- `Result' is widget representing `Current'.
		do
			Result := widget
		end	

	selected_window: GB_WINDOW_SELECTOR_ITEM is
			-- Window item currently selected or `Void' if none.
		do
			if widget.selected_item /= Void then
				Result := window_object_from_name (path_of_tree_node (widget.selected_item))
			end
		end
		
	selected_directory: GB_WINDOW_SELECTOR_DIRECTORY_ITEM is
			-- Directory item currently selected or `Void' if none.
		do
			if widget.selected_item /= Void then
				Result := directory_object_from_name (path_of_tree_node (widget.selected_item))
			end
		end
	
	new_directory_button: EV_TOOL_BAR_BUTTON is
			-- `Result' is a tool bar button that
			-- calls `add_new_directory'.
		local
			pixmaps: GB_SHARED_PIXMAPS
		do
			create Result
			Result.select_actions.extend (agent add_new_directory)
				-- Assign the appropriate pixmap.
			create pixmaps
			Result.set_pixmap (pixmaps.pixmap_by_name ("icon_new_cluster_small_color"))
			Result.set_tooltip ("New directory")
		ensure
			result_not_void: Result /= Void
		end
		
	expand_all_button: EV_TOOL_BAR_BUTTON is
			-- `Result' is a tool bar button that
			-- calls `add_new_directory'.
		local
			pixmaps: GB_SHARED_PIXMAPS
		do
			create Result
			Result.select_actions.extend (agent expand_tree_recursive (widget))
				-- Assign the appropriate pixmap.
			create pixmaps
			Result.set_pixmap (pixmaps.pixmap_by_name ("icon_expand_all_small_color"))
			Result.set_tooltip ("Expand all")
		ensure
			result_not_void: Result /= Void
		end
		
	objects: ARRAYED_LIST [GB_OBJECT] is
			-- `Result' is all objects represented in `Current'.
			-- No paticular order is guaranteed.
		do
			create Result.make (10)
			internal_return_objects (Current, Result)
		ensure
			result_not_void: Result /= Void
			position_not_changed: widget.index = old widget.index
		end
		
	tool_bar: EV_TOOL_BAR is
			-- A tool bar containing all buttons associated with `Current'.
		once
			create Result
			Result.extend (new_directory_button)
			Result.extend (expand_all_button)
			Result.extend (set_root_window_command.new_toolbar_item (True, False))
			Result.extend (include_directory_button)
			Result.extend (show_hide_empty_directories_button)
				-- If the children in `Result' is modified, must also update
				-- code for `update_select_root_window_command'.
		end
		
	include_directory_button: EV_TOOL_BAR_BUTTON is
			-- A button which is used to add all directories within the current
			-- directory structure to the current project.
		once
			create Result
			Result.set_pixmap (pixmap_by_name ("directory_search_small"))
			Result.select_actions.extend (agent include_all_directories)
			Result.set_tooltip ("Include all sub-directories")
		ensure
			result_not_void: result /= Void
		end
		
	show_hide_empty_directories_button: EV_TOOL_BAR_TOGGLE_BUTTON is
			-- A button used to show/hide all empty directories within `Current'.
		once
			create Result
			
			Result.set_pixmap (pixmap_by_name ("icon_show_hide_directory_color"))
			Result.select_actions.extend (agent show_hide_all_empty_directories)
			Result.set_tooltip ("Show/Hide all empty directories")
		end
		
		
	include_all_directories is
			-- Include all dirs reachable from the project location, to the current project
		do
			internal_include_all_directories (create {DIRECTORY}.make (system_status.current_project_settings.project_location), create {ARRAYED_LIST [STRING]}.make (5))			
		end

	update_select_root_window_command is
			-- Update status of root window button based on the currently selected window.
		local
			root_window_button: EV_TOOL_BAR_BUTTON
		do
			if not system_status.loading_project then
				root_window_button ?= tool_bar.i_th (3)
				check
					root_window_button_not_void: root_window_button /= Void
				end
				if selected_directory = Void and (selected_window /= Void and then
					(selected_window.object.type.is_equal (ev_titled_window_string) or
					selected_window.object.type.is_equal (ev_dialog_string)) and object_handler.root_window_object /= selected_window.object) then
					root_window_button.enable_sensitive
				else
					root_window_button.disable_sensitive
				end
			end
		end

	name: STRING is "Window Selector"
			-- Full name used to represent `Current'.

feature -- Status setting
		
	add_alphabetically (new_item: GB_WINDOW_SELECTOR_COMMON_ITEM) is
			-- Add `representation of `new_item' to `Current' alphabetically.
		local
			l_text: STRING
		do
				-- Note that we always go from the final position to the start. This is because if we are building
				-- a tree that is already in order we do not have to iterate all of the items  in a node to find
				-- out that it needs to be the final node. This will optimize the loading in Build as it should
				-- be saved in order.

			l_text := new_item.name.as_lower
			from
				children.go_i_th (children.count)
			until
				children.off or else children.item.name.as_lower < l_text 
			loop
				children.back
			end
			children.put_right (new_item)
			widget.go_i_th (children.index)
			widget.put_right (new_item.tree_item)
			new_item.set_parent (Current)
		end
		
feature {GB_DELETE_OBJECT_COMMAND} -- Basic operation

	remove_directory (a_directory: GB_WINDOW_SELECTOR_DIRECTORY_ITEM) is
			-- Remove `a_directory' from `Current'.
		require
			directory_not_void: a_directory /= Void
			has_directory: has_recursive (a_directory)
		local
			perform_delete: BOOLEAN
			all_objects: ARRAYED_LIST [GB_OBJECT]
			warning_dialog: STANDARD_DISCARDABLE_CONFIRMATION_DIALOG
			confirmation_dialog: EV_CONFIRMATION_DIALOG
		do
			perform_delete := True
			all_objects := objects
			if a_directory.recursive_check_all (agent selector_item_is_referenced) then
				create confirmation_dialog.make_with_text ("The directory struture of %"" + a_directory.name + "%" contains one or more objects that are still referenced by other objects within the system.%N%NDo you wish to continue deleting the directory, its contents and flatten all of these references?")
				confirmation_dialog.show_modal_to_window (parent_window (widget))
				if confirmation_dialog.selected_button.is_equal ((create {EV_DIALOG_CONSTANTS}).ev_ok) then
					a_directory.recursive_do_all (agent flatten_associated_instances)
					actual_delete_directory (a_directory)
				end
			elseif all_objects.count = a_directory.count and then Preferences.boolean_resource_value (preferences.Show_deleting_final_directory_warning, True) then
					-- If all of the objects in `Current' are contained in `a_directory' then prompt the user
					-- that the root window will be moved out of the directory, as you may not delete the
					-- root window.
				create warning_dialog.make_initialized (2, preferences.Show_deleting_final_directory_warning, "The directory contains the root window which will be moved from the directory.%NOther windows will be deleted. Are you sure that you wish to remove this directory?", "Do not show again, and always move root window from directory.")
				warning_dialog.set_icon_pixmap (Icon_build_window @ 1)
				warning_dialog.set_ok_action (agent actual_delete_directory (a_directory))
				warning_dialog.show_modal_to_window (parent_window (widget))

			elseif a_directory.count > 0 and then Preferences.boolean_resource_value (preferences.Show_deleting_directories_warning , True) then
					-- If the directory is not empty, then it does not matter if the root window is contained,
					-- as if we are here, we know that there are other window objects not contained in the directory,
					-- so just before the deletion, we can set one of these to be the root window.
				create warning_dialog.make_initialized (2, preferences.Show_deleting_directories_warning, "The directory %"" + a_directory.name + "%" contains one or more windows.%NAre you sure that you wish these windows to be deleted with the dialog?", "do not show again, and always delete windows contained.")
				warning_dialog.set_icon_pixmap (Icon_build_window @ 1)
				warning_dialog.set_ok_action (agent actual_delete_directory (a_directory))
				warning_dialog.show_modal_to_window (parent_window (widget))
			else
				actual_delete_directory (a_directory)
			end
		end
		
	selector_item_is_referenced (selector_item: GB_WINDOW_SELECTOR_COMMON_ITEM): BOOLEAN is
			-- Is `selector_item' a top level object that has instance referers?
		require
			selector_item_not_void: selector_item /= Void
		local
			window_selector_item: GB_WINDOW_SELECTOR_ITEM
		do
			window_selector_item ?= selector_item
			if window_selector_item /= Void then
				if not window_selector_item.object.instance_referers.is_empty then
					Result := True
				end
			end
		end
		
	flatten_associated_instances (selector_item: GB_WINDOW_SELECTOR_COMMON_ITEM) is
			-- Flatten all associated instances of `selector_item' if it is
			-- a window selector item and has instances.
		require
			selector_item_not_void: selector_item /= Void
		local
			window_selector_item: GB_WINDOW_SELECTOR_ITEM
			instance_referers: HASH_TABLE [INTEGER, INTEGER]
		do
			window_selector_item ?= selector_item
			if window_selector_item /= Void then
				check
					object_is_top_level_object: window_selector_item.object.is_top_level_object	
				end
				if not window_selector_item.object.instance_referers.is_empty then
					instance_referers := window_selector_item.object.instance_referers
					from
					until
						instance_referers.is_empty
					loop
						instance_referers.start
						object_handler.deep_object_from_id (instance_referers.item_for_iteration).flatten
					end
				end
			end
		end		

	actual_delete_directory (a_directory: GB_WINDOW_SELECTOR_DIRECTORY_ITEM) is
			-- Actually delete `a_directory' from system.
		require
			a_directory_not_void: a_directory /= Void
		local
			all_objects: ARRAYED_LIST [GB_OBJECT]
			directory_of_root_window: GB_WINDOW_SELECTOR_DIRECTORY_ITEM
			l_selected: GB_WINDOW_SELECTOR_ITEM
		do
			all_objects := objects
			if all_objects.count >= 1 then
				if all_objects.count = a_directory.count then
						-- Move the root window out of the directory, as it may not be deleted.
					add_new_object (object_handler.root_window_object)
				else
						-- If the currently selected window is contained within the structure of
						-- `a_directory', we must unselect it first to prevent us selecting windows
						-- multiple times each time we remove one that is contained in the structure.
					l_selected ?= selected_window
					if l_selected /= Void and then a_directory.has_recursive (l_selected) then
						l_selected.disable_select
							--| FIXME should really select next one after deselection completes rather
							--| than hiding/showing the builder windows.
						command_handler.Show_hide_builder_window_command.safe_disable_selected
						Command_handler.Show_hide_display_window_command.safe_disable_selected
					end
					directory_of_root_window ?= object_handler.root_window_object.window_selector_item.parent
					if directory_of_root_window /= Void and then directory_of_root_window = a_directory then
						-- We must now select the next root window in the tree, as the root window is contained in
						-- `a_directory'.
						mark_next_window_as_root (a_directory.count)
					end
				end
					
					-- Now actually perform the deletion of the directory, all of its sub directories and objects recursively.
				delete_objects_in_directory (a_directory)
			end

				-- Update project so it may be saved.
			system_status.enable_project_modified
			command_handler.update
		end
		
	delete_objects_in_directory (a_directory: GB_WINDOW_SELECTOR_DIRECTORY_ITEM) is
			-- Recursively delete all objects within `a_directory'.
		require
			a_directory_not_void: a_directory /= Void
		local
			current_directory_item: GB_WINDOW_SELECTOR_DIRECTORY_ITEM
			current_object_item: GB_WINDOW_SELECTOR_ITEM
			parent_directory: GB_WINDOW_SELECTOR_DIRECTORY_ITEM
			command_delete_directory: GB_COMMAND_DELETE_DIRECTORY
			directory_children: ARRAYED_LIST [GB_WINDOW_SELECTOR_COMMON_ITEM]
		do	
			from
				directory_children := a_directory.children
			until
				directory_children.is_empty
			loop
				directory_children.start
				current_directory_item ?= directory_children.item
				if current_directory_item /= Void then
					delete_objects_in_directory (current_directory_item)
				else
					current_object_item ?= directory_children.item
					check
						item_was_object: current_object_item /= Void
					end
					Command_handler.Delete_object_command.delete_object (current_object_item.object)	
				end
				-- Note that there is no need to traverse the directory as deleting
				-- the objects contained ensures that we always simply remove the first.
			end
			parent_directory ?= a_directory.parent
			create command_delete_directory.make (a_directory, parent_directory)
			command_delete_directory.execute
		ensure
			directory_empty: a_directory.children.is_empty
		end
	
feature {GB_COMMAND_DELETE_WINDOW_OBJECT, GB_COMMAND_ADD_WINDOW} -- Implementation
		
	mark_next_window_as_root (index_to_move: INTEGER) is
			-- Ensure that next window in `Current' (if any) is marked as root window.
		local
			original_root_index: INTEGER
			current_root_index, new_root_index: INTEGER
			titled_window_object: GB_TITLED_WINDOW_OBJECT
			all_objects: ARRAYED_LIST [GB_OBJECT]
		do
			all_objects := objects
			original_root_index := all_objects.index_of (object_handler.root_window_object, 1)
			if original_root_index + index_to_move <= all_objects.count then
				new_root_index := original_root_index + index_to_move
			else
				new_root_index := 1
			end
			from
				current_root_index := new_root_index
			until			
				titled_window_object /= Void or current_root_index = original_root_index
			loop
				titled_window_object ?= all_objects.i_th (current_root_index)
				current_root_index := current_root_index + 1
				if current_root_index > all_objects.count then
					current_root_index := 1
				end
			end
			check
				valid_state: (current_root_index /= original_root_index implies titled_window_object /= Void) and 
				(titled_window_object = Void implies original_root_index = current_root_index)
			end
			if titled_window_object /= Void then
				titled_window_object.set_as_root_window
			end
		end

feature {GB_WINDOW_SELECTOR_DIRECTORY_ITEM} -- Implementation

	add_new_object (an_object: GB_OBJECT) is
			-- Add an associated window item for `window_object'.
			-- Added at root level of `Current', not in a directory.
		require
			an_object_not_void: an_object /= Void
		local
			command_move_window: GB_COMMAND_MOVE_WINDOW
			command_add_window: GB_COMMAND_ADD_WINDOW
			window_object: GB_TITLED_WINDOW_OBJECT
			dialog: GB_NAMING_DIALOG
			all_top_level_names: HASH_TABLE [STRING, STRING]
			command_convert_to_top_level: GB_COMMAND_CONVERT_TO_TOP_LEVEL
		do
			create all_top_level_names.make (50)
			objects.do_all (agent add_object_name_to_hash_table (?, all_top_level_names))
			if an_object.window_selector_item = Void then
				create dialog.make_with_values (unique_name_from_hash_table (all_top_level_names, "my_" + an_object.short_type.as_lower), "New object", "Please specify the object name:", object_invalid_name_warning, agent check_new_object_name (an_object, ?))
				dialog.show_modal_to_window (parent_window (widget))
			end
			if dialog = Void or else not dialog.cancelled then
				if an_object.window_selector_item /= Void then
					if an_object.window_selector_item.parent /= Void then
							-- Do nothing if attempting to move from `Current' to `Current'.
						if an_object.window_selector_item.parent /= Current then
							create command_move_window.make (an_object, Void)
							command_move_window.execute
						end
					end
				else
					if an_object.layout_item = Void then
						window_object ?= an_object
						if window_object /= void then
							object_handler.add_new_window (window_object)
						else
							object_handler.add_new_object (an_object)
						end
						create command_add_window.make (an_object, Void)
						an_object.set_name (dialog.name.as_lower)
						command_add_window.execute
					else
						create command_convert_to_top_level.make (an_object, dialog.name.as_lower)
						command_convert_to_top_level.execute	
					end
				end
			end
				-- Update project so it may be saved.
			system_status.enable_project_modified
			command_handler.update
		ensure
--			count_increased: implies old an_object.layout_item = Void implies count = old count + 1
				-- Only if we were not moving internally as determined by whether the layout item
				-- is Void, as it will be when picked from the type selector.
				-- Also must now be implemented without `layout_item' as no longer always corresponds.
		end
		
	check_new_object_name (an_object: GB_OBJECT; a_name: STRING): BOOLEAN is
			-- Is `a_name' a valid name for new otp level object `an_object'?
		require
			an_object_not_void: an_object /= Void
			name_not_void: a_name /= Void
		do
			Result := valid_class_name (a_name) and not
				object_handler.name_in_use (a_name, an_object) and not
				(reserved_words.has (a_name.as_lower)) and not
				(build_reserved_words.has (a_name.as_lower) and not
				(Constants.all_constants.item (a_name) /= Void))
		end
		
		
feature {GB_COMMAND_MOVE_WINDOW} -- Implementation

	update_class_files_location (window_item: GB_WINDOW_SELECTOR_ITEM; an_original_directory, a_new_directory: GB_WINDOW_SELECTOR_DIRECTORY_ITEM) is
			-- Update generated classes of object associated with `window_item' for a move from `an_original_directory' to `new_directory'.
		require
			window_item_not_void: window_item /= Void
			-- `an_original_directory' and `a_new_directory' area allowed be Void if moving to/from the root.
		local
			original, new: FILE_NAME
			original_directory, new_directory: DIRECTORY
			original_path, new_path: ARRAYED_LIST [STRING]
		do
			create original.make_from_string (generated_path.string)
			original_directory := create {DIRECTORY}.make (original)
			if an_original_directory /= Void then
				original_path := an_original_directory.path
				from
					original_path.start
				until
					original_path.off
				loop
					original.extend (original_path.item)
					original_directory := create {DIRECTORY}.make (original)
					if not original_directory.exists then
						-- Ensure that the directory actually exists on disk.
						create_directory (original_directory)
					end
					original_path.forth
				end
			end
			create new.make_from_string (generated_path.string)
			new_directory := create {DIRECTORY}.make (new)
			if a_new_directory /= Void then
				new_path := a_new_directory.path
				from
					new_path.start
				until
					new_path.off
				loop
					new.extend (new_path.item)
					new_directory := create {DIRECTORY}.make (new)
					if not new_directory.exists then
							-- Ensure that the directory actually exists on disk.
						create_directory (new_directory)
					end
					new_path.forth
				end
			end
			
			move_file_between_directories (original_directory, new_directory, window_item.object.name.as_lower + ".e")
			move_file_between_directories (original_directory, new_directory, (window_item.object.name + Class_implementation_extension).as_lower + ".e")
		end
		
feature {GB_WINDOW_SELECTOR_COMMON_ITEM} -- Implementation

	update_for_removal (a_window_item: GB_WINDOW_SELECTOR_ITEM) is
			-- Update `Current' to reflect a removal of `a_window_item'.
		require
			a_window_item_not_void: a_window_item /= Void
			a_window_item_contained: has_recursive (a_window_item)
		local
			all_objects: ARRAYED_LIST [GB_OBJECT]
			current_index: INTEGER
			next_object: GB_OBJECT
			window_object: GB_OBJECT
		do
			
				-- If `a_window_item' is selected, the next item
				-- in `Current' must be selected.
			if selected_window = a_window_item then
				window_object := a_window_item.object
				all_objects := objects
				check
					a_window_item_still_contained: all_objects.has (window_object)
				end
				current_index := all_objects.index_of (window_object, 1)
				if all_objects.count > 1 then
					current_index := current_index + 1
					if current_index > all_objects.count then
						current_index := 1
					end
					next_object ?= all_objects.i_th (current_index)
					next_object.window_selector_item.enable_select
				end
					-- Now must check to see if there are any windows.
					-- If not, the display and builder windows must be hidden.
				if all_objects.count = 1 then
					check
						removal_consistent: all_objects.first = window_object
					end
					command_handler.Show_hide_builder_window_command.safe_disable_selected
					Command_handler.Show_hide_display_window_command.safe_disable_selected
				end
				Command_handler.update
			end			
		end
		
	selected_window_changed (selector_item: GB_WINDOW_SELECTOR_ITEM) is
			-- `selector_item' has become selected so we must update
			-- `layout_constructor'. Do nothing if a project is loading.
		require
			selector_item_not_void: selector_item /= Void
		local
			root_window_object: GB_OBJECT
		do
			if not System_status.loading_project then
				root_window_object := selector_item.object
					-- Only change the selected item, if a project is not loading.
				layout_constructor.set_root_window (root_window_object)
				
				update_display_and_builder_windows (root_window_object)
			
				if parent_window (Layout_constructor) /= Void then
						-- Protect against a selection being fired before
						-- `layout_constructor' is parented.
					layout_constructor.first.enable_select
				end
				Command_handler.update
			end
		end
		
feature {GB_WINDOW_SELECTOR_COMMON_ITEM} -- Implementation

	item_added_to_directory (directory, new_item: GB_WINDOW_SELECTOR_COMMON_ITEM) is
			-- `new_item' has been added to `directory' so ensure all nodes are highlighted.
		require
			directory_not_void: directory /= Void
			new_item_not_void: new_item /= Void
			directory_has_new_item: directory.children.has (new_item)
		local
			parent_directory, last_parent: GB_WINDOW_SELECTOR_DIRECTORY_ITEM
			window: GB_WINDOW_SELECTOR_ITEM
		do
			window ?= new_item
			if window /= Void then
					-- Only update directories if the item added was a window, and not a directory.
					-- As we know all directories from `Current' up to `directory' must be highlighted
					-- we simply traverse and update these.
				from
					parent_directory ?= directory	
				until
					parent_directory = Void		
				loop
					if parent_directory.is_grayed_out then
						parent_directory.display_in_color
						if parent_directory.tree_item.parent = Void then
								-- This ensures that if we are adding to a directory whose tree item is not displayed in
								-- the tree, it is once again parented in the tree. This occurs in the case where you delete the final
								-- top level object within a directory, hide all gray directories and then undo the delete. As
								-- the directory is no longer gray, it must be re-parented.
							add_to_tree_node_alphabetically (parent_directory.parent.tree_item, parent_directory.tree_item)
						end
					end
					last_parent := parent_directory
					parent_directory ?= parent_directory.parent
				end
			end
		end
		
	item_removed_from_directory (directory: GB_WINDOW_SELECTOR_COMMON_ITEM; item_for_removal: GB_WINDOW_SELECTOR_COMMON_ITEM) is
			-- `item_for_removal' has been removed from `directory' so update directories to reflect this.
		require
			directory_not_void: directory /= Void
			item_for_removal_not_void: item_for_removal /= Void
			item_for_removal_not_parented: item_for_removal.parent = Void
		local
			all_branch_nodes: ARRAYED_LIST [GB_WINDOW_SELECTOR_DIRECTORY_ITEM]
			top_node, tree_node: GB_WINDOW_SELECTOR_COMMON_ITEM
			directory_item: GB_WINDOW_SELECTOR_DIRECTORY_ITEM
		do
			main_window.lock_update
			create all_branch_nodes.make (20)
			top_node ?= directory
				-- Firstly retrieve the root node associated with `directory'.
			from
			until
				top_node.parent = window_selector or top_node.parent = Void
			loop
				top_node ?= top_node.parent
			end
			
				-- Now retrieve a list of all end nodes that contain children. 
			retrieve_all_branch_nodes (top_node, all_branch_nodes)
			
				-- Gray out all nodes recursively from `top_node'.
			top_node.recursive_do_all (agent gray_node)
			gray_node (top_node)
			
				-- Now highlight all nodes from `top_node' down to each item within `all_branch_nodes'.
			from
				all_branch_nodes.start
			until
				all_branch_nodes.off
			loop
				from
						-- Start at the current branch node
					tree_node := all_branch_nodes.item
				until
						-- We have traversed the structure from the branch node to the root of the tree.
					tree_node = window_selector
				loop
					directory_item ?= tree_node
					check
						node_was_directory: directory_item /= Void
					end
						-- Add color to the node if not already colored. We may
						-- visit the same node multiple times, as different branch nodes may have the
						-- same nodes within their path.
					if directory_item.is_grayed_out then	
						directory_item.display_in_color
					end
					tree_node ?= tree_node.parent
				end
				
				all_branch_nodes.forth
			end
			main_window.unlock_update
		end
		
	gray_node (node: GB_WINDOW_SELECTOR_COMMON_ITEM) is
			-- Ensure `display_in_gray' is called on `node' it is of type GB_WINDOW_SELECTOR_DIRECTORY_ITEM.
		require
			node_not_void: NODE /= Void
		local
			directory_item: GB_WINDOW_SELECTOR_DIRECTORY_ITEM
		do
			directory_item ?= node
			if directory_item /= Void then
				directory_item.display_in_gray
			end
		end
		
	retrieve_all_branch_nodes (tree_node: GB_WINDOW_SELECTOR_COMMON_ITEM; all_branch_nodes: ARRAYED_LIST [GB_WINDOW_SELECTOR_COMMON_ITEM]) is
			-- For all items recursively in `tree_node' add all final directory nodes in the tree that contain items
			-- that are not directories to `all_branch_nodes'. These are the nodes that must be highlighted.
		require
			tree_node_not_void: tree_node /= Void
			all_branch_nodes_not_void: all_branch_nodes /= Void
		local
			current_item: GB_WINDOW_SELECTOR_COMMON_ITEM
			window_item: GB_WINDOW_SELECTOR_ITEM
			l_children: ARRAYED_LIST [GB_WINDOW_SELECTOR_COMMON_ITEM]
		do
			l_children := tree_node.children
			from
				l_children.start
			until
				l_children.off
			loop
				current_item := l_children.item
				if current_item.count = 0 then
					window_item ?= current_item
					if window_item /= Void then
						all_branch_nodes.extend (window_item.parent)
					end
				else
					retrieve_all_branch_nodes (current_item, all_branch_nodes)
				end
				l_children.forth
			end
		end

feature {GB_COMMAND_NAME_CHANGE} -- Implementation

	generated_path: FILE_NAME is
			-- `Result' is generated directory for current project.
		do
			create Result.make_from_string (system_status.current_project_settings.project_location)
		ensure
			result_not_void: Result /= Void
		end

	update_class_files_of_window (object: GB_OBJECT; old_name, new_name: STRING) is
			-- Rename generated files representing `object' to reflect a name change on `window_object'
			-- from `old_name' to `new_name'.
		require
			object_not_void: object /= Void
			names_not_void: old_name /= Void and new_name /= Void
			names_not_empty: not old_name.is_empty and not new_name.is_empty
			object_is_top_level_object: object.is_top_level_object
		local
			directory_object: GB_WINDOW_SELECTOR_DIRECTORY_ITEM
			file_name, interface_file_name, implementation_file_name: FILE_NAME
			l_eiffel_parser: EIFFEL_PARSER
			l_class_as: CLASS_AS
			l_visitor: NAME_CHANGE_VISITOR
			file: RAW_FILE
			file_contents: STRING
			character_difference: INTEGER
			directory_path: ARRAYED_LIST [STRING]
		do
			directory_object ?= object.window_selector_item.parent
			file_name := generated_path
			if directory_object /= Void then
				directory_path := directory_object.path
				from
					directory_path.start
				until
					directory_path.off
				loop
					file_name.extend (directory_path.item)
					directory_path.forth
				end
			end
			
				--| FIXME we need a better solution for name changes on windows.
				--| as undo allows their name to become empty.
			if not (new_name.is_empty or old_name.is_empty) then
				
					-- Build file names for accessing files.
				interface_file_name := file_name.twin
				interface_file_name.extend (new_name + ".e")
				implementation_file_name := file_name.twin
				implementation_file_name.extend (new_name + Class_implementation_extension.as_lower + ".e")
				
				create l_eiffel_parser.make
				
				rename_file_if_exists (create {DIRECTORY}.make (file_name), old_name + ".e", new_name + ".e")
				
					-- Now parse the contents of the file, and change the class name, and inherited
					-- name.
				create file.make (interface_file_name.string)
				if file.exists then
					file.open_read
					file.read_stream (file.count)
					file.close
					file_contents := file.last_string
					l_eiffel_parser.parse_from_string (file_contents)
					l_class_as := l_eiffel_parser.root_node
					create l_visitor
					l_class_as.process (l_visitor)
					file_contents.replace_substring (new_name.as_upper, l_visitor.name_start_position + 1, l_visitor.name_end_position)
					
						-- As we are performing two replaces,we must update the character indexes of the second, by the difference
						-- in characters between what was replaced, and the new string of the first replacement.
					character_difference := old_name.count - new_name.count
					file_contents.replace_substring ((new_name + Class_implementation_extension).as_upper,
						l_visitor.parent_start_position + 1 - character_difference, l_visitor.parent_end_position - character_difference)
						
						-- Now replace the class name at end after comment.
					replace_final_class_name_comment (file_contents, old_name.as_upper, new_name.as_upper)
						
						-- Open the file, and write the contents back.
					file.open_write
					file.put_string (file_contents)
					file.close
				end
					
			
				rename_file_if_exists (create {DIRECTORY}.make (file_name), old_name + Class_implementation_extension.as_lower + ".e",
					new_name + Class_implementation_extension.as_lower + ".e")
					
					-- Now parse the contents of the file, and change the class name, and inherited
					-- name.
				create file.make (implementation_file_name.string)
				if file.exists then
					file.open_read
					file.read_stream (file.count)
					file.close
					file_contents := file.last_string
					l_eiffel_parser.parse_from_string (file_contents)
					l_class_as := l_eiffel_parser.root_node
					create l_visitor
					l_class_as.process (l_visitor)
					file_contents.replace_substring ((new_name + Class_implementation_extension).as_upper, l_visitor.name_start_position + 1, l_visitor.name_end_position)
						
	
						-- Now replace the class name at end after comment.
					replace_final_class_name_comment (file_contents, (old_name + Class_implementation_extension).as_upper, (new_name + Class_implementation_extension).as_upper)
					file.open_write
					file.put_string (file_contents)
					file.close
				end
			end
		end

feature {GB_XML_LOAD, GB_XML_IMPORT} -- Implementation

	update_displayed_names is
			-- Update names of all selector items (excluding directories)
			-- based on their objects.
		do
			widget.recursive_do_all (agent update_name_of_item)
		end
		
	select_main_window is
			-- Select window marked as root of system.
		local
			object: GB_TITLED_WINDOW_OBJECT
		do
			object := Object_handler.root_window_object
			check
				object_is_top_level: object.is_top_level_object
			end
			object.set_as_root_window
			object.window_selector_item.enable_select

			Layout_constructor.set_root_window (object)
			update_display_and_builder_windows (object)
		end

feature {GB_COMMAND_ADD_WINDOW, GB_COMMAND_DELETE_WINDOW_OBJECT} -- Implementation

	change_root_window_to (titled_window_object: GB_TITLED_WINDOW_OBJECT) is
			-- Change the root window of the project to `titled_window_object'.
		require
			titled_window_object_not_void: titled_window_object /= Void
		do
			titled_window_object.set_as_root_window
				-- Update project so it may be saved.
			system_status.enable_project_modified
			command_handler.update
		ensure
			root_window_set: object_handler.root_window_object = titled_window_object
		end
		
feature {NONE} -- Implementation

	update_name_of_item (node: EV_TREE_NODE) is
			-- If `node' is a selector item, update its `text'.
		local
			window_item: GB_WINDOW_SELECTOR_ITEM
		do
			window_item ?= node
			if window_item /= Void then
				window_item.tree_item.set_text (name_and_type_from_object (window_item.object))
			end
		end
		
feature {GB_OBJECT_HANDLER} -- Implementation

	set_item_for_prebuilt_window (window_object: GB_OBJECT) is
			-- Add an associated window item for `window_object' in `Current'.
			-- `window_object' must be a completely built object.
		require
			window_object_not_void: window_object /= Void
			is_completely_built: window_object.layout_item /= Void
		local
			selector_item: GB_WINDOW_SELECTOR_ITEM
		do
			create selector_item.make_with_object (window_object)
		end

feature {GB_COMMAND_DELETE_DIRECTORY} -- Implementation
	
	silent_add_named_directory (directory_name: ARRAYED_LIST [STRING]) is
			-- Add a new directory named `directory_name' to `Current',
			-- but do not mark it as a command, simply add a new item in `Current'.
			-- This will be called by `undo' of GB_COMMAND_DELETE_DIRECTORY and
			-- must not affect the command history.
		require
			name_valid: directory_name /= Void and not directory_name.is_empty
		local
			directory_item: GB_WINDOW_SELECTOR_DIRECTORY_ITEM
			parent_directory: GB_WINDOW_SELECTOR_DIRECTORY_ITEM
			parent_name: ARRAYED_LIST [STRING]
		do
			create directory_item.make_with_name (directory_name.i_th (directory_name.count))
			if directory_name.count = 1 then
				add_alphabetically (directory_item)
			else
				parent_name := directory_name.twin
				parent_name.prune_all (parent_name.last)
				parent_directory := directory_object_from_name (parent_name)
				check
					parent_directory_found: parent_directory /= Void
				end
				parent_directory.add_alphabetically (directory_item)
			end
				-- Update project so it may be saved.
			system_status.enable_project_modified
			command_handler.update
		ensure
			--count_increaed: count = old count + 1
		end
		
feature {GB_XML_LOAD} -- Implementation

	mark_first_window_as_root is
			-- Ensure first window in `Current' is marked as
			-- the root window for the project.
		require
			objects_not_empty: not objects.is_empty
		local
			l_objects: ARRAYED_LIST [GB_OBJECT]
			found_window_object: GB_TITLED_WINDOW_OBJECT
		do
			l_objects := objects
			from
				l_objects.start
			until
				l_objects.off or found_window_object /= Void
			loop
				found_window_object ?= l_objects.item
				l_objects.forth
			end
			if found_window_object /= Void then
				change_root_window_to (found_window_object)
			end
		ensure
			has_root_window_if_not_empty: Object_handler.root_window_object /= Void
		end
		
feature {GB_SET_ROOT_WINDOW_COMMAND}		
		
	change_root_window is
			-- Ensure that the window selected in the layout constructor is the
			-- root window of the project.
		local
			layout_constructor_item: GB_LAYOUT_CONSTRUCTOR_ITEM
			titled_window_object: GB_TITLED_WINDOW_OBJECT
		do
			layout_constructor_item := Layout_constructor.root_item
			titled_window_object ?= layout_constructor_item.object
			check
				root_object_was_window: titled_window_object /= Void
			end
			titled_window_object.set_as_root_window
				-- Update project so it may be saved.
			system_status.enable_project_modified
			command_handler.update
		end

feature {NONE} -- Implementation

	all_deleted_directories: HASH_TABLE [STRING, STRING]
		-- All directory names that have been deleted. A user may not enter 

	add_new_directory is
			-- Display a dialog for inputting a new name, that is only valid if
			-- not contained in `directory_names'. Create a new dialog
			-- from the name as entered by the user.
		local
			dialog: GB_NAMING_DIALOG
			command_add_directory: GB_COMMAND_ADD_DIRECTORY
			last_dialog_name: STRING
			retried: BOOLEAN
			l_selected_directory: GB_WINDOW_SELECTOR_DIRECTORY_ITEM
			l_directory_names: ARRAYED_LIST [STRING]
		do
			if retried then
					-- We do not rebuild the dialog, as using the previous one
					-- retains its position on screen.
				dialog.show_actions.wipe_out
				dialog.show_actions.extend (agent show_invalid_directory_warning (dialog, last_dialog_name))
			else
				l_selected_directory := selected_directory
				if l_selected_directory = Void then
					-- We are adding to the root of `Current'
					l_directory_names := directory_names
				else
					l_directory_names := l_selected_directory.directory_names
				end
				create dialog.make_with_values (unique_name_from_array (l_directory_names, "directory"), "New directory", "Please specify the directory name:"," is an invalid directory name.%N%NPlease ensure that it is not in use,%Nand is valid for the current platform.", agent valid_directory_name (?, selected_directory))
				dialog.set_icon_pixmap (Icon_build_window @ 1)
			end
			
			dialog.show_modal_to_window (parent_window (widget))
			
			if not dialog.cancelled then
				last_dialog_name := dialog.name
				if selected_directory /= Void then
					create command_add_directory.make (selected_directory, last_dialog_name)
				else
					create command_add_directory.make (Void, last_dialog_name)
				end
				command_add_directory.create_new_directory
				if command_add_directory.directory_added_succesfully then
					command_add_directory.execute
					system_status.enable_project_modified
					command_handler.update	
				end
			end
		rescue
			retried := True
			retry
		end
		
	show_invalid_directory_warning (a_dialog: EV_DIALOG; last_dialog_name: STRING) is
			-- Show a warning dialog modal to `a_dialog', indicating that `last_dialog_name'
			-- was not a valid directory name.
		require
			dialog_not_void: a_dialog /= Void
			last_dialog_name_not_void: last_dialog_name /= Void
		local
			warning_dialog: EV_WARNING_DIALOG
			actual_warning: STRING
		do
			if last_dialog_name.is_empty then
				actual_warning := "You have not entered a name."
			else
				actual_warning := "The directory name '" + last_dialog_name + "' is not valid."
			end
			create warning_dialog.make_with_text (actual_warning + "%N%NPlease enter a valid directory name.")
			warning_dialog.set_icon_pixmap (Icon_build_window @ 1)
			warning_dialog.show_modal_to_window (a_dialog)
		end

	valid_directory_name (a_name: STRING; parent_item: GB_WINDOW_SELECTOR_DIRECTORY_ITEM): BOOLEAN is
			-- Is `a_name' a valid name for a new directory in `parent_item' or `Current' if
			-- `parent_item' is Void?
		require
			a_name_not_void: a_name /= Void
		do
			if parent_item = Void then
				Result := not directory_names.has (a_name)
			else
				Result := not parent_item.directory_names.has (a_name)
			end
		end
		
	update_display_and_builder_windows (an_object: GB_OBJECT) is
			-- Update windows referenced by `builder_window' and `display_window' to
			-- reflect `titled_window_object'.
		require
			object_not_void: an_object /= Void
		local
			display_win: GB_DISPLAY_WINDOW
			builder_win: GB_BUILDER_WINDOW
			builder_shown, display_shown: BOOLEAN
			titled_window_object: GB_TITLED_WINDOW_OBJECT
			a_widget: EV_WIDGET
			display_object: GB_DISPLAY_OBJECT
		do
				-- There should be no need to check that the window has not already changed,
				-- but it appears when selecting windows in the window selector, this
				-- feature is called twice. This check reduces the flicker of hiding and showing
				-- the same window twice.
			titled_window_object ?= an_object
			if titled_window_object /= Void then
				a_widget ?= titled_window_object.object
			else
				a_widget ?= an_object.object
			end
			check
				a_widget_not_void: a_widget /= Void
			end
			
			if (titled_window_object /= Void and then a_widget /= display_window) or (a_widget.parent /= display_window) then

				-- Firstly hide the existing windows if shown
			if builder_window.is_displayed then
				command_handler.show_hide_builder_window_command.execute
				builder_shown := True
			end
			if display_window.is_displayed then
				command_handler.Show_hide_display_window_command.execute
				display_shown := True
			end

				-- Then set the new windows.
			if titled_window_object /= Void then
				display_win ?= a_widget
			else
				display_win ?= a_widget.parent
			end
			check
				display_win_not_void: display_win /= Void
			end
			set_display_window (display_win)
			if titled_window_object /= Void then
				if titled_window_object.display_object /= Void then
					builder_win ?= titled_window_object.display_object.child
					check
						display_object_item_is_window: builder_win /= Void
					end
					set_builder_window (builder_win)
				end
			else
				if an_object.display_object /= Void then
					display_object ?= an_object.display_object
						-- `display_object' may be Void when the type of widget is a primitive
						-- as it is simply an instance of EV_WIDGET instead of GB_DISPLAY_OBJECT.
					if display_object /= Void then
						builder_win ?= display_object.parent
						check
							builder_win_found: builder_win /= Void
						end
						set_builder_window (builder_win)
					else
						a_widget ?= an_object.display_object
						check
							display_object_was_widget: a_widget /= Void
							widget_has_parent: a_widget.parent /= Void
						end
						builder_win ?= a_widget.parent
						check
							parent_was_builder_window: builder_win /= Void
						end
						set_builder_window (builder_win)
					end
				end
			end

			if builder_shown then
				command_handler.Show_hide_builder_window_command.execute
			end
			if display_shown then
				Command_handler.Show_hide_display_window_command.execute
			end
					-- Force the newly displayed window to redraw immediately.
				((create {EV_ENVIRONMENT}).application).process_events
			end
		end

	veto_drop (an_object: GB_OBJECT): BOOLEAN is
			-- Veto drop of `an_object'.
		local
			type: STRING
		do
			type := an_object.generating_type
				-- Any object except items may be inserted, as long as it has not already
				-- been created. `object' is Void until an obejct is fully
				-- created and in the system. While picking from the type selector,
				-- `object' is still Void.
				-- Note that checked for `_ITEM' is a quick method of determining if
				-- an item is represented.
			Result := type.substring_index ("_ITEM_", 1) = 0
				and type.substring_index ("MENU", 1) = 0
				and an_object.associated_top_level_object = 0
		end
		
	check_for_object_delete (a_key: EV_KEY) is
			-- Respond to keypress of `a_key' and delete selected object.
		require
			a_key_not_void: a_key /= Void
		local
			warning_dialog: STANDARD_DISCARDABLE_CONFIRMATION_DIALOG
		do
			if a_key.code = Key_delete and widget.selected_item /= Void then
				if selected_window /= Void then
						-- Only perform deletion if delete key pressed, and a
						-- window object was selected.
					if Preferences.boolean_resource_value (preferences.show_deleting_keyboard_warning, True) then
						create warning_dialog.make_initialized (2, preferences.show_deleting_keyboard_warning, delete_warning1 + "window object" + delete_warning2, delete_do_not_show_again)
						warning_dialog.set_icon_pixmap (Icon_build_window @ 1)
						warning_dialog.set_ok_action (agent delete_object (selected_window.object))
						warning_dialog.show_modal_to_window (parent_window (widget))
					else
						delete_object (selected_window.object)
					end
				elseif selected_directory /= Void then
						-- There is a single case that slips through the net. If you have disabled both the non empty directory and
						-- directory containing the root window, then you will no longer get the "show_deleting_keyboard_warning"
						-- when deleting non empty directories. Julian. This seems a real pain, and I do not believe anybody will
						-- ever notice this, as why would they remove the others, but not this one which is the first.
					if selected_directory.count = 0 then
						if Preferences.boolean_resource_value (preferences.Show_deleting_keyboard_warning, True) then
							create warning_dialog.make_initialized (2, preferences.show_deleting_keyboard_warning, delete_warning1 + "directory object" + delete_warning2, delete_do_not_show_again)
							warning_dialog.set_icon_pixmap (Icon_build_window @ 1)
							warning_dialog.set_ok_action (agent remove_directory (selected_directory))
							warning_dialog.show_modal_to_window (parent_window (widget))
						else
							remove_directory (selected_directory)
						end
					else
						remove_directory (selected_directory)
					end
				end
			end
		end
		
	delete_object (an_object: GB_OBJECT) is
			-- Delete selected object.
		require
			an_object_not_void: an_object /= Void
			an_object_is_top_level_object: an_object.is_top_level_object
		local
			delete_window_object_command: GB_COMMAND_DELETE_WINDOW_OBJECT
		do
			create delete_window_object_command.make (an_object)
			delete_window_object_command.execute
		end
		
	add_object_name_to_hash_table (an_object: GB_OBJECT; hash_table: HASH_TABLE [STRING, STRING]) is
			-- Add `name' of `an_object' to `hash_table' as both key and corresponding item.
		require
			an_object_not_void: an_object /= Void
			hash_table_not_void: hash_table /= Void
		do
			hash_table.extend (an_object.name, an_object.name)
		ensure
			object_name_contained: hash_table.item (an_object.name) /= Void and then hash_table.item (an_object.name) = an_object.name
		end
		
	internal_return_objects (window_selector_item: GB_WINDOW_SELECTOR_COMMON_ITEM; list: ARRAYED_LIST [GB_OBJECT]) is
			-- For all items in `node_list' recursively, add a GB_OBJECT to `list' if the
			-- item is an instance of GB_WINDOW_SELECTOR_ITEM.
		require
			window_selector_item_not_void: window_selector_item /= Void
			list_not_void: list /= Void
		local
			window_item: GB_WINDOW_SELECTOR_ITEM
			l_children: ARRAYED_LIST [GB_WINDOW_SELECTOR_COMMON_ITEM]
			l_cursor: CURSOR
		do
			l_children := window_selector_item.children
			l_cursor := l_children.cursor
			from
				l_children.start
			until
				l_children.off
			loop
				window_item ?= l_children.item
				if window_item /= Void then
					list.extend (window_item.object)
				end
				internal_return_objects (l_children.item, list)
				l_children.forth
			end
			l_children.go_to (l_cursor)
		ensure
			position_not_changed: widget.index = old widget.index
		end
		
	internal_include_all_directories (directory: DIRECTORY; represented_path: ARRAYED_LIST [STRING]) is
			-- Include all dirs reachable from the project location, to the current project
		require
			directory_not_void: directory /= Void
			directory_exists: directory.exists
			represented_path_not_void: represented_path /= Void
		local
			iterated_directory: DIRECTORY
			file_name: FILE_NAME
			items: LINEAR [STRING]
			command_add_directory: GB_COMMAND_ADD_DIRECTORY
			parent_path: ARRAYED_LIST [STRING]
			directory_item: GB_WINDOW_SELECTOR_DIRECTORY_ITEM
		do
			items := directory.linear_representation
			from
				items.start
			until
				items.off
			loop
				create file_name.make_from_string (directory.name)
				file_name.extend (items.item)
				create iterated_directory.make (file_name)
				if iterated_directory.exists and not items.item.is_equal (".") and not items.item.is_equal ("..") then
						-- Set the parent path before we add the current item to `represented_path'.
					parent_path := represented_path.twin
					represented_path.extend (items.item)
					if tree_item_matching_path (window_selector.widget, represented_path) = Void then
						if parent_path.is_empty then
								-- We are at the root level.
							directory_item := Void
						else
							if parent_path.count = 1 and parent_path.i_th (1).is_equal ("EIFGEN") then
								do_nothing
							end
								-- Retrieve the directory_item matching `parent_path' within `window_selector'.
							directory_item := window_selector.directory_object_from_name (parent_path)--directory_item ?= tree_item_matching_path (window_selector, parent_path)
						end
						create command_add_directory.make (directory_item, items.item)
						command_add_directory.supress_warnings
						command_add_directory.create_new_directory
						if command_add_directory.directory_added_succesfully then
							command_add_directory.execute
							system_status.enable_project_modified
							command_handler.update
						end
					end
					internal_include_all_directories (iterated_directory, represented_path)
				end
				items.forth
			end
			if not represented_path.is_empty then
					-- Restore `represented_path' as we are about to go back up a level if nested.
				represented_path.prune_all (represented_path.last)
			end
		end
		
	show_hide_all_empty_directories is
			-- Show/hide all empty directories in project based on state of `show_hide_empty_directories_button'.
		do
			if show_hide_empty_directories_button.is_selected then
				recursive_do_all (agent internal_hide_directory)
			else
				recursive_do_all (agent internal_show_directory)
			end
		end
		
	internal_hide_directory (selector_item: GB_WINDOW_SELECTOR_COMMON_ITEM) is
			-- Ensure that `selector_item' is hidden in `Current'.
		require
			selector_item_not_void: selector_item /= Void
		local
			directory: GB_WINDOW_SELECTOR_DIRECTORY_ITEM
		do
			directory ?= selector_item
			if directory /= Void then
				if directory.is_grayed_out and directory.tree_item.parent /= Void then
					directory.tree_item.parent.prune_all (directory.tree_item)
				end
			end
		end
		
	internal_show_directory (selector_item: GB_WINDOW_SELECTOR_COMMON_ITEM) is
			-- Ensure that `selector_item' is visible in `Current'.
		require
			selector_item_not_void: selector_item /= Void
		local
			directory: GB_WINDOW_SELECTOR_DIRECTORY_ITEM
		do
			directory ?= selector_item
			if directory /= Void then
				if directory.tree_item.parent = Void then
					if directory.parent.tree_item /= Void then
						add_to_tree_node_alphabetically (directory.parent.tree_item, directory.tree_item)
					else
						check
							parent_is_window_selector: directory.parent = window_selector
						end
						add_to_tree_node_alphabetically (window_selector.widget, directory.tree_item)
					end
				end
			end
		end
		
end -- class GB_WINDOW_SELECTOR
