indexing
	description:
		"[
			Objects that allow a user to select/manipulate all the widgets in a project.
			Each item contained will be generated as a seperate class.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	GB_WIDGET_SELECTOR

inherit

	GB_STORABLE_TOOL
		redefine
			default_create, as_widget
		end

	GB_WIDGET_UTILITIES
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

	GB_SHARED_PIXMAPS
		export
			{NONE} all
		redefine
			default_create
		end

	GB_WIDGET_SELECTOR_COMMON_ITEM
		rename
			name as item_name
		redefine
			add_alphabetically, default_create
		end

create
	make_with_components

feature {NONE} -- Initialization

	make_with_components (a_components: GB_INTERNAL_COMPONENTS) is
			-- Create `Current' and assign `a_components' to `components'.
		require
			a_components_not_void: a_components /= Void
		do
			components := a_components
			default_create
		ensure
			components_set: components = a_components
		end

feature {NONE} -- Implementation

	default_create is
			-- Create `Current' in correct default state.
		do
			create widget
			common_make
			create tool_bar.make_with_widget_selector (Current, components)
			widget.set_minimum_height (tool_minimum_height)
			widget.drop_actions.set_veto_pebble_function (agent veto_object_drop)
			widget.drop_actions.extend (agent handle_object_drop (?, Current))
			widget.drop_actions.extend (agent add_new_directory_direct)
			widget.key_press_actions.extend (agent check_for_object_delete)
			widget.select_actions.extend (agent tool_bar.update_select_root_window_command)
			widget.focus_in_actions.extend (agent (components.commands).update)
			widget.focus_out_actions.extend (agent (components.commands).update)
			widget.select_actions.extend (agent (components.commands).update)
		end

feature -- Access

	widget: EV_TREE
		-- Widget representing `Current'.

	as_widget: EV_WIDGET is
			-- `Result' is widget representing `Current'.
		do
			Result := widget
		end

	selected_window: GB_WIDGET_SELECTOR_ITEM is
			-- Window item currently selected or `Void' if none.
		do
			if widget.selected_item /= Void then
				Result := window_object_from_name (path_of_tree_node (widget.selected_item))
			end
		end

	selected_directory: GB_WIDGET_SELECTOR_DIRECTORY_ITEM is
			-- Directory item currently selected or `Void' if none.
		do
			if widget.selected_item /= Void then
				Result := directory_object_from_name (path_of_tree_node (widget.selected_item))
			end
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

	tool_bar: GB_WIDGET_SELECTOR_TOOL_BAR
			-- A tool bar containing all buttons associated with `Current'.

	name: STRING is "Widget Selector"
			-- Full name used to represent `Current'.

	has_focus: BOOLEAN is
			-- Does `Current' have focus?
		do
			Result := widget.has_focus
		end

feature -- Status setting

	add_alphabetically (new_item: GB_WIDGET_SELECTOR_COMMON_ITEM) is
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
			add_to_tree_node_alphabetically (widget, new_item.tree_item)
			new_item.set_parent (Current)
		end

feature {GB_DELETE_OBJECT_COMMAND} -- Basic operation

	remove_directory (a_directory: GB_WIDGET_SELECTOR_DIRECTORY_ITEM) is
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
				create confirmation_dialog.make_with_text ("The directory structure of %"" + a_directory.name + "%" contains one or more objects that are still referenced by other objects within the system.%NTo examine the current references of an object, open the client node of the object's representation within the Widget Selector.%N%NDo you wish to continue deleting the directory, its contents and flatten all of these references?")
				confirmation_dialog.set_icon_pixmap (icon_build_window @ 1)
				confirmation_dialog.set_title ("Object still referenced")
				confirmation_dialog.show_modal_to_window (parent_window (widget))
				if confirmation_dialog.selected_button.is_equal ((create {EV_DIALOG_CONSTANTS}).ev_ok) then
					a_directory.recursive_do_all (agent flatten_associated_instances)
					actual_delete_directory (a_directory)
				end
			elseif all_objects.count = a_directory.count and then preferences.dialog_data.show_deleting_final_directory_warning then
					-- If all of the objects in `Current' are contained in `a_directory' then prompt the user
					-- that the root window will be moved out of the directory, as you may not delete the
					-- root window.
				create warning_dialog.make_initialized (2, preferences.dialog_data.show_deleting_final_directory_warning_string, "The directory contains the root window which will be moved from the directory.%NOther windows will be deleted. Are you sure that you wish to remove this directory?", "Do not show again, and always move root window from directory.", preferences.preferences)
				warning_dialog.set_icon_pixmap (Icon_build_window @ 1)
				warning_dialog.set_ok_action (agent actual_delete_directory (a_directory))
				warning_dialog.show_modal_to_window (parent_window (widget))

			elseif a_directory.count > 0 and then preferences.dialog_data.show_deleting_directories_warning then
					-- If the directory is not empty, then it does not matter if the root window is contained,
					-- as if we are here, we know that there are other window objects not contained in the directory,
					-- so just before the deletion, we can set one of these to be the root window.
				create warning_dialog.make_initialized (2, preferences.dialog_data.show_deleting_directories_warning_string, "The directory %"" + a_directory.name + "%" contains one or more windows.%NAre you sure that you wish these windows to be deleted with the dialog?", "do not show again, and always delete windows contained.", preferences.preferences)
				warning_dialog.set_icon_pixmap (Icon_build_window @ 1)
				warning_dialog.set_ok_action (agent actual_delete_directory (a_directory))
				warning_dialog.show_modal_to_window (parent_window (widget))
			else
				actual_delete_directory (a_directory)
			end
		end

	selector_item_is_referenced (selector_item: GB_WIDGET_SELECTOR_COMMON_ITEM): BOOLEAN is
			-- Is `selector_item' a top level object that has instance referers?
		require
			selector_item_not_void: selector_item /= Void
		local
			widget_selector_item: GB_WIDGET_SELECTOR_ITEM
		do
			widget_selector_item ?= selector_item
			if widget_selector_item /= Void then
				if not widget_selector_item.object.instance_referers.is_empty then
					Result := True
				end
			end
		end

	flatten_associated_instances (selector_item: GB_WIDGET_SELECTOR_COMMON_ITEM) is
			-- Flatten all associated instances of `selector_item' if it is
			-- a widget selector item and has instances.
		require
			selector_item_not_void: selector_item /= Void
		local
			widget_selector_item: GB_WIDGET_SELECTOR_ITEM
			instance_referers: HASH_TABLE [INTEGER, INTEGER]
			command_flatten: GB_COMMAND_FLATTEN_OBJECT
		do
			widget_selector_item ?= selector_item
			if widget_selector_item /= Void then
				check
					object_is_top_level_object: widget_selector_item.object.is_top_level_object
				end
				if not widget_selector_item.object.instance_referers.is_empty then
					instance_referers := widget_selector_item.object.instance_referers
					from
					until
						instance_referers.is_empty
					loop
						instance_referers.start
						create command_flatten.make (components.object_handler.deep_object_from_id (instance_referers.item_for_iteration), False, components)
						command_flatten.execute
					end
				end
			end
		end

	actual_delete_directory (a_directory: GB_WIDGET_SELECTOR_DIRECTORY_ITEM) is
			-- Actually delete `a_directory' from system.
		require
			a_directory_not_void: a_directory /= Void
		local
			all_objects: ARRAYED_LIST [GB_OBJECT]
			directory_of_root_window: GB_WIDGET_SELECTOR_DIRECTORY_ITEM
			l_selected: GB_WIDGET_SELECTOR_ITEM
		do
			all_objects := objects
			if all_objects.count >= 1 then
				if all_objects.count = a_directory.count then
						-- Move the root window out of the directory, as it may not be deleted.
					add_new_object (components.object_handler.root_window_object, components.tools.widget_selector)
				else
						-- If the currently selected window is contained within the structure of
						-- `a_directory', we must unselect it first to prevent us selecting windows
						-- multiple times each time we remove one that is contained in the structure.
					l_selected ?= selected_window
					if l_selected /= Void and then a_directory.has_recursive (l_selected) then
						l_selected.disable_select
							--| FIXME should really select next one after deselection completes rather
							--| than hiding/showing the builder windows.
						components.commands.Show_hide_builder_window_command.safe_disable_selected
						components.commands.Show_hide_display_window_command.safe_disable_selected
					end
					directory_of_root_window ?= components.object_handler.root_window_object.widget_selector_item.parent
					if directory_of_root_window /= Void and then directory_of_root_window = a_directory then
						-- We must now select the next root window in the tree, as the root window is contained in
						-- `a_directory'.
						mark_next_window_as_root (a_directory.count)
					end
				end

					-- Now actually perform the deletion of the directory, all of its sub directories and objects recursively.
				delete_objects_in_directory (a_directory)
			end

			components.system_status.mark_as_dirty
		end

	delete_objects_in_directory (a_directory: GB_WIDGET_SELECTOR_DIRECTORY_ITEM) is
			-- Recursively delete all objects within `a_directory'.
		require
			a_directory_not_void: a_directory /= Void
		local
			current_directory_item: GB_WIDGET_SELECTOR_DIRECTORY_ITEM
			current_object_item: GB_WIDGET_SELECTOR_ITEM
			parent_directory: GB_WIDGET_SELECTOR_DIRECTORY_ITEM
			command_delete_directory: GB_COMMAND_DELETE_DIRECTORY
			directory_children: ARRAYED_LIST [GB_WIDGET_SELECTOR_COMMON_ITEM]
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
					components.commands.delete_object_command.delete_object (current_object_item.object)
				end
				-- Note that there is no need to traverse the directory as deleting
				-- the objects contained ensures that we always simply remove the first.
			end
			parent_directory ?= a_directory.parent
			create command_delete_directory.make (a_directory, parent_directory, components)
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
			original_root_index := all_objects.index_of (components.object_handler.root_window_object, 1)
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

