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
