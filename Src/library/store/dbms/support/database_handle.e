indexing
	description: "Specific handle";
	date: "$Date$"
	revision: "$Revision$"

class 
	DATABASE_HANDLE [G -> DATABASE create default_create end]

feature -- Status report

	login: LOGIN [G]
		-- Session login

feature -- Status setting

	set_login (other: LOGIN [G]) is
		-- Get `other' login for handle
		require
			login_not_void: other /= Void
		do
			login := other
		ensure
			login = other
		end

end -- class DATABASE_HANDLE

--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
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
