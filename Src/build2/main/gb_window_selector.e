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
	EV_TREE
		export
			{NONE} all
			{ANY} start, off, forth, item, extend, wipe_out, is_empty, prune_all, has
		redefine
			initialize
		end
		
	GB_STORABLE_TOOL
		undefine
			default_create, copy, is_equal
		end	
		
	GB_SHARED_TOOLS
		export
			{NONE} all
		undefine
			copy, is_equal, default_create
		end
		
	GB_SHARED_OBJECT_HANDLER
		export
			{NONE} all
		undefine
			copy, is_equal, default_create
		end
		
	GB_SHARED_COMMAND_HANDLER
		export
			{NONE} all
		end
		
	GB_SHARED_SYSTEM_STATUS
		export
			{NONE} all
		undefine
			copy, is_equal, default_create
		end
	
	GB_WIDGET_UTILITIES
		export
			{NONE} all
		undefine
			copy, is_equal, default_create
		end
		
	GB_SHARED_SYSTEM_STATUS
		export
			{NONE} all
		undefine
			default_create, copy, is_equal
		end
		
	GB_GENERAL_UTILITIES
		export
			{NONE} all
		undefine
			default_create, copy, is_equal
		end
		
	GB_FILE_UTILITIES
		export
			{NONE} all
		undefine
			default_create, copy, is_equal
		end
		
	GB_COMMAND_HANDLER
		export
			{NONE} all
		undefine
			default_create, copy, is_equal
		end
		
	GB_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, copy, is_equal
		end
		
	GB_NAMING_UTILITIES
		export
			{NONE} all
		undefine
			default_create, copy, is_equal
		end
		
	EV_KEY_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, copy, is_equal
		end
	
	GB_SHARED_PREFERENCES	
		export
			{NONE} all
		undefine
			default_create, copy, is_equal
		end
		
	GB_SHARED_PIXMAPS
		export
			{NONE} all
		undefine
			default_create, copy, is_equal
		end
		
feature {NONE} -- Implementation

	initialize is
			-- Create `Current' in correct default state.
		do
			is_initialized := True
			set_minimum_height (tool_minimum_height)
			drop_actions.set_veto_pebble_function (agent veto_drop)
			drop_actions.extend (agent add_new_object)			
			key_press_actions.extend (agent check_for_object_delete)
		end

feature -- Access

	directory_object_from_name (a_name: STRING): GB_WINDOW_SELECTOR_DIRECTORY_ITEM is
			-- `Result' is directory item representing directory `a_name'.
		require
			a_name_not_void: a_name /= Void
		local
			directory: GB_WINDOW_SELECTOR_DIRECTORY_ITEM
			a_cursor: EV_DYNAMIC_LIST_CURSOR [EV_TREE_NODE]
		do
				-- Note that we do not need to check recursively, as we
				-- only support one level of directories.
			a_cursor := cursor
			from
				start
			until
				off
			loop
				directory ?= item
				if directory /= Void then
					if directory.text.is_equal (a_name) then
						Result := directory
					end
				end
				forth
			end
			go_to (a_cursor)
		ensure
			result_contained: has (Result)
			Cursor_not_moved: old index = index
		end

	directory_names: ARRAYED_LIST [STRING] is
			-- Names of all directories contained.
		local
			directory: GB_WINDOW_SELECTOR_DIRECTORY_ITEM
			a_cursor: EV_DYNAMIC_LIST_CURSOR [EV_TREE_NODE]
		do
			a_cursor := cursor
			create Result.make (0)
			from
				start
			until
				off
			loop
				directory ?= item
				if directory /= Void then
					Result.extend (item.text)
				end
				forth
			end
			go_to (a_cursor)
			Result.compare_objects
		ensure
			Result_not_void: Result /= Void
			Cursor_not_moved: old index = index
			object_comparison_on: Result.object_comparison
		end		

	selected_window: GB_WINDOW_SELECTOR_ITEM is
			-- Window item currently selected.
		do
			Result ?= selected_item
		end
		
	selected_directory: GB_WINDOW_SELECTOR_DIRECTORY_ITEM is
			-- Directory item currently selected.
		do
			Result ?= selected_item
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
			Result.select_actions.extend (agent expand_tree_recursive (Current))
				-- Assign the appropriate pixmap.
			create pixmaps
			Result.set_pixmap (pixmaps.pixmap_by_name ("icon_expand_all_small_color"))
			Result.set_tooltip ("Expand all")
		ensure
			result_not_void: Result /= Void
		end
		
	objects: ARRAYED_LIST [GB_TITLED_WINDOW_OBJECT] is
			-- `Result' is all objects represented in `Current'.
			-- No paticular order is guaranteed.
		local
			layout_item: GB_WINDOW_SELECTOR_ITEM
			directory_item: GB_WINDOW_SELECTOR_DIRECTORY_ITEM
			l_cursor, l_cursor2: CURSOR
		do
			create Result.make (2)
			l_cursor ?= cursor
			from
				start
			until
				off
			loop
				layout_item ?= item
				if layout_item /= Void then
					Result.extend (layout_item.object)
				else
					directory_item ?= item
					check
						item_was_directory: directory_item /= Void
					end
					l_cursor2 ?= directory_item.cursor
					from
						directory_item.start
					until
						directory_item.off
					loop
						layout_item ?= directory_item.item
						check
							item_was_layout_item: layout_item /= Void
						end
						Result.extend (layout_item.object)
						directory_item.forth
					end
					directory_item.go_to (l_cursor2)
				end
				forth
			end
			go_to (l_cursor)
		ensure
			result_not_void: Result /= Void
			position_not_changed: index = old index
		end
		
	directory_of_window (selector_item: GB_WINDOW_SELECTOR_ITEM): GB_WINDOW_SELECTOR_DIRECTORY_ITEM is
			-- `Result' is directory containing `selector_item', or Void if none.
		local
			layout_item: GB_WINDOW_SELECTOR_ITEM
			directory_item: GB_WINDOW_SELECTOR_DIRECTORY_ITEM
			found: BOOLEAN
		do
			from
				start
			until
				off or found
			loop
				layout_item ?= item
				if layout_item = selector_item then
					Result := Void
					found := True
				elseif layout_item = Void then
					directory_item ?= item
					check
						item_was_directory: directory_item /= Void
					end
					from
						directory_item.start
					until
						directory_item.off or found
					loop
						layout_item ?= directory_item.item
						check
							item_was_layout_item: layout_item /= Void
						end
						if layout_item = selector_item then
							Result := directory_item
							found := True
						end
						directory_item.forth
					end
				end
				forth
			end
			check
				found: found
			end
		end
		
	tool_bar: EV_TOOL_BAR is
			-- A tool bar containing all buttons associated with `Current'.
		do
			create Result
			Result.extend (new_directory_button)
			Result.extend (expand_all_button)
			Result.extend (set_root_window_command.new_toolbar_item (True, False))
		end
		
	name: STRING is "Window Selector"
			-- Full name used to represent `Current'.

