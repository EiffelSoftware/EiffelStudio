note
	description: "EiffelVision list item list, Cocoa implementation"
	copyright:	"Copyright (c) 2009, Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_LIST_ITEM_LIST_IMP

inherit
	EV_LIST_ITEM_LIST_I
		redefine
			interface
		end

	EV_PRIMITIVE_IMP
		redefine
			make,
			interface,
			pre_pick_steps
		end

	EV_ITEM_LIST_IMP [EV_LIST_ITEM, EV_LIST_ITEM_IMP]
		redefine
			interface
		end

	EV_KEY_CONSTANTS

	EV_PND_DEFERRED_ITEM_PARENT

feature {NONE} -- Initialization

	make
			-- Set up `Current'
		do
			initialize_item_list
			Precursor {EV_PRIMITIVE_IMP}
			initialize_pixmaps
		end

feature -- Access

	selected_items: ARRAYED_LIST [EV_LIST_ITEM]
			-- `Result is all items currently selected in `Current'.
		deferred
		end

feature -- Status report

	update_pnd_status
			-- Update PND status of list and its children.
		do

		end

	update_pnd_connection (a_enable: BOOLEAN)
			-- Update the PND connection of `Current' if needed.
		do

		end

	pre_pick_steps (a_x, a_y, a_screen_x, a_screen_y: INTEGER)
				-- Steps to perform before transport initiated.
			do

			end

	row_height: INTEGER
			-- Default height of rows
		do

		end

	pnd_row_imp: detachable EV_LIST_ITEM_IMP
			-- Implementation object of the current row if in PND transport.


feature -- Status setting

	select_item (an_index: INTEGER)
			-- Select item at one based index, `an_index'.
		deferred
		end

	deselect_item (an_index: INTEGER)
			-- Deselect item at one based index, `an_index'.
		deferred
		end

feature -- Insertion

	set_text_on_position (a_row: INTEGER; a_text: READABLE_STRING_GENERAL)
			-- Set cell text at (a_column, a_row) to `a_text'.
		do

		end

	set_row_pixmap (a_row: INTEGER; a_pixmap: EV_PIXMAP)
			-- Set row `a_row' pixmap to `a_pixmap'.
		do

		end

	remove_row_pixmap (a_row: INTEGER)
			-- Set row `a_row' pixmap to `a_pixmap'.
		do

		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_LIST_ITEM_LIST note option: stable attribute end;

note
	copyright: "Copyright (c) 1984-2019, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end -- class EV_LIST_ITEM_LIST_IMP
