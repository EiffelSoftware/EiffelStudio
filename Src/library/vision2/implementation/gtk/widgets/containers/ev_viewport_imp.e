indexing
	description: "Eiffel Vision viewport. GTK+ implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_VIEWPORT_IMP
	
inherit
	EV_VIEWPORT_I
		undefine
			propagate_foreground_color,
			propagate_background_color
		redefine
			interface
		end
		
	EV_CELL_IMP
		redefine
			interface,
			make
		end
	
create
	make

feature {NONE} -- Initialization
	
	make (an_interface: like interface) is
			-- Initialize. 
		do
			base_make (an_interface)
			set_c_object (C.gtk_viewport_new (NULL, NULL))
			viewport := c_object
			C.gtk_viewport_set_shadow_type (c_object, gtk_marshal.Gtk_shadow_none_enum)
			C.gtk_widget_set_usize (c_object, 1, 1) -- Hack needed to prevent viewport resize on item resize.
		end	

feature -- Access

	x_offset: INTEGER is
			-- Horizontal position of viewport relative to `item'.
		do
			Result := C.gtk_adjustment_struct_value (horizontal_adjustment).rounded
		end

	y_offset: INTEGER is
			-- Vertical position of viewport relative to `item'.
		do
			Result := C.gtk_adjustment_struct_value (vertical_adjustment).rounded
		end

feature -- Element change

	set_x_offset (a_x: INTEGER) is
			-- Set `x_offset' to `a_x'.
		do
			C.gtk_adjustment_set_value (horizontal_adjustment, a_x)
		end

	set_y_offset (a_y: INTEGER) is
			-- Set `y_offset' to `a_y'.
		do
			C.gtk_adjustment_set_value (vertical_adjustment, a_y)
		end

feature {NONE} -- Implementation

	horizontal_adjustment: POINTER is
		do
			Result := C.gtk_viewport_get_hadjustment (viewport)
		end

	vertical_adjustment: POINTER is
		do
			Result := C.gtk_viewport_get_vadjustment (viewport)
		end

	viewport: POINTER
			-- Pointer to viewport, used for reuse of adjustment functions from descendants.

feature {EV_ANY_I} -- Implementation

	interface: EV_VIEWPORT

end -- class EV_VIEWPORT_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

