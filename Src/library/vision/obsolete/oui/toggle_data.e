
-- Information given by ArchiVision when a toggle button's value has been
-- changed.

indexing

	date: "$Date$";
	revision: "$Revision$"

class TOGGLE_DATA 

inherit 

	CONTEXT_DATA
		rename
			make as context_data_make
		end

creation

	make

feature 

	state: BOOLEAN;
			-- New state of toggle button

	make (a_widget: WIDGET; a_state: BOOLEAN) is
			-- Create a context_data for `value changed' action.
		do
			widget := a_widget;
			state := a_state
		end

end


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
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
