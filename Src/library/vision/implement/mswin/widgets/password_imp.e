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
create
	make

feature
	default_style: INTEGER is
		once
			Result := text_field_default_style + Es_password
		end

end -- class PASSWORD_IMP

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

