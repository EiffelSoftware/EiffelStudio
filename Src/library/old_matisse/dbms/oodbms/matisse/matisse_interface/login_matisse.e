indexing

    Product: EiffelStore
    Database: Matisse

class LOGIN_MATISSE

feature -- Status setting

	set (h_name,d_name: STRING) is
		-- Set host name and database name before connection becomes possible.
		 require
			arguments_not_void : h_name /= Void and d_name /= Void
			arguments_not_empty : not ( h_name.empty or d_name.empty)
		do
			host_name := clone (h_name)
			database_name := clone (d_name)
		ensure
			host_name.is_equal (h_name)
			database_name.is_equal (d_name)
		end -- set

feature -- Access

	host_name: STRING  -- Client Host name

	database_name: STRING -- Name of database beeing used

end -- class LOGIN_MATISSE

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

