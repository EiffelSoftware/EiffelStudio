indexing
	description: "String composition constants"
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_COMPOSITION_STRING_CONSTANTS

feature -- Constants

	Gcs_compreadstr : INTEGER is 1

	Gcs_compreadattr : INTEGER is 2

	Gcs_compreadclause : INTEGER is 4

	Gcs_compstr : INTEGER is 8

	Gcs_compattr: INTEGER is 16

	Gcs_compclause : INTEGER is 32

	Gcs_cursorpos : INTEGER is 64

	Gcs_deltastart : INTEGER is 128

	Gcs_resultreadstr  : INTEGER is 256

	Gcs_resultreadclause : INTEGER is 512

	Gcs_resultstr : INTEGER is 1024

	Gcs_resultclause : INTEGER is 2048

	Scs_setstr: INTEGER is 9
			-- Combination of Gcs_compreadstr | Gcs_compstr

	Scs_changeattr: INTEGER is 18
			-- Combination of Gcs_compreadattr |Gcs_compattr

	Scs_changeclause: INTEGER is 36
			-- Combination of Gcs_compreadclause | Gcs_compclause

	Scs_setreconvertstring: INTEGER is 65536

	Scs_queryreconvertstring: INTEGER is 131072;


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

end
