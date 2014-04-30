note
	description: ""
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	TYPES [G -> DATABASE create default_create end]

obsolete
	"Use {DB_TYPES} constants instead to access the database types."

inherit
	HANDLE_SPEC [G]

	DB_TYPES
		rename
			string_type as string_type_database,
			string_32_type as wide_string_type_database,
			character_type as character_type_database,
			integer_32_type as integer_32_type_database,
			integer_16_type as integer_16_type_database,
			integer_64_type as integer_64_type_database,
			real_64_type as real_64_type_database,
			real_32_type as real_32_type_database,
			boolean_type as boolean_type_database,
			date_type as date_type_database,
			decimal_type as decimal_type_database,
			binary_type as binary_type_database
		end

feature -- Access

	Integer_type_database: INTEGER
			-- Integer type code in Ingres
		do
			Result := integer_32_type_database
		end

	Float_type_database: INTEGER
			-- Double type code in Ingres
      do
         Result := real_64_type_database
      end

	Real_type_database: INTEGER
			-- Real type code in Ingres
        do
            Result := real_32_type_database
        end

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class TYPES


