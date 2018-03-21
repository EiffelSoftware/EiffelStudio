note
	description: "An Eiffel syntax error"
	legal: "See notice at end of class."
	status: "See notice at end of class."

deferred class
	EW_EIFFEL_ERROR

inherit
	COMPARABLE
		redefine
			is_equal
		end

feature -- Properties

	class_name: READABLE_STRING_32
			-- Class in which error occurred.

	line_number: INTEGER
			-- Line number on which the error occurred (`0` if unknown).

feature -- Status report

	has_line_number: BOOLEAN
			-- Is line number known?
		do
			Result := line_number > 0
		end

feature -- Modification

	set_class_name (a_name: like class_name)
			-- Set `class_name' with `a_name'.
		require
			a_name_not_void: a_name /= Void
		do
			class_name := a_name
		ensure
			class_name_set: class_name = a_name
		end

	set_line_number (n: INTEGER)
			-- Set `line_number` to `n`.
		do
			line_number := n
		ensure
			line_number_set: line_number = n
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
		do
			Result :=
				other.class_name.same_string (class_name) and
				line_number = other.line_number
		end

	is_less alias "<" (other: like Current): BOOLEAN
		do
			Result := class_name < other.class_name or else
				(other.class_name.same_string (class_name) and line_number < other.line_number)
		end

	matches_pattern (other: like Current): BOOLEAN
			-- Are the properties which are explicitly specified in `other'
			-- equal to those in `Current'?
		do
			Result :=
				other.class_name.same_string (class_name) and
				(other.line_number = 0 or else line_number = other.line_number)
		end

feature -- Output

	summary: STRING_32
			-- Short description of the error.
		deferred
		end

invariant
	class_name_not_void: class_name /= Void

note
	date: "$Date$"
	revision: "$Revision$"
	copyright: "[
			Copyright (c) 1984-2018, University of Southern California, Eiffel Software and contributors.
			All rights reserved.
		]"
	license:   "Your use of this work is governed under the terms of the GNU General Public License version 2"
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

end
