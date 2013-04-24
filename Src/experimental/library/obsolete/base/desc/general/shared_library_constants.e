note

	description:
		"Constants used by DESC (Dynamic External Shared Call) mechanism"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class SHARED_LIBRARY_CONSTANTS

obsolete
	"This class should no longer be used due to platform dependence and non-64bit compliance"

feature -- Access

	T_array: INTEGER = 0

	T_boolean: INTEGER = 1

	T_character: INTEGER = 2

	T_double: INTEGER = 3

	T_integer: INTEGER = 4

	T_no_type: INTEGER = 10

	T_pointer: INTEGER = 5

	T_real: INTEGER = 6

	T_reference: INTEGER = 7

	T_short_integer: INTEGER = 8

	T_string: INTEGER = 9

feature -- Status report

	Library_freed: INTEGER = 3

	No_error: INTEGER = 0

	No_library: INTEGER = 1

	No_routine: INTEGER = 2;

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





end -- class SHARED_LIBRARY_CONSTANTS


