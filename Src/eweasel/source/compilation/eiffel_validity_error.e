indexing
	description: "An Eiffel validity error"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "93/08/30"

class EIFFEL_VALIDITY_ERROR

inherit
	ANY
		redefine
			is_equal
		end

feature -- Properties

	class_name: STRING;
			-- Class in which error occurred

	validity_code: STRING;
			-- Validity code which was violated

feature -- Modification

	set_class_name (name: STRING) is
		do
			class_name := name;
		end;

	set_validity_code (code: STRING) is
		do
			validity_code := code;
		end

feature -- Summary

	summary: STRING is
		do
			create Result.make (0);
			Result.append ("Validity error");
			if not equal (class_name, "")  then
				Result.append (" in class ");
				Result.append (class_name);
			end;
			Result.append (" code ");
			if validity_code /= Void then
				Result.append (validity_code);
			end;
		end;

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
		do
			Result := equal (class_name, other.class_name) and
				equal (validity_code, other.validity_code);
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
