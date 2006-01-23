indexing
	description: ""
	legal: "See notice at end of class."
	status: "See notice at end of class.";
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class TYPES