feature -- Status setting

	add_directory_item (directory_item: GB_WINDOW_SELECTOR_DIRECTORY_ITEM) is
			-- Add `directory' to `Current'.
		require
			directory_item_not_void: directory_item /= Void
			directory_item_not_parented: directory_item.parent = Void
		do
			extend (directory_item)
		ensure
			count_increased: count = old count + 1
		end
		
feature {GB_DELETE_OBJECT_COMMAND} -- Basic operation

	remove_directory (a_directory: GB_WINDOW_SELECTOR_DIRECTORY_ITEM) is
			-- Remove `a_directory' from `Current'.
		require
			directory_not_void: a_directory /= Void
			has_directory: has (a_directory)
		local
			perform_delete: BOOLEAN
			all_objects: ARRAYED_LIST [GB_OBJECT]
			warning_dialog: STANDARD_DISCARDABLE_CONFIRMATION_DIALOG
		do
			perform_delete := True
			all_objects := objects
			if all_objects.count = a_directory.count and then Preferences.boolean_resource_value (preferences.Show_deleting_final_directory_warning, True) then
					-- If all of the objects in `Current' are contained in `a_directory' then prompt the user
					-- that the root window will be moved out of the directory, as you may not delete the
					-- root window.
				create warning_dialog.make_initialized (2, preferences.Show_deleting_final_directory_warning, "The directory contains the root window which will be moved from the directory.%NOther windows will be deleted. Are you sure that you wish to remove this directory?", "Do not show again, and always move root window from directory.")
				warning_dialog.set_icon_pixmap (Icon_build_window @ 1)
				warning_dialog.set_ok_action (agent actual_delete_directory (a_directory))
				warning_dialog.show_modal_to_window (parent_window (Current))

			elseif not a_directory.is_empty and then Preferences.boolean_resource_value (preferences.Show_deleting_directories_warning , True) then
					-- If the directory is not empty, then it does not matter if the root window is contained,
					-- as if we are here, we know that there are other window objects not contained in the directory,
					-- so just before the deletion, we can set one of these to be the root window.
				create warning_dialog.make_initialized (2, preferences.Show_deleting_directories_warning, "The directory %"" + a_directory.text + "%" contains one or more windows.%NAre you sure that you wish these windows to be deleted with the dialog?", "do not show again, and always delete windows contained.")
				warning_dialog.set_icon_pixmap (Icon_build_window @ 1)
				warning_dialog.set_ok_action (agent actual_delete_directory (a_directory))
				warning_dialog.show_modal_to_window (parent_window (Current))
			else
				actual_delete_directory (a_directory)
			end
		end

	actual_delete_directory (a_directory: GB_WINDOW_SELECTOR_DIRECTORY_ITEM) is
			-- Actually delete `a_directory' from system.
		require
			a_directory_not_void: a_directory /= Void
		local
			window_item: GB_WINDOW_SELECTOR_ITEM
			all_objects: ARRAYED_LIST [GB_OBJECT]
			directory_of_root_window: GB_WINDOW_SELECTOR_DIRECTORY_ITEM
			command_delete_directory: GB_COMMAND_DELETE_DIRECTORY
		do
			all_objects := objects
			if all_objects.count >= 1 then
				if all_objects.count = a_directory.count then
						-- Move the root window out of the directory, as it may not be deleted.
					add_new_object (object_handler.root_window_object)
				else
					directory_of_root_window ?= object_handler.root_window_object.window_selector_item.parent
					if directory_of_root_window /= Void and then directory_of_root_window = a_directory then
						-- We must now select the next root window in the tree, as the root window is contained in
						-- `a_directory'.
						mark_next_window_as_root (a_directory.count)
					end
				end
				from
					a_directory.start
				until
					a_directory.is_empty
				loop
					window_item ?= a_directory.item
					check
						item_was_window: window_item /= Void
					end
						-- Now remove the window from the directory.
					Command_handler.Delete_object_command.delete_object (window_item.object)
				end
			end

			create command_delete_directory.make (a_directory.text)
			command_delete_directory.execute
			
				-- Update project so it may be saved.
			system_status.enable_project_modified
			command_handler.update
		end
	
