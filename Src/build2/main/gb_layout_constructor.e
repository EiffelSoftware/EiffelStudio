indexing
	description: "Objects that allow the user to lay out their vision2 components."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_LAYOUT_CONSTRUCTOR

inherit
	EV_TREE
		export
			{NONE} all
			{ANY} first, parent, is_destroyed, is_displayed,
				has_recursively, selected_item, is_empty
		undefine
			is_in_default_state
		redefine
			initialize
		select
			implementation
		end
		
	GB_STORABLE_TOOL
		undefine
			default_create, copy, is_equal
		end

	GB_LAYOUT_NODE
		rename
			implementation as old_imp
		export
			{NONE} all
		end
		
	GB_SHARED_OBJECT_HANDLER
		export
			{NONE} all
		undefine
			default_create, copy, is_equal
		end
		
	GB_WIDGET_UTILITIES
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
		
	GB_SHARED_PREFERENCES
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

create
	default_create

feature {NONE} -- Initialization

	initialize is
			-- Initialize `Current' and add a root
			-- item to represent a window.
		do
			Precursor {EV_TREE}
			key_press_actions.extend (agent check_for_object_delete)
		end
		
feature -- Basic operation

	ensure_object_visible (an_object: GB_OBJECT) is
			-- Ensure that `an_object' is contained in `Current'.
		require
			not_destroyed: not is_destroyed
			is_displayed: is_displayed
			object_contained: has_recursively (an_object.layout_item)
		do
			ensure_item_visible (an_object.layout_item)	
		end
		
feature -- Access

	root_item: GB_LAYOUT_CONSTRUCTOR_ITEM is
			-- `Result' is layout constructor item of
			-- root node or Void if none.
		do
			Result ?= first
		ensure
			not_empty_implies_has_root_object: not is_empty implies Result /= Void
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
		
	view_object_button: EV_TOOL_BAR_BUTTON is
			-- `Result' is a tool bar button that highlights an object in `Current'.
		local
			pixmaps: GB_SHARED_PIXMAPS
		do
			create Result
			Result.drop_actions.extend (agent highlight_object)
			Result.drop_actions.set_veto_pebble_function (agent object_higlightable)
			create pixmaps
			Result.set_pixmap (pixmaps.pixmap_by_name ("icon_view_small_color"))
		end
		
	tool_bar: EV_TOOL_BAR is
			-- A tool bar containing all buttons associated with `Current'.
		do
			create Result
		end
		
	name: STRING is "Layout Constructor"
			-- Full name used to represent `Current'.

feature {GB_XML_LOAD} -- Implementation

	update_expanded_state_from_root_object is
			-- Update expanded state of root item and all children
			-- recursively, from information held in each associated object.
		do
			Object_handler.recursive_do_all (root_item.object, agent expand_layout_item)
		end
	
feature {GB_OBJECT_HANDLER} -- Implementation

	add_root_item (layout_item: GB_LAYOUT_CONSTRUCTOR_ITEM) is
			-- Add `layout_item' as a root item of `Current'.
		require
			layout_item_not_void: layout_item /= Void
		do
			extend (layout_item)
		ensure
			has_layout_item: has (layout_item)
		end
		
feature {GB_WINDOW_SELECTOR} -- Implementation

	set_root_window (a_window: GB_TITLED_WINDOW_OBJECT) is
			-- Ensure that `a_window' is displayed in `Current'.
		require
			window_not_void: a_window /= Void
		do
			wipe_out
			add_root_item (a_window.layout_item)
			Object_handler.recursive_do_all (a_window, agent expand_layout_item)
		ensure
			has_one_item: count = 1
		end

feature {GB_OBJECT} -- Implementation

	highlight_object (an_object: GB_OBJECT) is
			-- Ensure `an_object' is highlighted object in `Current'.
			-- Only if `an_object' is contained in the structure of `Current', and
			-- is not a titled window.
		do
			if an_object.layout_item.is_selectable then
				an_object.layout_item.enable_select
				ensure_item_visible (an_object.layout_item)
			end
		end

feature {NONE} -- Implementation	

	object_higlightable (an_object: GB_OBJECT): BOOLEAN is
			-- Is `an_object' a valid object for highlighting via
			-- `highlight_object'.
		local
			titled_window_object: GB_TITLED_WINDOW_OBJECT
		do
			titled_window_object ?= an_object
			Result := titled_window_object = Void
		end

	expand_layout_item (an_object: GB_OBJECT) is
			-- If `an_object' is expanded, expand `layout_item' of `an_object'.
		require
			an_object_not_void: an_object /= Void
		do
			if an_object.is_expanded and an_object.layout_item.is_expandable then
				an_object.layout_item.expand				
			end
		end
		
	check_for_object_delete (a_key: EV_KEY) is
			-- Respond to keypress of `a_key' and delete selected object.
		require
			a_key_not_void: a_key /= Void
		local
		
			warning_dialog: STANDARD_DISCARDABLE_CONFIRMATION_DIALOG
		do
			if a_key.code = Key_delete and selected_item /= Void then
					-- Only perform deletion if delete key pressed, and an
					-- object was selected.
				if Preferences.boolean_resource_value (preferences.show_deleting_keyboard_warning, True) then
					create warning_dialog.make_initialized (2, preferences.show_deleting_keyboard_warning, delete_warning1 + "object" + delete_warning2, delete_do_not_show_again)
					warning_dialog.set_ok_action (agent delete_object)
					warning_dialog.show_modal_to_window (parent_window (Current))
				else
					delete_object
				end
			end
		end
		
	delete_object is
			-- Delete selected object.
		require
			item_selected: selected_item /= Void
		local
			delete_object_command: GB_COMMAND_DELETE_OBJECT
			delete_window_object_command: GB_COMMAND_DELETE_WINDOW_OBJECT
			selected_object: GB_OBJECT
			layout_item: GB_LAYOUT_CONSTRUCTOR_ITEM
			titled_window_object: GB_TITLED_WINDOW_OBJECT
		do
			layout_item ?= selected_item
			check
				selected_item_was_layout_item: layout_item /= Void
			end
			selected_object := layout_item.object
			titled_window_object ?= selected_object
			if titled_window_object /= Void then
					-- window objects must be handled seperately.
				create delete_window_object_command.make (titled_window_object)
				delete_window_object_command.execute
			else
				create delete_object_command.make (selected_object)
				delete_object_command.execute
			end
		end
		
invariant
	has_only_one_root: count <= 1

end -- class GB_LAYOUT_CONSTRUCTOR
