indexing
	description: "EiffelVision drawing area. Implementation interface."
	note: "The class doesn't inherit from EV_PRIMITIVE_IMP%
		% because, it is not a WEL_CONTROL. Then, it inherits%
		% from EV_WIDGET_IMP directly."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_DRAWING_AREA_IMP

inherit
	EV_DRAWING_AREA_I

	EV_DRAWABLE_IMP
		
	EV_WIDGET_IMP

	WEL_CONTROL_WINDOW
		rename
			make as wel_make,
			parent as wel_parent
		undefine
			set_width,
			set_height,
			remove_command,
			on_left_button_down,
			on_mouse_move,
			on_left_button_up,
			on_right_button_down,
			on_right_button_up,
			on_left_button_double_click,
			on_right_button_double_click,
			on_char,
			on_key_up
		redefine
			on_paint,
			on_wm_erase_background,
			destroy
		end

creation
		make

feature -- Access

	memory_dc: WEL_MEMORY_DC is
			-- DC on which, we draw the pictures. It is a memory
			-- dc because it allow us to repaint the drawing area
			-- each time a Wm_paint message is send by windows.
		do
			Result := pixmap_imp
		end

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create an empty drawing area.
		local
			par_imp: EV_CONTAINER_IMP
		do
			par_imp ?= par.implementation
			check
				par_imp /= Void
			end
			wel_make (par_imp, "Drawing area")
		end

feature {NONE} -- Implementation

	on_paint (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
			-- Wm_paint message.
			-- May be redefined to paint something on
			-- the `paint_dc'. `invalid_rect' defines
			-- the invalid rectangle of the client area that
			-- needs to be repainted.
		do
			paint_dc.select_palette (pixmap_imp.palette)
			paint_dc.copy_dc (pixmap_imp, client_rect)
		end

	destroy is
			-- Destroy the widget, but set the parent sensitive
			-- in case it was set insensitive by the child.
		do
			if parent_imp /= Void then
				parent_imp.set_insensitive (False)
			end
			{WEL_CONTROL_WINDOW} Precursor
		end

feature {NONE} -- Implementation

	on_wm_erase_background (wparam: INTEGER) is
   			-- Wm_erasebkgnd message.
   			-- A WEL_DC and WEL_PAINT_STRUCT are created and passed to the
   			-- `on_erase_background' routine.
   			-- To be more efficient when the windows does not have a `background_brush'
   			-- attribute set, this routine does nothing.
   			-- (from WEL_FRAME_WINDOW)
   			-- (export status {NONE})
   		do
 				disable_default_processing
 		end

end -- class EV_DRAWING_AREA_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