feature {GB_WIDGET_SELECTOR_DIRECTORY_ITEM} -- Implementation

	add_new_object (an_object: GB_OBJECT; parent_item: GB_WIDGET_SELECTOR_COMMON_ITEM) is
			-- Add an associated window item for `window_object'.
		require
			an_object_not_void: an_object /= Void
			parent_item_not_void: parent_item /= Void
		local
			command_move_window: GB_COMMAND_MOVE_WINDOW
			command_add_window: GB_COMMAND_ADD_WINDOW
			window_object: GB_TITLED_WINDOW_OBJECT
			dialog: GB_NAMING_DIALOG
			all_top_level_names: HASH_TABLE [STRING, STRING]
			command_convert_to_top_level: GB_COMMAND_CONVERT_TO_TOP_LEVEL
			directory_item: GB_WIDGET_SELECTOR_DIRECTORY_ITEM
			flatten_command: GB_COMMAND_FLATTEN_OBJECT
		do
			create all_top_level_names.make (50)
			objects.do_all (agent add_object_name_to_hash_table (?, all_top_level_names))
			if an_object.widget_selector_item = Void then
				create dialog.make_with_values (unique_name_from_hash_table (all_top_level_names, "my_" + an_object.short_type.as_lower), "New object", "Please specify the object name:", object_invalid_name_warning, agent check_new_object_name (an_object, ?))
				dialog.show_modal_to_window (parent_window (widget))
			end
			if dialog = Void or else not dialog.cancelled then
				if an_object.widget_selector_item /= Void then
					if an_object.widget_selector_item.parent /= Void then
							-- Do nothing if attempting to move from `Current' to `Current'.
						if an_object.widget_selector_item.parent /= parent_item then
							directory_item ?= parent_item
							create command_move_window.make (an_object, directory_item, components)
							command_move_window.execute
							if directory_item /= Void then
								directory_item.expand
							end
						end
					end
				else
					if an_object.layout_item = Void or else an_object.layout_item.parent = Void then
						window_object ?= an_object
						if window_object /= Void then
							components.object_handler.add_new_window (window_object)
						else
							components.object_handler.add_new_object (an_object)
						end

						directory_item ?= parent_item
						create command_add_window.make (an_object, directory_item, components)

						an_object.set_name (dialog.name.as_lower)
						command_add_window.execute
					else
							-- If the object is an instance of another top level object,
							-- flatten that representation before converting to a top level object.
						if an_object.is_instance_of_top_level_object then
							create flatten_command.make (an_object, False, components)
							flatten_command.execute
						end
						create command_convert_to_top_level.make (an_object, parent_item, dialog.name.as_lower, components)
						command_convert_to_top_level.execute
					end
				end
			end
			if dialog /= Void and then dialog.cancelled then
					-- The adition of the new object has been cancelled so we can delete
					-- the object as it is not to be used.
				components.object_handler.mark_as_deleted (an_object)
			end
				-- Update project so it may be saved.
			components.system_status.mark_as_dirty
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
				components.object_handler.name_in_use (a_name, an_object) and not
				(reserved_words.has (a_name.as_lower)) and not
				(build_reserved_words.has (a_name.as_lower) and not
				(components.constants.all_constants.item (a_name) /= Void))
		end


