indexing
	description: "Real format of the database";
	date: "$Date$"
	revision: "$Revision$"

class 
	DATABASE_REAL [G -> DATABASE create default_create end]

inherit

	DB_TYPE
		redefine
			eiffel_name
		end

	HANDLE_SPEC [G]

feature -- Status report

	sql_name: STRING is
			-- SQL type name for real
		do
			Result := db_spec.sql_name_real
		end
	
	eiffel_name: STRING is
			-- Eiffel type name for real
		once
			Result := "REAL"
		ensure then
			Result.is_equal ("REAL")
		end

	eiffel_ref: REAL_REF is
			-- Shared real reference
		once
			create Result
		end

end -- class DATABASE_REAL


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
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

