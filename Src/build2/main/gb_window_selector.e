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

feature {GB_WINDOW_SELECTOR_DIRECTORY_ITEM} -- Implementation

	add_new_object (an_object: GB_TITLED_WINDOW_OBJECT) is
			-- Add an associated window item for `window_object'.
			-- `an_object' will have been placed here via pick and drop
			-- from the type selector, meaning that the object is not completely
			-- initialized.
		require
			an_object_not_void: an_object /= Void
			not_completely_built: an_object.layout_item = Void
		local
			window_object: GB_TITLED_WINDOW_OBJECT
			selector_item: GB_WINDOW_SELECTOR_ITEM
		do
			window_object ?= an_object
			check
				object_was_window: window_object /= Void
			end
			object_handler.add_new_window (window_object)
			
			create selector_item.make_with_object (window_object)
				-- Ensure that when the item is selected, the layout constructor is updated
				-- to reflect this.
			selector_item.select_actions.extend (agent selected_window_changed (selector_item))
			selector_item.deselect_actions.extend (agent window_unselected (selector_item))
			
			extend (selector_item)
		ensure
			count_increased: count = old count + 1
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
			selector_item.deselect_actions.extend (agent window_unselected (selector_item))
			
			extend (selector_item)
			selector_item.enable_select
		ensure
			has_selected_item: selected_item /= Void
		end

feature {NONE} -- Implementation
		
	add_new_directory is
			-- Display a dialog for inputting a new name, that is only valid if
			-- not contained in `directory_names'. Create a new dialog
			-- from the name as entered by the user.
		local
			dialog: GB_COMPONENT_NAMER_DIALOG
			layout_item: GB_WINDOW_SELECTOR_DIRECTORY_ITEM
		do
			create dialog.make_with_names_and_prompts (directory_names, "directory", "New directory namer", " is an invalid directory name. Please ensure that it is valid and is not already in use.")
			dialog.show_modal_to_window (parent_window (current))
			if not dialog.name.is_empty then
				create layout_item.make_with_name (dialog.name)
				extend (layout_item)
					-- Update project so it may be saved.
				system_status.enable_project_modified
				command_handler.update
			end
		end
		
	window_unselected (selector_item: GB_WINDOW_SELECTOR_ITEM) is
			-- `selector_item' has become unselected, so we must
			-- store current layout of window object referenced by `selector_item'.
		require
			selector_item_not_void: selector_item /= Void
		local
			titled_window_object: GB_TITLED_WINDOW_OBJECT
		do
			titled_window_object := selector_item.object
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
			Object_handler.recursive_do_all (titled_window_object, agent expand_layout_item)
			
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
		
	expand_layout_item (an_object: GB_OBJECT) is
			-- If `an_object' is expanded, expand `layout_item' of `an_object'.
		do
			if an_object.is_expanded then
				an_object.layout_item.expand				
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
			if Result and then titled_window_object.window_selector_item /= Void then
					-- Do not allow a window if it is already completely built.
				Result := False
			end
		end

end -- class GB_WINDOW_SELECTOR
