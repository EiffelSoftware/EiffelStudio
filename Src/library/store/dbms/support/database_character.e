indexing
	description: "Character format of the database";
	date: "$Date$";
	revision: "$Revision$"

class 
	DATABASE_CHARACTER [G -> DATABASE create default_create end]

inherit

	DB_TYPE
		redefine
			eiffel_name
		end

	HANDLE_SPEC [G]

feature -- Status report

	sql_name: STRING is
			-- SQL type name for character
		do
			Result := db_spec.sql_name_character
		end
	
	eiffel_name: STRING is
			-- Eiffel type name for character
		once
			Result := "CHARACTER"
		ensure then
			Result.is_equal ("CHARACTER")
		end

	eiffel_ref: CHARACTER_REF is
			-- Shared character reference 
		once
			create Result
		end

end -- class DATABASE_CHARACTER

--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact: http://contact.eiffel.com
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