feature {GB_COMMAND_MOVE_WINDOW} -- Implementation

	update_class_files_location (window_item: GB_WIDGET_SELECTOR_ITEM; an_original_directory, a_new_directory: GB_WIDGET_SELECTOR_DIRECTORY_ITEM) is
			-- Update generated classes of object associated with `window_item' for a move from `an_original_directory' to `new_directory'.
			--| FIXME should probably be within the code of `window_item' as the implementation does not really rely on `Current'.
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

feature {GB_WIDGET_SELECTOR_COMMON_ITEM} -- Implementation

	update_for_removal (a_window_item: GB_WIDGET_SELECTOR_ITEM) is
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
					next_object.widget_selector_item.enable_select
				end
					-- Now must check to see if there are any windows.
					-- If not, the display and builder windows must be hidden.
				if all_objects.count = 1 then
					check
						removal_consistent: all_objects.first = window_object
					end
					components.commands.Show_hide_builder_window_command.safe_disable_selected
					components.commands.Show_hide_display_window_command.safe_disable_selected
				end
				components.commands.update
			end
		end

	selected_window_changed (selector_item: GB_WIDGET_SELECTOR_ITEM) is
			-- `selector_item' has become selected so we must update
			-- `layout_constructor'. Do nothing if a project is loading.
		require
			selector_item_not_void: selector_item /= Void
		local
			root_window_object: GB_OBJECT
		do
			if not components.system_status.loading_project then
				root_window_object := selector_item.object
					-- Only change the selected item, if a project is not loading.
				components.tools.layout_constructor.set_root_window (root_window_object)

				update_display_and_builder_windows (root_window_object)

				if parent_window (components.tools.Layout_constructor) /= Void then
						-- Protect against a selection being fired before
						-- `layout_constructor' is parented.
					components.tools.layout_constructor.first.enable_select
				end
				components.commands.update
			end
		end

feature {GB_WIDGET_SELECTOR_COMMON_ITEM} -- Implementation

	item_added_to_directory (directory, new_item: GB_WIDGET_SELECTOR_COMMON_ITEM) is
			-- `new_item' has been added to `directory' so ensure all nodes are highlighted.
		require
			directory_not_void: directory /= Void
			new_item_not_void: new_item /= Void
			directory_has_new_item: directory.children.has (new_item)
		local
			parent_directory, last_parent: GB_WIDGET_SELECTOR_DIRECTORY_ITEM
			window: GB_WIDGET_SELECTOR_ITEM
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

	item_removed_from_directory (directory: GB_WIDGET_SELECTOR_COMMON_ITEM; item_for_removal: GB_WIDGET_SELECTOR_COMMON_ITEM) is
			-- `item_for_removal' has been removed from `directory' so update directories to reflect this.
		require
			directory_not_void: directory /= Void
			item_for_removal_not_void: item_for_removal /= Void
			item_for_removal_not_parented: item_for_removal.parent = Void
		local
			all_branch_nodes: ARRAYED_LIST [GB_WIDGET_SELECTOR_DIRECTORY_ITEM]
			top_node, tree_node: GB_WIDGET_SELECTOR_COMMON_ITEM
			directory_item: GB_WIDGET_SELECTOR_DIRECTORY_ITEM
		do
			components.tools.main_window.lock_update
			create all_branch_nodes.make (20)
			top_node ?= directory
				-- Firstly retrieve the root node associated with `directory'.
			from
			until
				top_node.parent = components.tools.widget_selector or top_node.parent = Void
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
					tree_node = components.tools.widget_selector
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
			components.tools.main_window.unlock_update
		end

	gray_node (node: GB_WIDGET_SELECTOR_COMMON_ITEM) is
			-- Ensure `display_in_gray' is called on `node' it is of type GB_WIDGET_SELECTOR_DIRECTORY_ITEM.
		require
			node_not_void: NODE /= Void
		local
			directory_item: GB_WIDGET_SELECTOR_DIRECTORY_ITEM
		do
			directory_item ?= node
			if directory_item /= Void then
				directory_item.display_in_gray
			end
		end

	retrieve_all_branch_nodes (tree_node: GB_WIDGET_SELECTOR_COMMON_ITEM; all_branch_nodes: ARRAYED_LIST [GB_WIDGET_SELECTOR_COMMON_ITEM]) is
			-- For all items recursively in `tree_node' add all final directory nodes in the tree that contain items
			-- that are not directories to `all_branch_nodes'. These are the nodes that must be highlighted.
		require
			tree_node_not_void: tree_node /= Void
			all_branch_nodes_not_void: all_branch_nodes /= Void
		local
			current_item: GB_WIDGET_SELECTOR_COMMON_ITEM
			window_item: GB_WIDGET_SELECTOR_ITEM
			l_children: ARRAYED_LIST [GB_WIDGET_SELECTOR_COMMON_ITEM]
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
			create Result.make_from_string (components.system_status.current_project_settings.actual_generation_location)
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
			directory_object: GB_WIDGET_SELECTOR_DIRECTORY_ITEM
			file_name, interface_file_name, implementation_file_name: FILE_NAME
			l_eiffel_parser: EIFFEL_PARSER
			l_class_as: CLASS_AS
			l_visitor: NAME_CHANGE_VISITOR
			file: RAW_FILE
			file_contents: STRING
			character_difference: INTEGER
			directory_path: ARRAYED_LIST [STRING]
		do
			directory_object ?= object.widget_selector_item.parent
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
					file_contents.replace_substring (new_name.as_upper, l_visitor.name_start_position, l_visitor.name_end_position)

						-- As we are performing two replaces,we must update the character indexes of the second, by the difference
						-- in characters between what was replaced, and the new string of the first replacement.
					character_difference := old_name.count - new_name.count
					file_contents.replace_substring ((new_name + Class_implementation_extension).as_upper,
						l_visitor.parent_start_position - character_difference, l_visitor.parent_end_position - character_difference)

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
					file_contents.replace_substring ((new_name + Class_implementation_extension).as_upper, l_visitor.name_start_position, l_visitor.name_end_position)


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
			object := components.object_handler.root_window_object
			check
				object_is_top_level: object.is_top_level_object
			end
			object.set_as_root_window
			object.widget_selector_item.enable_select

			components.tools.Layout_constructor.set_root_window (object)
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
			components.system_status.mark_as_dirty
		ensure
			root_window_set: components.object_handler.root_window_object = titled_window_object
		end