feature {GB_COMMAND_DELETE_WINDOW_OBJECT, GB_COMMAND_ADD_WINDOW} -- Implementation
		
	mark_next_window_as_root (index_to_move: INTEGER) is
			-- Ensure that next window in `Current' is marked as root window.
		local
			original_root_index: INTEGER
			new_root_index: INTEGER
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
			titled_window_object ?= all_objects.i_th (new_root_index)
			check
				object_was_window: titled_window_object /= Void
			end
			titled_window_object.set_as_root_window
		end

feature {GB_WINDOW_SELECTOR_DIRECTORY_ITEM} -- Implementation

	add_new_object (an_object: GB_TITLED_WINDOW_OBJECT) is
			-- Add an associated window item for `window_object'.
			-- Added at root level of `Current', not in a directory.
		require
			an_object_not_void: an_object /= Void
		local
			command_move_window: GB_COMMAND_MOVE_WINDOW
			command_add_window: GB_COMMAND_ADD_WINDOW
		do
			if an_object.layout_item = Void then
				object_handler.add_new_window (an_object)
				create command_add_window.make (an_object, Void)
				command_add_window.execute
			else
				if not (an_object.window_selector_item.parent = Window_selector) then
						-- Do nothing if attempting to move from `Current' to `Current'.
					create command_move_window.make (an_object, Void)
					command_move_window.execute
				end
			end
				-- Update project so it may be saved.
			system_status.enable_project_modified
			command_handler.update
		ensure
			count_increased: old an_object.layout_item = Void implies count = old count + 1
				-- Only if we were not moving internally as determined by whether the layout item
				-- is Void, as it will be when picked from the type selector.
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
		do
			create original.make_from_string (generated_path.string)
			if an_original_directory /= Void then
				original.extend (an_original_directory.text)	
			end
			create new.make_from_string (generated_path.string)
			if a_new_directory /= Void then
				new.extend (a_new_directory.text)	
			end
			original_directory := create {DIRECTORY}.make (original)
			new_directory := create {DIRECTORY}.make (new)
			
				-- If the directories do not exist, then create them. They may have been removed from
				-- outside Build.
			if not new_directory.exists then
				create_directory (new_directory)
			end
			if not original_directory.exists then
				create_directory (original_directory)
			end
			move_file_between_directories (original_directory, new_directory, window_item.object.name.as_lower + ".e")
			move_file_between_directories (original_directory, new_directory, (window_item.object.name + Class_implementation_extension).as_lower + ".e")
		end
		
