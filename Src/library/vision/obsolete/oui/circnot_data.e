indexing

	description:
		"Information given by EiffelVision when a window is placed on top %
		%or on bottom of the stacking order. %
		%X event associated: `CirculateNotify'";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class CIRCNOT_DATA 

obsolete
	"Use class CONTEXT_DATA instead."

inherit

	CONTEXT_DATA
		rename
			make as context_data_make
		end

create

	make

feature 

	make (a_widget: WIDGET; arg_is_placed_on_top: BOOLEAN) is
			-- Create a context_data for `CirculateNotify' event.
		do
			widget := a_widget;
			is_placed_on_top := arg_is_placed_on_top
		end;

	is_placed_on_top: BOOLEAN
			-- Is the window placed on top of stacking order ?

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

