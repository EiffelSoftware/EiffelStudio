indexing
	description: "";
	date: "$Date$";
	revision: "$Revision$"

class 
	TYPES [G -> DATABASE create default_create end]

inherit
	
	HANDLE_SPEC [G]

feature -- Conversion

	String_type_database: INTEGER is
			-- String type code in Ingres
		once
			Result := db_spec.c_string_type
		end

	Character_type_database: INTEGER is
			-- Character type code in Ingres
		once
			Result := db_spec.c_character_type
		end

	Integer_type_database: INTEGER is
			-- Integer type code in Ingres
		once
			Result := db_spec.c_integer_type
		end

	Float_type_database: INTEGER is
			-- Double type code in Ingres
      once
         Result := db_spec.c_float_type
      end
	
	Real_type_database: INTEGER is
			-- Real type code in Ingres
        once
            Result := db_spec.c_real_type
        end

	Boolean_type_database: INTEGER is
			-- Boolean type code in Ingres
		once
			Result := db_spec.c_boolean_type
		end

	Date_type_database: INTEGER is
			-- Datetime type code in Ingres
		once
			Result := db_spec.c_date_type
		end

end -- class TYPES


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

