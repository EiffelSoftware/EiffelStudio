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
		rename
			selected_item as tree_selected_item
		export
			{NONE} all
			{ANY} start, off, forth, item, extend, wipe_out, is_empty
		redefine
			initialize
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
		end
		
feature {NONE} -- Implementation

	initialize is
			-- Create `Current' in correct default state.
		do
			pointer_enter_actions.extend (agent set_minimum_width (120))
			pointer_leave_actions.extend (agent set_minimum_width (120))
	
			drop_actions.set_veto_pebble_function (agent veto_drop)
			drop_actions.extend (agent add_new_object)			
			
			is_initialized := True
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
		ensure
			Result_not_void: Result /= Void
			Cursor_not_moved: old index = index
		end		

	selected_item: GB_WINDOW_SELECTOR_ITEM is
			-- Item currently selected.
		do
			Result ?= tree_selected_item
		ensure
			has_selection_implies_result_not_void: not (tree_selected_item = Void) implies Result /= Void
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
		ensure
			result_not_void: Result /= Void
		end
		
	assign_root_window_button: EV_TOOL_BAR_BUTTON is
			-- `Result' is a tool bar button that
			-- sets the root window for the project.
		local
			pixmaps: GB_SHARED_PIXMAPS
		do
			create Result
			create pixmaps
			Result.set_pixmap (pixmaps.pixmap_by_name ("icon_titled_window_main_small_color"))
			Result.select_actions.extend (agent change_root_window)
			Result.drop_actions.extend (agent change_root_window_to)
		ensure
			result_not_void: Result /= Void
		end
		
	objects: ARRAYED_LIST [GB_OBJECT] is
			-- `Result' is all objects represented in `Current'.
			-- No paticular order is guaranteed.
		local
			layout_item: GB_WINDOW_SELECTOR_ITEM
			directory_item: GB_WINDOW_SELECTOR_DIRECTORY_ITEM
		do
			create Result.make (2)
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
				end
				forth
			end
		ensure
			result_not_void: Result /= Void
		end
		
	directory_of_window (selector_item: GB_WINDOW_SELECTOR_ITEM): GB_WINDOW_SELECTOR_DIRECTORY_ITEM is
			-- `Result' is all objects represented in `Current'.
			-- No paticular order is guaranteed.
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
			confirmation_dialog: EV_CONFIRMATION_DIALOG
			perform_delete: BOOLEAN
			window_item: GB_WINDOW_SELECTOR_ITEM
			all_objects: ARRAYED_LIST [GB_OBJECT]
			directory_of_root_window: GB_WINDOW_SELECTOR_DIRECTORY_ITEM
			original_root_index, new_root_index: INTEGER
			titled_window_object: GB_TITLED_WINDOW_OBJECT
			temp_file_name: FILE_NAME
			command_delete_directory: GB_COMMAND_DELETE_DIRECTORY
		do
			perform_delete := True
			all_objects := objects
			if all_objects.count = a_directory.count then
					-- If all of the objects in `Current' are contained in `a_directory' then prompt the user
					-- that the root window will be moved out of the directory, as you may not delete the
					-- root window.
				create confirmation_dialog.make_with_text ("The directory contains the root window which will be moved from the directory. Other windows will be delted. Are you sure that you wish to remove this directory?")
				confirmation_dialog.show_modal_to_window (parent_window (Current))
				if confirmation_dialog.selected_button.is_equal ((create {EV_DIALOG_CONSTANTS}).Ev_cancel) then
					perform_delete := False
				end
			elseif not a_directory.is_empty then	
					-- If the directory is not empty, then it does not matter if the root window is contained,
					-- as if we are here, we know that there are other window objects not contained in the directory,
					-- so just before the deletion, we can set one of these to be the root window.
				create confirmation_dialog.make_with_text ("The directory%"" + a_directory.text + "%" contains one or more windows.%NAre you sure that you wish these windows to be deleted?")
				confirmation_dialog.show_modal_to_window (parent_window (Current))
				if confirmation_dialog.selected_button.is_equal ((create {EV_DIALOG_CONSTANTS}).Ev_cancel) then
					perform_delete := False
				end
			end
			if perform_delete then
				if all_objects.count = a_directory.count then
						-- Move the root window out of the directory, as it may not be deleted.
					add_new_object (object_handler.root_window_object)
				else
					directory_of_root_window ?= object_handler.root_window_object.window_selector_item.parent
					if directory_of_root_window /= Void and then directory_of_root_window = a_directory then
						-- We must now select the next root window in the tree, as the root window is contained in
						-- `a_directory'.
						original_root_index := all_objects.index_of (object_handler.root_window_object, 1)
						if original_root_index < objects.count then
							new_root_index := original_root_index + a_directory.count
						else
							new_root_index := 1
						end
						titled_window_object ?= all_objects.i_th (new_root_index)
						check
							object_was_window: titled_window_object /= Void
						end
						titled_window_object.set_as_root_window
					end
				end
				from
					a_directory.start
				until
					a_directory.after
				loop
					window_item ?= a_directory.item
					check
						item_was_window: window_item /= Void
					end
						-- Now remove the window from the directory.
					Command_handler.Delete_object_command.delete_object (window_item.object)
				end
				
				create command_delete_directory.make (a_directory.text)
				command_delete_directory.execute
				
				
				unparent_tree_node (a_directory)
					-- Update project so it may be saved.
				system_status.enable_project_modified
				command_handler.update
			end
		end
		

feature {GB_WINDOW_SELECTOR_DIRECTORY_ITEM} -- Implementation

	add_new_object (an_object: GB_TITLED_WINDOW_OBJECT) is
			-- Add an associated window item for `window_object'.
		require
			an_object_not_void: an_object /= Void
		local
			selector_item: GB_WINDOW_SELECTOR_ITEM
			command_move_window: GB_COMMAND_MOVE_WINDOW
		do
			if an_object.layout_item = Void then
				object_handler.add_new_window (an_object)			
				create selector_item.make_with_object (an_object)
				-- Ensure that when the item is selected, the layout constructor is updated
				-- to reflect this.
				selector_item.select_actions.extend (agent selected_window_changed (selector_item))
				extend (an_object.window_selector_item)
			else
				if not (an_object.window_selector_item.parent = Window_selector) then
						-- Do nothing if attempting to move from `Current' to `Current'.
					create command_move_window.make (an_object, Void)
					command_move_window.execute
				end
			end
		ensure
			count_increased: old an_object.layout_item = Void implies count = old count + 1
				-- Only if we were not moving internally as determined by whether the layout item
				-- is Void, as it will be when picked from the type selector.
		end
		
