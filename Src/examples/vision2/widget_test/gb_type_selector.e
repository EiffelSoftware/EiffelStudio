indexing
	description: "Objects that allow you to select a widget type."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_TYPE_SELECTOR

inherit

	EV_TREE
		export
			{ANY} parent
			{NONE} all
		undefine
			is_in_default_state
		redefine
			initialize
		end
		
	WIDGET_TEST_SHARED
		undefine
			copy, is_equal, default_create
		end
		
	INSTALLATION_LOCATOR
		undefine
			copy, is_equal, default_create
		end
	
create
	default_create

feature {NONE} -- Initialization

	initialize is
			-- Initialize `Current'.
			-- Fill with supported Widgets.
		local
			tree_item1, tree_item2, tree_item3: EV_TREE_ITEM
			pixmap: EV_PIXMAP
		do
			Precursor {EV_TREE}
			create tree_item1.make_with_text ("Widgets")
			pixmap := pixmap_by_type (tree_item1.text.as_lower)
			if pixmap /= Void then
				tree_item1.set_pixmap (pixmap)	
			end
			extend (tree_item1)
			create tree_item3.make_with_text ("Containers")
			pixmap := pixmap_by_type (tree_item3.text.as_lower)
			if pixmap /= Void then
				tree_item3.set_pixmap (pixmap)	
			end
			tree_item1.extend (tree_item3)
			add_tree_items (containers, tree_item3)
			create tree_item2.make_with_text ("Primitives")
			pixmap := pixmap_by_type (tree_item2.text.as_lower)
			if pixmap /= Void then
				tree_item2.set_pixmap (pixmap)	
			end
			tree_item1.extend (tree_item2)
			add_tree_items (primitives, tree_item2)
				-- Expand the types when the project is started.
			tree_item2.expand
			tree_item3.expand
			tree_item1.expand
			recursive_do_all (agent strip_leading_ev (?))
			
				-- Connect select event
			select_actions.extend (agent widget_type_selected)
		end

feature {NONE} -- Implementation

	widget_type_selected is
			-- Set type of widget to test to match the text
			-- of `selected_item'.
		local
			a_parent, a_parent2: EV_TREE_ITEM
		do
			 -- We must igonre the place holding items, so we check that
			 -- the selected item is on the third level of the tree.
			a_parent ?= selected_item.parent
			if a_parent /= Void then
				a_parent2 ?= a_parent.parent
				if a_parent2 /= Void then
					set_test_widget_type ("EV_" + selected_item.text)
				end
			end
		end
		
	pixmap_by_type (a_type: STRING): EV_PIXMAP is
			-- Retrieve a pixmap based on name `a_type', in
			-- the correct format for the current platform.
			-- PNG for Unix and ICO for windows.
		require
			a_type_not_void: a_type /= Void
		local
			filename: FILE_NAME
			extension: STRING
			file: RAW_FILE
		do
			extension := "png"
			if installation_location /= Void then
				create filename.make_from_string (installation_location)
				filename.extend ("bitmaps")
				filename.extend (extension)
				filename.extend (a_type.as_lower + "." + extension)
				create file.make (filename.out)
				if file.exists then
					create Result
					Result.set_with_named_file (filename.out)
				else
				Missing_files.extend (a_type.as_lower + "." + extension)
				end
			else
				Missing_files.extend (a_type.as_lower + "." + extension)
			end
		end

	containers: ARRAY [STRING] is
		once
			Result := <<"EV_CELL", "EV_FIXED", "EV_FRAME", "EV_HORIZONTAL_BOX",
				"EV_HORIZONTAL_SPLIT_AREA", "EV_NOTEBOOK", "EV_SCROLLABLE_AREA",
				"EV_TABLE", "EV_VERTICAL_BOX", "EV_VERTICAL_SPLIT_AREA", "EV_VIEWPORT">>
		end
				
	primitives: ARRAY [STRING] is 
		once
			Result := <<"EV_BUTTON", "EV_CHECK_BUTTON", "EV_CHECKABLE_LIST", "EV_CHECKABLE_TREE", "EV_COMBO_BOX", "EV_DRAWING_AREA", "EV_GRID", "EV_HEADER",
				"EV_HORIZONTAL_PROGRESS_BAR", "EV_HORIZONTAL_RANGE", "EV_HORIZONTAL_SCROLL_BAR",
				"EV_HORIZONTAL_SEPARATOR", "EV_LABEL", "EV_LIST", "EV_MULTI_COLUMN_LIST",
				"EV_PASSWORD_FIELD", "EV_PIXMAP", "EV_RADIO_BUTTON", "EV_RICH_TEXT", "EV_SPIN_BUTTON",
				"EV_TEXT", "EV_TEXT_FIELD", "EV_TOGGLE_BUTTON", "EV_TOOL_BAR", "EV_TREE", "EV_VERTICAL_PROGRESS_BAR",
				"EV_VERTICAL_RANGE", "EV_VERTICAL_SCROLL_BAR", "EV_VERTICAL_SEPARATOR"
				>>
		end

	add_tree_items (list: ARRAY [STRING]; tree_item: EV_TREE_ITEM) is
			-- Add items corresponding to contents of `list' to `tree_item'.
		local
			counter: INTEGER
			new_item: EV_TREE_ITEM
			pixmap: EV_PIXMAP
		do
			from
				counter := 1
			until
				counter = list.count + 1
			loop
				create new_item.make_with_text (list @ counter)
				pixmap := pixmap_by_type (new_item.text)
				if pixmap /= Void then
					new_item.set_pixmap (pixmap)
				end
				tree_item.extend (new_item)
				counter := counter + 1
			end
		end
		
	strip_leading_ev (tree_item: EV_TREE_ITEM) is
			-- If `tree_item' starts with "EV_", strip
			-- this.
		require
			tree_item_not_void: tree_item /= Void
		do
			if tree_item.text.substring (1, 3).is_equal ("EV_") then
				tree_item.set_text (tree_item.text.substring (4, tree_item.text.count))
			end
		end
		
	is_in_default_state: BOOLEAN is
			-- Is `Current' in default state?
		do
			Result := True
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class GB_WIDGET_SELECTOR
