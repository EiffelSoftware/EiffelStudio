indexing

	description: "This class represents a MS_IMPone-line text editor for entering a password";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	PASSWORD_IMP

inherit
	PASSWORD_I

	TEXT_FIELD_IMP
		redefine
			default_style
		select
			default_style
		end

	TEXT_FIELD_IMP
		rename
			default_style as text_field_default_style
		end
creation
	make

feature
	default_style: INTEGER is
		once
			Result := text_field_default_style + Es_password
		end

end -- class PASSWORD_IMP


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

