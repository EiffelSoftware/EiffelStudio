
-- Information given by ArchiVision when a callback is triggered.

indexing

	copyright: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class CONTEXT_DATA 

creation

	make

feature 

	widget: WIDGET;
			-- The widget who triggered the callback

	make (a_widget: WIDGET) is
			-- Create a general context_data.
		do
			widget := a_widget
		end

end


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
