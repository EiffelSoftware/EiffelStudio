indexing
	description: "An Eiffel test error list"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "93/08/30"

class EW_ERROR_LIST

inherit
	EW_SHARED_OBJECTS

create
	make

feature -- Creation

	make is
		do
			create list.make;
		end;

feature -- Properties

feature -- Modification
	
	add (err: EW_ERROR) is
		do
			list.extend (err);
		end;
	
	add_list (other: EW_ERROR_LIST) is
			-- Add `other' to end of `Current'
		local
			other_list: LINKED_LIST [EW_ERROR];
		do
			from
				other_list := other.list;
				other_list.start;
			until
				other_list.after
			loop	
				list.extend (other_list.item);
				other_list.forth;
			end	
		end
	
feature -- Display
	
	display is
			-- Display `Current' in order.
		do
			from
				list.start
			until
				list.after
			loop
				list.item.display
				output.append_new_line
				list.forth
			end
		end
	
feature {EW_ERROR_LIST} -- Implementation

	list: LINKED_LIST [EW_ERROR];
	
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
