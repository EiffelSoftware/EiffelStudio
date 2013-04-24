note
	description: "Eiffel Vision vertical scroll bar. GTK+ implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_VERTICAL_SCROLL_BAR_IMP

inherit
	EV_VERTICAL_SCROLL_BAR_I
		redefine
			interface
		end

	EV_SCROLL_BAR_IMP
		redefine
			interface,
			make
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Create and initialize `Current'.
		local
			l_vscroll, l_cell: POINTER
		do
			adjustment_internal := {GTK}.gtk_adjustment_new (0, 0, 100 + 10, 1, 10, 10)

			set_c_object ({GTK}.gtk_hbox_new (False, 0))

			l_cell := {GTK}.gtk_event_box_new
			{GTK}.gtk_widget_show (l_cell)

			l_vscroll := {GTK}.gtk_vscrollbar_new (adjustment_internal)
			{GTK}.gtk_widget_show (l_vscroll)

			{GTK}.gtk_container_add (c_object, l_cell)
			{GTK}.gtk_container_add (c_object, l_vscroll)

			set_box_child_expandable (c_object, l_vscroll, False)

				-- Make sure `Current' is large enough to render overlay scrollbars at the same window depth.
			{GTK2}.gtk_widget_set_minimum_size (c_object, minimum_width.max (3), -1)

			Precursor
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_VERTICAL_SCROLL_BAR note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EV_VERTICAL_SCROLL_BAR_IMP
