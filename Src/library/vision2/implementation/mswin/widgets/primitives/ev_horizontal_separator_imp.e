indexing 
	description: "EiffelVision horizontal separator,%
			% windows implementation."
	status: "See notice at end of class"
	date: "$Date$";
	revision: "$Revision$"

class
	EV_HORIZONTAL_SEPARATOR_IMP

inherit
	EV_HORIZONTAL_SEPARATOR_I

	EV_SEPARATOR_IMP
		undefine
			set_default_options
		redefine
			set_default_minimum_size
		end

creation
	make

feature -- Status setting

   	set_default_minimum_size is
   			-- Plateform dependant initializations.
   		do
			set_minimum_height (2)
 		end

feature {NONE} -- Implementation

	on_paint (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
		local
			top: INTEGER
		do
			paint_dc.select_pen (shadow_pen)
			paint_dc.line (0, height // 2 - 1, width, height // 2 - 1)
			paint_dc.select_pen (highlight_pen)
			paint_dc.line (0, height // 2, width, height // 2)
		end

end -- class EV_HORIZONTAL_SEPARATOR_IMP

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