feature {NONE} -- Implementation

	update_name_of_item (node: EV_TREE_NODE) is
			-- If `node' is a selector item, update its `text'.
		local
			window_item: GB_WIDGET_SELECTOR_ITEM
		do
			window_item ?= node
			if window_item /= Void then
				window_item.tree_item.set_text (name_and_type_from_object (window_item.object))
			end
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
			directory_item: GB_WIDGET_SELECTOR_DIRECTORY_ITEM
			parent_directory: GB_WIDGET_SELECTOR_DIRECTORY_ITEM
			parent_name: ARRAYED_LIST [STRING]
		do
			create directory_item.make_with_name (directory_name.i_th (directory_name.count), components)
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
			components.system_status.mark_as_dirty
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
			has_root_window_if_not_empty: components.object_handler.root_window_object /= Void
		end

feature {GB_SET_ROOT_WINDOW_COMMAND}

	change_root_window is
			-- Ensure that the window selected in the layout constructor is the
			-- root window of the project.
		local
			layout_constructor_item: GB_LAYOUT_CONSTRUCTOR_ITEM
			titled_window_object: GB_TITLED_WINDOW_OBJECT
		do
			layout_constructor_item := components.tools.Layout_constructor.root_item
			titled_window_object ?= layout_constructor_item.object
			check
				root_object_was_window: titled_window_object /= Void
			end
			titled_window_object.set_as_root_window
				-- Update project so it may be saved.
			components.system_status.mark_as_dirty
		end

