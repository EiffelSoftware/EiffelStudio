indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class RESIZE_CONTEXT_DATA 

inherit

    CONTEXT_DATA
	rename
	    make as old_make
	end

creation
    make

feature 

	make (a_widget: WIDGET; w,h, wparm : INTEGER) is
                        -- Create a context_data for `ResizeRequest' event.
		do
			widget := a_widget
			width := w
			height := h
			wparam := wparm
		end

feature -- Access

	height: INTEGER
	
	width: INTEGER

	wparam : INTEGER

end -- class RESIZE_CONTEXT_DATA



--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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

