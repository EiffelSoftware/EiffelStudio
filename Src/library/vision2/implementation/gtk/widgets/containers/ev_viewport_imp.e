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
			interface,
			set_item_width,
			set_item_height
		end
		
	EV_CELL_IMP
		redefine
			interface,
			make,
			initialize,
			container_widget,
			visual_widget
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
			C.gtk_viewport_set_shadow_type (c_object, (App_implementation.gtk_marshal).Gtk_shadow_none_enum)
			C.gtk_widget_set_usize (c_object, 1, 1) -- Hack needed to prevent viewport resize on item resize.
		end
		
	initialize is
			-- Add a fixed to the viewport to get rid of default blackness.
		do
			container_widget := C.gtk_fixed_new
			C.gtk_widget_show (container_widget)
			C.gtk_container_add (viewport, container_widget)
			Precursor {EV_CELL_IMP}
		end

	container_widget: POINTER
			-- Pointer to the event box
	
	visual_widget: POINTER is
			-- 
		do
			Result := container_widget
		end
		
	fixed_width: INTEGER is
			-- Fixed Horizontal size measured in pixels.
		do
			Result := C.gtk_allocation_struct_width (
				C.gtk_widget_struct_allocation (container_widget)
			).max (0)
		end

	fixed_height: INTEGER is
			-- Fixed Vertical size measured in pixels.
		do
			Result := C.gtk_allocation_struct_height (
				C.gtk_widget_struct_allocation (container_widget)
			).max (0)
		end

feature -- Access

	x_offset: INTEGER is
			-- Horizontal position of viewport relative to `item'.
		do
			Result := internal_x_offset
		end

	y_offset: INTEGER is
			-- Vertical position of viewport relative to `item'.
		do
			Result := internal_y_offset
		end

feature -- Element change

	set_x_offset (a_x: INTEGER) is
			-- Set `x_offset' to `a_x'.
		local
			item_imp: EV_WIDGET_IMP
		do
			item_imp ?= item.implementation
			if a_x < 0 then
				C.gtk_widget_set_uposition (item_imp.c_object, -a_x, -1)
				internal_set_value_from_adjustment (horizontal_adjustment, 0)
			else
				C.gtk_widget_set_uposition (item_imp.c_object, 0, -1)
				internal_set_value_from_adjustment (horizontal_adjustment, a_x)
			end
			internal_x_offset := a_x
		end

	set_y_offset (a_y: INTEGER) is
			-- Set `y_offset' to `a_y'.
		local
			item_imp: EV_WIDGET_IMP
		do
			item_imp ?= item.implementation
			if a_y < 0 then
				C.gtk_widget_set_uposition (item_imp.c_object, -1, -a_y)
				internal_set_value_from_adjustment (vertical_adjustment, 0)
			else	
				C.gtk_widget_set_uposition (item_imp.c_object, -1, 0)
				internal_set_value_from_adjustment (vertical_adjustment, a_y)
			end
			internal_y_offset := a_y
		end
		
	set_item_width (a_width: INTEGER) is
			-- Set `a_widget.width' to `a_width'.
		local
			w_imp: EV_WIDGET_IMP
		do
			w_imp ?= item.implementation
			w_imp.set_fixed_size (a_width, -1)		
		end
		
	set_item_height (a_height: INTEGER) is
			-- Set `a_widget.height' to `a_height'.
		local
			w_imp: EV_WIDGET_IMP
		do
			w_imp ?= item.implementation
			w_imp.set_fixed_size (-1, a_height)		
		end	
		
	set_item_size (a_width, a_height: INTEGER) is
			-- Set `a_widget.width' to `a_width'.
			-- Set `a_widget.height' to `a_height'.
		local
			w_imp: EV_WIDGET_IMP
		do
			w_imp ?= item.implementation
			w_imp.set_fixed_size (a_width, a_height)		
		end

feature {NONE} -- Implementation

	internal_x_offset, internal_y_offset: INTEGER

	horizontal_adjustment: POINTER is
		do
			Result := C.gtk_viewport_get_hadjustment (viewport)
		end

	vertical_adjustment: POINTER is
		do
			Result := C.gtk_viewport_get_vadjustment (viewport)
		end

	internal_set_value_from_adjustment (l_adj: POINTER; a_value: INTEGER) is
			-- Set `value' of adjustment `l_adj' to `a_value'.
		require
			l_adj_not_null: l_adj /= default_pointer
		do
			if C.gtk_adjustment_struct_lower (l_adj) > a_value then
				C.set_gtk_adjustment_struct_lower (l_adj, a_value)
				C.gtk_adjustment_changed (l_adj)
			elseif C.gtk_adjustment_struct_upper (l_adj) < a_value then
				C.set_gtk_adjustment_struct_upper (l_adj, a_value)
				C.gtk_adjustment_changed (l_adj)				
			end
			C.gtk_adjustment_set_value (l_adj, a_value)
		ensure
			value_set: C.gtk_adjustment_struct_value (l_adj) = a_value
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

