indexing
	description: "An Eiffel syntax error"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EIFFEL_ERROR

inherit
	COMPARABLE

feature -- Properties

	class_name: STRING
			-- Class in which error occurred

feature -- Setting

	set_class_name (a_name: like class_name) is
			-- Set `class_name' with `a_name'.
		require
			a_name_not_void: a_name /= Void
		do
			class_name := a_name
		ensure
			class_name_set: class_name = a_name
		end

invariant
	class_name_not_void: class_name /= Void

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
