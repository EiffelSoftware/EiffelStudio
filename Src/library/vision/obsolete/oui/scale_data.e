
-- Information given by ArchiVision when a scale value's value has been
-- changed.

indexing

	copyright: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class SCALE_DATA 

inherit 

	CONTEXT_DATA
		rename
			make as context_data_make
		end

creation

	make

feature 

	value: INTEGER;
			-- New value of scale

	make (a_widget: WIDGET; a_value: INTEGER) is
			-- Create a context_data for `value changed' action.
		do
			widget := a_widget;
			value := a_value
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