feature {GB_WINDOW_SELECTOR_ITEM} -- Implementation

	update_for_removal (a_window_item: GB_WINDOW_SELECTOR_ITEM) is
			-- Update `Current' to reflect a removal of `a_window_item'.
		local
			all_objects: ARRAYED_LIST [GB_OBJECT]
			current_index: INTEGER
			window_object: GB_TITLED_WINDOW_OBJECT
		do
			
				-- If `a_window_item' is selected, the next item
				-- in `Current' must be selected.
			if a_window_item.is_selected then
				all_objects := objects
				check
					a_window_item_still_contained: all_objects.has (a_window_item.object)
				end
				current_index := all_objects.index_of (a_window_item.object, 1)
				if all_objects.count > 1 then
					current_index := current_index + 1
					if current_index > all_objects.count then
						current_index := 1
					end
					window_object ?= all_objects.i_th (current_index)
					window_object.window_selector_item.enable_select
				end
					-- Now must check to see if there are any windows.
					-- If not, the display and builder windows must be hidden.
				if all_objects.count = 1 then
					check
						removal_consistent: all_objects.first = a_window_item.object
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
			titled_window_object: GB_TITLED_WINDOW_OBJECT
		do
			if not System_status.loading_project then
					-- Only change the selected item, if a project is not loading.
				titled_window_object := selector_item.object
				layout_constructor.set_root_window (titled_window_object)
				
				update_display_and_builder_windows (titled_window_object)
			
				if parent_window (Layout_constructor) /= Void then
						-- Protect against a selection being fired before
						-- `layout_constructor' is parented.
					layout_constructor.first.enable_select
				end
				Command_handler.update
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

	update_class_files_of_window (window_object: GB_TITLED_WINDOW_OBJECT; old_name, new_name: STRING) is
			-- Rename generated files representing `window_object' to reflect a name change on `window_object'
			-- from `old_name' to `new_name'.
		require
			window_object_not_void: window_object /= Void
		local
			directory_object: GB_WINDOW_SELECTOR_DIRECTORY_ITEM
			file_name, interface_file_name, implementation_file_name: FILE_NAME
			l_eiffel_parser: EIFFEL_PARSER
			l_class_as: CLASS_AS
			l_visitor: NAME_CHANGE_VISITOR
			file: RAW_FILE
			file_contents: STRING
			character_difference: INTEGER
		do
			directory_object := directory_of_window (window_object.window_selector_item)
			file_name := generated_path
			if directory_object /= Void then
				file_name.extend (directory_object.text)
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
			recursive_do_all (agent update_name_of_item)
		end
		
	select_main_window is
			-- Select window marked as root of system.
		local
			object: GB_TITLED_WINDOW_OBJECT
			found: BOOLEAN
			directory: GB_WINDOW_SELECTOR_DIRECTORY_ITEM
			window: GB_WINDOW_SELECTOR_ITEM
		do
			object := Object_handler.root_window_object
			from
				start
			until
				off or found
			loop
				directory ?= item
				if directory = Void then
					window ?= item
					if window.object = object then
						window.enable_select
							-- This ensures that the root icon is displayed.
						window.object.set_as_root_window
						found := True
					end
				else
					from
						directory.start
					until
						directory.off
					loop
						window ?= directory.item
						if window.object = object then
							window.enable_select
								-- This ensures that the root icon is displayed.
							window.object.set_as_root_window
							found := True
						end	
						directory.forth
					end
				end
				forth
			end
			Layout_constructor.set_root_window (object)
			update_display_and_builder_windows (object)
			check
				found: found
			end
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
				window_item.set_text (name_and_type_from_object (window_item.object))
			end
		end
		
feature {GB_OBJECT_HANDLER} -- Implementation

	set_item_for_prebuilt_window (window_object: GB_TITLED_WINDOW_OBJECT) is
			-- Add an associated window item for `window_object' in `Current'.
			-- `window_object' must be a completely built object.
		require
			window_object_not_void: window_object /= Void
			is_completely_built: window_object.layout_item /= Void
		local
			selector_item: GB_WINDOW_SELECTOR_ITEM
		do
			create selector_item.make_with_object (window_object)
			
			extend (selector_item)
			selector_item.enable_select
		ensure
			has_selected_item: selected_window /= Void
		end

feature {GB_COMMAND_DELETE_DIRECTORY} -- Implementation
	
	silent_add_named_directory (directory_name: STRING) is
			-- Add a new directory named `directory_name' to `Current',
			-- but do not mark it as a command, simply add a new item in `Current'.
			-- This will be called by `undo' of GB_COMMAND_DELETE_DIRECTORY and
			-- must not affect the command history.
		require
			name_valid: directory_name /= Void and not directory_name.is_empty
		local
			directory_item: GB_WINDOW_SELECTOR_DIRECTORY_ITEM
		do
			create directory_item.make_with_name (directory_name)
			extend (directory_item)
				-- Update project so it may be saved.
			system_status.enable_project_modified
			command_handler.update
		ensure
			count_increaed: count = old count + 1
		end
		