feature {GB_OBJECT} -- Implementation

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
			containable: EV_CONTAINABLE
		do
				-- There should be no need to check that the window has not already changed,
				-- but it appears when selecting windows in the widget selector, this
				-- feature is called twice. This check reduces the flicker of hiding and showing
				-- the same window twice.
			titled_window_object ?= an_object
				-- Firstly hide the existing windows if shown
			if components.tools.builder_window.is_displayed then
				components.commands.show_hide_builder_window_command.execute
				builder_shown := True
			end
			if components.tools.display_window.is_displayed then
				components.commands.Show_hide_display_window_command.execute
				display_shown := True
			end

			containable ?= an_object.object
			check
				object_containable: containable /= Void
			end
			display_win ?= parent_window (containable)

			check
				display_win_not_void: display_win /= Void
			end
			components.tools.set_display_window (display_win)
			if titled_window_object /= Void then
				if titled_window_object.display_object /= Void then
					builder_win ?= titled_window_object.display_object.child
					check
						display_object_item_is_window: builder_win /= Void
					end
					components.tools.set_builder_window (builder_win)
				end
			else
				containable ?= an_object.display_object
				check
					object_containable: containable /= Void
				end
				builder_win ?= parent_window (containable)
				components.tools.set_builder_window (builder_win)
			end

			if builder_shown then
				components.commands.Show_hide_builder_window_command.execute
			end
			if display_shown then
				components.commands.Show_hide_display_window_command.execute
			end
			if application.is_launched then
					-- Force the newly displayed window to redraw immediately.
				application.process_events
			end
		end

