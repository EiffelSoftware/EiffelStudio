indexing
	description:
		"EiffelVision vertical separator, gtk implementation";
	status: "See notice at end of class."
	date: "$Date$";
	revision: "$Revision$"

class
	EV_VERTICAL_SEPARATOR_IMP

inherit

	EV_VERTICAL_SEPARATOR_I

	EV_SEPARATOR_IMP
		undefine
			set_default_options
		end

creation
	make

feature {NONE} -- Initialization

	make is
                        -- Create a gtk seperator
                do
                        widget := gtk_vseparator_new
			gtk_object_ref (widget)
                end

end -- class EV_VERTICAL_SEPARATOR_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
