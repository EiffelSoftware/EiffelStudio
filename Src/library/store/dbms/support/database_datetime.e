indexing
	description: "DATE_TIME format of the database";
	date: "$Date$"
	revision: "$Revision$"

class 
	DATABASE_DATETIME [G -> DATABASE create default_create end]

inherit

	DB_TYPE

	HANDLE_SPEC [G]

feature -- Status report

	sql_name: STRING is
			-- SQL type name for date
		do
			Result := db_spec.sql_name_datetime
		end
	
	eiffel_ref: DATE_TIME is
			-- Shared absolute date reference 
		once
			create Result.make_now
		end

end -- class DATABASE_DATETIME

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

