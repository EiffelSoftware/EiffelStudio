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
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
