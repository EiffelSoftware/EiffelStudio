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

create

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
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