feature {GB_XML_LOAD} -- Implementation

	mark_first_window_as_root is
			-- Ensure first window in `Current' is marked as
			-- the root window for the project.
		require
			objects_not_empty: not objects.is_empty
		do
			change_root_window_to (objects.first)
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
		do
			if retried then
					-- We do not rebuild the dialog, as using the previous one
					-- retains its position on screen.
				dialog.show_actions.wipe_out
				dialog.show_actions.extend (agent show_invalid_directory_warning (dialog, last_dialog_name))
			else
				create dialog.make_with_values (unique_name_from_array (directory_names, "directory"), "New directory", "Please specify the directory name:"," is an invalid directory name.%N%NPlease ensure that it is not in use,%Nand is valid for the current platform.", agent valid_directory_name)
				dialog.set_icon_pixmap (Icon_build_window @ 1)
			end
			
			dialog.show_modal_to_window (parent_window (current))
			
			if not dialog.cancelled then
				last_dialog_name := dialog.name
				create command_add_directory.make (last_dialog_name)
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
		
		
	valid_directory_name (a_name: STRING): BOOLEAN is
			-- Is `a_name' a valid name for a new directory?
		require
			a_name_not_void: a_name /= Void
		do
			Result := not directory_names.has (a_name)
		end
		
	update_display_and_builder_windows (titled_window_object: GB_TITLED_WINDOW_OBJECT) is
			-- Update windows referenced by `builder_window' and `display_window' to
			-- reflect `titled_window_object'.
		require
			window_not_void: titled_window_object /= Void
		local
			display_win: GB_DISPLAY_WINDOW
			builder_win: GB_BUILDER_WINDOW
			builder_shown, display_shown: BOOLEAN
		do
				-- There should be no need to check that the window has not already changed,
				-- but it appears when selecting windows in the window selector, this
				-- feature is called twice. This check reduces the flicker of hiding and showing
				-- the same window twice.
			if titled_window_object.object /= display_window then

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
			display_win ?= titled_window_object.object
			check
				display_win_not_void: display_win /= Void
			end
			set_display_window (display_win)
			if titled_window_object.display_object /= Void then
				builder_win ?= titled_window_object.display_object.child
				check
					display_object_item_is_window: builder_win /= Void
				end
				set_builder_window (builder_win)
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
			-- Veto drop of `an_object'. We currently only
			-- allow windows to be inserted, and those must be
			-- not created, ie picked directly from the type selector.
		local
			titled_window_object: GB_TITLED_WINDOW_OBJECT
		do
			titled_window_object ?= an_object
				-- We are allowed to drop windows and dialogs, so
				-- this takes case of both cases, as dialogs inherit
				-- windows.
			Result :=  titled_window_object /= Void
		end
		
	check_for_object_delete (a_key: EV_KEY) is
			-- Respond to keypress of `a_key' and delete selected object.
		require
			a_key_not_void: a_key /= Void
		local
			warning_dialog: STANDARD_DISCARDABLE_CONFIRMATION_DIALOG
		do
			if a_key.code = Key_delete and selected_item /= Void then
				if selected_window /= Void then
						-- Only perform deletion if delete key pressed, and a
						-- window object was selected.
					if Preferences.boolean_resource_value (preferences.show_deleting_keyboard_warning, True) then
						create warning_dialog.make_initialized (2, preferences.show_deleting_keyboard_warning, delete_warning1 + "window object" + delete_warning2, delete_do_not_show_again)
						warning_dialog.set_icon_pixmap (Icon_build_window @ 1)
						warning_dialog.set_ok_action (agent delete_window_object (selected_window.object))
						warning_dialog.show_modal_to_window (parent_window (Current))
					else
						delete_window_object (selected_window.object)
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
							warning_dialog.show_modal_to_window (parent_window (Current))
						else
							remove_directory (selected_directory)
						end
					else
						remove_directory (selected_directory)
					end
				end
			end
		end
		
	delete_window_object (window_object: GB_TITLED_WINDOW_OBJECT) is
			-- Delete selected object.
		require
			window_object_not_void: window_object /= Void
		local
			delete_window_object_command: GB_COMMAND_DELETE_WINDOW_OBJECT
		do
			create delete_window_object_command.make (window_object)
			delete_window_object_command.execute
		end

end -- class GB_WINDOW_SELECTOR