feature {NONE} -- Implementation

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

	valid_directory_name (a_name: STRING; parent_item: GB_WIDGET_SELECTOR_DIRECTORY_ITEM): BOOLEAN is
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

	veto_object_drop (object_stone: GB_OBJECT_STONE): BOOLEAN is
			-- Veto drop of `object_stone'.
		require
			object_stone_not_void: object_stone /= Void
		do
			Result := True
			if Result then
					-- Only clear the status bar if a drop is permitted.
					-- Without this line, holding an object above a widget selector item that did
					-- not accept the object and then moving over the widget selector, did not
					-- clear the status bar and the old message was displayed even though a drop was now permitted.
				components.status_bar.clear_status_bar
			end
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
					if preferences.dialog_data.show_deleting_keyboard_warning then
						create warning_dialog.make_initialized (2, preferences.dialog_data.show_deleting_keyboard_warning_string, delete_warning1 + "window object" + delete_warning2, delete_do_not_show_again, preferences.preferences)
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
						if preferences.dialog_data.show_deleting_keyboard_warning then
							create warning_dialog.make_initialized (2, preferences.dialog_data.show_deleting_keyboard_warning_string, delete_warning1 + "directory object" + delete_warning2, delete_do_not_show_again, preferences.preferences)
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
			create delete_window_object_command.make_with_components (an_object, components)
			delete_window_object_command.execute
		end

	add_object_name_to_hash_table (an_object: GB_OBJECT; hash_table: HASH_TABLE [STRING, STRING]) is
			-- Add `name' of `an_object' to `hash_table' as both key and corresponding item.
		require
			an_object_not_void: an_object /= Void
			hash_table_not_void: hash_table /= Void
		do
			hash_table.put (an_object.name, an_object.name)
		ensure
			object_name_contained: hash_table.item (an_object.name) /= Void and then hash_table.item (an_object.name) = an_object.name
		end

	internal_return_objects (widget_selector_item: GB_WIDGET_SELECTOR_COMMON_ITEM; list: ARRAYED_LIST [GB_OBJECT]) is
			-- For all items in `node_list' recursively, add a GB_OBJECT to `list' if the
			-- item is an instance of GB_WIDGET_SELECTOR_ITEM.
		require
			widget_selector_item_not_void: widget_selector_item /= Void
			list_not_void: list /= Void
		local
			window_item: GB_WIDGET_SELECTOR_ITEM
			l_children: ARRAYED_LIST [GB_WIDGET_SELECTOR_COMMON_ITEM]
			l_cursor: CURSOR
		do
			l_children := widget_selector_item.children
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

feature {GB_WIDGET_SELECTOR_DIRECTORY_ITEM} -- Implementation

	handle_object_drop (object_pebble: GB_OBJECT_STONE; selector_item: GB_WIDGET_SELECTOR_COMMON_ITEM) is
			-- Respond to the dropping of `object_pebble' onto `selector_item'.
		require
			object_pebble_not_void: object_pebble /= Void
			selector_item_not_void: selector_item /= Void
		local
			flatten_command: GB_COMMAND_FLATTEN_OBJECT
			new_object: GB_OBJECT
			is_top_level: BOOLEAN
			clipboard_stone: GB_CLIPBOARD_OBJECT_STONE
		do
			new_object := object_pebble.object

			clipboard_stone ?= object_pebble
			if clipboard_stone /= Void then
					-- Special handling for instances of top level objects from the clipboard. If we are
					-- to convert them into their own top level representations, they can no
					-- longer be representations, so we silently flatten them.
				is_top_level := object_pebble.is_instance_of_top_level_object
				if is_top_level then
					create flatten_command.make (new_object, False, components)
					flatten_command.silent_execute
				end
			end
			add_new_object (new_object, selector_item)
				-- Ensure that the representations are up to date. This is necessary
				-- for when we have just flattened an object from the clipboard.
			if components.object_handler.objects.has (new_object.id) then
				new_object.update_representations_for_name_or_type_change
			end
		end

