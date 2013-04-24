note
	description: "[
					An Eiffel syntax error
																	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test"
	date: "$Date$"
	revision: "$Revision$"

class EQA_EW_EIFFEL_SYNTAX_ERROR

inherit
	EQA_EW_EIFFEL_ERROR
		redefine
			is_equal
		end

create
	make

feature {NONE} -- Initialization

	make (a_name: like class_name)
			-- Create current with `a_name' as `class_name'.
		require
			a_name_not_void: a_name /= Void
		do
			class_name := a_name
		ensure
			class_name_set: class_name = a_name
		end

feature -- Properties

	line_number: INTEGER
			-- Line number on which syntax error occurred

feature -- Modification

	set_line_number (a_n: INTEGER)
			-- Set `line_number' with `a_n'
		do
			line_number := a_n
		end

feature -- Summary

	summary: STRING
			-- Summary description for current
		do
			create Result.make (0)
			Result.append ("Syntax error in ")
			if equal (class_name, "") then
				Result.append ("Ace")
			elseif equal (class_name, "_USE_FILE") then
				Result.append ("%"Use%" file")
			else
				Result.append ("class ")
				Result.append (class_name)
			end
			Result.append (" at line ")
			Result.append_integer (line_number)
		end

feature -- Comparison

	is_equal (a_other: like Current): BOOLEAN
			-- <Precursor>
		do
			Result := equal (class_name, a_other.class_name) and
				line_number = a_other.line_number
		end

	is_less alias "<" (a_other: like Current): BOOLEAN
			-- <Precursor>
		do
			Result := class_name < a_other.class_name or else
				(equal (class_name, a_other.class_name) and line_number < a_other.line_number)
		end

;note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	copying: "[
			This file is part of the EiffelWeasel Eiffel Regression Tester.

			The EiffelWeasel Eiffel Regression Tester is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License version 2 as published
			by the Free Software Foundation.

			The EiffelWeasel Eiffel Regression Tester is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License version 2 for more details.

			You should have received a copy of the GNU General Public
			License version 2 along with the EiffelWeasel Eiffel Regression Tester
			if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"


end
