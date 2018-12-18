note
	description: "List Item Cocoa Implementation"
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_LIST_ITEM_IMP

inherit
	EV_LIST_ITEM_I
		redefine
			interface
		end

	EV_PND_DEFERRED_ITEM
		redefine
			interface
		end

	EV_ITEM_IMP
		undefine
			parent, pixmap_equal_to
		redefine
			interface
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'
		do
			internal_text := once ""
			set_is_initialized (True)
		end

feature -- Status report

	is_selected: BOOLEAN
			-- Is the item selected.
--		do
--			if parent_imp /= Void then
--			--	Result := parent_imp.selected_items.has (interface)
--			end
--		end

	minimum_width, minimum_height: INTEGER

	is_dockable: BOOLEAN

	text: STRING_32
			-- <Precursor>
		do
			Result := internal_text.twin
		end

feature -- Status setting

	enable_select
			-- Select the item.
		do
			--parent_imp.select_item (parent_imp.index_of (interface, 1))
			is_selected := True
		end

	disable_select
			-- Deselect the item.
		do
			--parent_imp.deselect_item (parent_imp.index_of (interface, 1))
			is_selected := False
		end

feature -- Element change

	set_tooltip (a_tooltip: READABLE_STRING_GENERAL)
			-- Assign `a_tooltip' to `tooltip'.
		do
			internal_tooltip := a_tooltip.as_string_32.twin
		end

	tooltip: STRING_32
			-- Tooltip displayed on `Current'.
		do
			if attached internal_tooltip as l_tooltip then
				Result := l_tooltip.twin
			else
				Result := ""
			end
		end

	set_text (a_text: READABLE_STRING_GENERAL)
			-- Set current button text to `txt'.
		do
			internal_text := a_text.as_string_32.twin
		end

	set_pointer_style (a_cursor: EV_POINTER_STYLE)
		do
			debug
				io.put_string ("EV_LIST_ITEM_IMP.set_pointer_style: Not implemented%N")
			end
		end

feature {NONE} -- Implementation

	width: INTEGER
		do
			debug
				io.put_string ("EV_LIST_ITEM_IMP.width: Not implemented%N")
			end
		end

	height: INTEGER
		do
			debug
				io.put_string ("EV_LIST_ITEM_IMP.height: Not implemented%N")
			end
		end

	screen_x: INTEGER
		do
			debug
				io.put_string ("EV_LIST_ITEM_IMP.screen_x: Not implemented%N")
			end
		end

	screen_y: INTEGER
		do
--			io.put_string ("EV_LIST_ITEM.screen_y: Not implemented%N")
		end

	x_position: INTEGER
		do
--			io.put_string ("EV_LIST_ITEM.x_position: Not implemented%N")
		end

	y_position: INTEGER
		do
--			io.put_string ("EV_LIST_ITEM.y_position: Not implemented%N")
		end

	internal_text: STRING_32
		-- Text displayed in `Current'

feature {EV_LIST_ITEM_LIST_IMP} -- Implementation

	internal_tooltip: detachable STRING_32
		-- Tooltip used for `Current'.

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_LIST_ITEM note option: stable attribute end;

note
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
