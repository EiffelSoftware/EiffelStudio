indexing

	description:
		"Information given by EiffelVision when `NoExpose' event is triggered. %
		%Not implemented because EiffelVision doesn't yet give any features %
		%to copy areas of window and so this event should never be triggered. %
		%X event associated: `NoExpose'";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class NOEXP_DATA 

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
			-- Create a context_data for `NoExpose' event.
		do
			widget := a_widget
		end

end



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

