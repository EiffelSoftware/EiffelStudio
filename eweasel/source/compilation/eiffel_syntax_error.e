indexing
	description: "An Eiffel syntax error"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "93/08/30"

class EIFFEL_SYNTAX_ERROR

inherit
	EIFFEL_ERROR
		redefine
			is_equal
		end

create
	make

feature {NONE} -- Initialization

	make (a_name: like class_name) is
			-- Create current with `a_name' as `class_name'.
		require
			a_name_not_void: a_name /= Void
		do
			class_name := a_name
		ensure
			class_name_set: class_name = a_name
		end

feature -- Properties

	line_number: INTEGER;
			-- Line number on which syntax error occurred

feature -- Modification

	set_line_number (n: INTEGER) is
		do
			line_number := n;
		end

feature -- Summary

	summary: STRING is
		do
			create Result.make (0);
			Result.append ("Syntax error in ");
			if equal (class_name, "") then
				Result.append ("Ace");
			elseif equal (class_name, "_USE_FILE") then
				Result.append ("%"Use%" file");
			else
				Result.append ("class ");
				Result.append (class_name);
			end;
			Result.append (" at line ");
			Result.append_integer (line_number);
		end;

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
		do
			Result := equal (class_name, other.class_name) and
				line_number = other.line_number
		end

	infix "<" (other: like Current): BOOLEAN is
		do
			Result := class_name < other.class_name or else
				(equal (class_name, other.class_name) and line_number < other.line_number)
		end

indexing
	copyright: "[
			Copyright (c) 1984-2007, University of Southern California and contributors.
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
