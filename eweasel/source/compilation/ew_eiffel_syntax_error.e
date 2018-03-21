note
	description: "An Eiffel syntax error"
	legal: "See notice at end of class."
	status: "See notice at end of class."

class EW_EIFFEL_SYNTAX_ERROR

inherit
	EW_EIFFEL_ERROR

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

feature -- Summary

	summary: STRING_32
		do
			Result := {STRING_32} "Syntax error in "
			if class_name.is_empty then
				Result.append ({STRING_32} "Ace")
			elseif class_name.same_string ({STRING_32} "_USE_FILE") then
				Result.append ({STRING_32} "%"Use%" file")
			else
				Result.append ({STRING_32} "class ")
				Result.append (class_name)
			end;
			Result.append ({STRING_32} " at line ")
			Result.append_integer (line_number)
		end

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
