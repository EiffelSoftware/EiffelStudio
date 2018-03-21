note
	description: "An Eiffel test error list"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class EW_ERROR_LIST

inherit
	EW_SHARED_OBJECTS

create
	make

feature {NONE} -- Creation

	make
		do
			create list.make
		end

feature -- Modification

	add (err: EW_ERROR)
		do
			list.extend (err)
		end

	add_list (other: EW_ERROR_LIST)
			-- Add `other' to end of `Current'.
		do
			list.append (other.list)
		end

feature -- Display

	display
			-- Display `Current' in order.
		do
			across
				list as l
			loop
				l.item.display
				output.append_new_line
			end
		end

feature {EW_ERROR_LIST} -- Implementation

	list: LINKED_LIST [EW_ERROR]

;note
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
