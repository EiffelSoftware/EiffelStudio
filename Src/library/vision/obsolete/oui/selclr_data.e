indexing

	description:
		"Information given by EiffelVision when the selection's owner changes. %
		%X event associated: `SelectionClear'";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class SELCLR_DATA 

obsolete
	"Use class CONTEXT_DATA instead."

inherit

	CONTEXT_DATA
		undefine
			make
		end

creation

	make

feature 

	make (a_widget: WIDGET) is
			-- Create a context_data for `SelectionClear' event.
		do
			widget := a_widget
		end

end


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1997 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
