indexing
	description: "String format of the database";
	date: "$Date$"
	revision: "$Revision$"

class 
	DATABASE_STRING [G -> DATABASE create default_create end]

inherit

	DB_TYPE

	HANDLE_SPEC [G]

feature -- Status report

	sql_name: STRING is
			-- SQL type name of string
		do
			Result := db_spec.sql_name_string
		end
	
	eiffel_ref: STRING is
			-- Shared string reference
		once
			create Result.make (0)
		end

end -- class DATABASE_STRING

--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact: http://contact.eiffel.com
--| Customer support: http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