feature {GB_WINDOW_SELECTOR_DIRECTORY_ITEM} -- Implementation

	update_class_files_location (window_item: GB_WINDOW_SELECTOR_ITEM; current_directory, new_directory: GB_WINDOW_SELECTOR_DIRECTORY_ITEM) is
			-- Update generated classes of object associated with `window_item' for a move from `current_directory' to `new_directory'.
		require
			window_item_not_void: window_item /= Void
			-- `current_directory' and `new_directory' area allowed be Void if moving to/from the root.
		local
			original, new: FILE_NAME
		do
			create original.make_from_string (generated_path.string)
			if current_directory /= Void then
				original.extend (current_directory.text)	
			end
			create new.make_from_string (generated_path.string)
			if new_directory /= Void then
				new.extend (new_directory.text)	
			end
			move_file_between_directories (create {DIRECTORY}.make (original), create {DIRECTORY}.make (new),
				window_item.object.name.as_lower + ".e")
			move_file_between_directories (create {DIRECTORY}.make (original), create {DIRECTORY}.make (new),
				(window_item.object.name + Class_implementation_extension).as_lower + ".e")
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
			file_name: FILE_NAME
		do
			directory_object := directory_of_window (window_object.window_selector_item)
			file_name := generated_path
			if directory_object /= Void then
				file_name.extend (directory_object.text)
			end
			
				--| FIXME we need a better solution for name changes on windows.
				--| as undo allows their name to become empty.
			if not new_name.is_empty or old_name.is_empty then
				rename_file_if_exists (create {DIRECTORY}.make (file_name), old_name + ".e", new_name + ".e")
					--| FIXME must now go into class, and change name.
			
				rename_file_if_exists (create {DIRECTORY}.make (file_name), old_name + Class_implementation_extension.as_lower + ".e",
					new_name + Class_implementation_extension.as_lower + ".e")
					--| FIXME must now go into class, and change name.
			end
		end

feature {GB_XML_LOAD} -- Implementation

	update_displayed_names is
			-- Update names of all selector items (excluding directories)
			-- based on their objects.
		do
			recursive_do_all (agent update_name_of_item)
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
				-- Ensure that when the item is selected, the layout constructor is updated
				-- to reflect this.
			selector_item.select_actions.extend (agent selected_window_changed (selector_item))
			
			extend (selector_item)
			selector_item.enable_select
		ensure
			has_selected_item: selected_item /= Void
		end

feature {GB_COMMAND_DELETE_DIRECTORY} -- Implementation
		
	add_named_directory (directory_name: STRING) is
			-- Add a new directory named `directory_name' to `Current'.
		require
			name_valid: directory_name /= Void and not directory_name.is_empty
		local
			layout_item: GB_WINDOW_SELECTOR_DIRECTORY_ITEM
		do
			create layout_item.make_with_name (directory_name)
			extend (layout_item)
				-- Update project so it may be saved.
			system_status.enable_project_modified
			command_handler.update
		ensure
			count_increaed: count = old count + 1
		end

feature {NONE} -- Implementation

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

	add_new_directory is
			-- Display a dialog for inputting a new name, that is only valid if
			-- not contained in `directory_names'. Create a new dialog
			-- from the name as entered by the user.
		local
			dialog: GB_COMPONENT_NAMER_DIALOG
		do
			create dialog.make_with_names_and_prompts (directory_names, "directory", "New directory namer", " is an invalid directory name. Please ensure that it is valid and is not already in use.")
			dialog.show_modal_to_window (parent_window (current))
			if not dialog.name.is_empty then
				add_named_directory (dialog.name)
			end
		end

	selected_window_changed (selector_item: GB_WINDOW_SELECTOR_ITEM) is
			-- `selector_item' has become selected so we must update
			-- `layout_constructor'.
		require
			selector_item_not_void: selector_item /= Void
		local
			display_win: GB_DISPLAY_WINDOW
			builder_win: GB_BUILDER_WINDOW
			builder_shown, display_shown: BOOLEAN
			titled_window_object: GB_TITLED_WINDOW_OBJECT
		do
			titled_window_object := selector_item.object
			layout_constructor.set_root_window (titled_window_object)
			
				-- Now we must update the displayed display and builder windows.
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
				builder_win ?= selector_item.object.display_object.child
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
			if parent_window (Layout_constructor) /= Void then
					-- Protect against a selection being fired before
					-- `layout_constructor' is parented.
				layout_constructor.first.enable_select
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

end -- class GB_WINDOW_SELECTOR
