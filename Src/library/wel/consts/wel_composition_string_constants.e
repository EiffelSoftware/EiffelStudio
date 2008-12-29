note
	description: "String composition constants"
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_COMPOSITION_STRING_CONSTANTS

feature -- Constants

	Gcs_compreadstr : INTEGER = 1

	Gcs_compreadattr : INTEGER = 2

	Gcs_compreadclause : INTEGER = 4

	Gcs_compstr : INTEGER = 8

	Gcs_compattr: INTEGER = 16

	Gcs_compclause : INTEGER = 32

	Gcs_cursorpos : INTEGER = 64

	Gcs_deltastart : INTEGER = 128

	Gcs_resultreadstr  : INTEGER = 256

	Gcs_resultreadclause : INTEGER = 512

	Gcs_resultstr : INTEGER = 1024

	Gcs_resultclause : INTEGER = 2048

	Scs_setstr: INTEGER = 9
			-- Combination of Gcs_compreadstr | Gcs_compstr

	Scs_changeattr: INTEGER = 18
			-- Combination of Gcs_compreadattr |Gcs_compattr

	Scs_changeclause: INTEGER = 36
			-- Combination of Gcs_compreadclause | Gcs_compclause

	Scs_setreconvertstring: INTEGER = 65536

	Scs_queryreconvertstring: INTEGER = 131072;


note
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