feature {GB_WIDGET_SELECTOR_TOOL_BAR, GB_WIDGET_SELECTOR_COMMON_ITEM} -- Implementation

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
			directory_item: GB_WIDGET_SELECTOR_DIRECTORY_ITEM
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
					if components.tools.widget_selector.directory_object_from_name (represented_path) = Void then
						if parent_path.is_empty then
								-- We are at the root level.
							directory_item := Void
						else
								-- Retrieve the directory_item matching `parent_path' within `widget_selector'.
							directory_item := components.tools.widget_selector.directory_object_from_name (parent_path)
						end
						create command_add_directory.make (directory_item, items.item, components)
						command_add_directory.supress_warnings
						command_add_directory.create_new_directory
						if command_add_directory.directory_added_succesfully then
							command_add_directory.execute
							components.system_status.mark_as_dirty
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

	add_new_directory_direct (directory_pebble: GB_NEW_DIRECTORY_PEBBLE) is
			--
		do
			add_new_directory (Current)
		end

	add_new_directory_via_pick_and_drop (directory_pebble: GB_NEW_DIRECTORY_PEBBLE) is
			-- Add a new directory within `Current'.
			-- `directory_pebble' is used to type the agent for pick and drop purposes.
		require
			directory_pebble_not_void: directory_pebble /= Void
		do
			add_new_directory (Current)
		end

	add_new_directory (directory_pebble: GB_WIDGET_SELECTOR_COMMON_ITEM) is
			-- Display a dialog for inputting a new name, that is only valid if
			-- not contained in `directory_names'. Create a new dialog
			-- from the name as entered by the user.
		local
			dialog: GB_NAMING_DIALOG
			command_add_directory: GB_COMMAND_ADD_DIRECTORY
			last_dialog_name: STRING
			retried: BOOLEAN
			l_selected_directory: GB_WIDGET_SELECTOR_DIRECTORY_ITEM
			l_directory_names: ARRAYED_LIST [STRING]
		do
			if retried then
					-- Ensure that the temporary directory is deleted. It was not deleted
					-- in this case as an exception was raised before the deleting code
					-- was executed, so we perform it here in this case.
				command_add_directory.test_directory.delete
					-- We do not rebuild the dialog, as using the previous one
					-- retains its position on screen.
				dialog.show_actions.wipe_out
				dialog.show_actions.extend (agent show_invalid_directory_warning (dialog, last_dialog_name))
			else
				if directory_pebble /= Void then
					l_selected_directory ?= directory_pebble
				else
					l_selected_directory := selected_directory
				end

				if l_selected_directory = Void then
					-- We are adding to the root of `Current'
					l_directory_names := directory_names
				else
					l_directory_names := l_selected_directory.directory_names
				end
				create dialog.make_with_values (unique_name_from_array (l_directory_names, "directory"), "New directory", "Please specify the directory name:"," is an invalid directory name.%N%NPlease ensure that it is not in use,%Nand is valid for the current platform.", agent valid_directory_name (?, l_selected_directory))
				dialog.set_icon_pixmap (Icon_build_window @ 1)
			end

			dialog.show_modal_to_window (parent_window (widget))

			if not dialog.cancelled then
				last_dialog_name := dialog.name
				if l_selected_directory /= Void then
					create command_add_directory.make (l_selected_directory, last_dialog_name, components)
				else
					create command_add_directory.make (Void, last_dialog_name, components)
				end
				command_add_directory.create_new_directory
				if command_add_directory.directory_added_succesfully then
					command_add_directory.execute
					components.system_status.mark_as_dirty
				end
			end
		rescue
			retried := True
			retry
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class GB_WIDGET_SELECTOR
