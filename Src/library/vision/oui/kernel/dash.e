indexing

	description: "Description of a dash pattern"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	DASH 

inherit

	LINKED_LIST [INTEGER]

create

	make

feature -- Access

	offset: INTEGER;
			-- How many pixels into the patterns the line should actually begin

feature -- Measurement

	max_offset: INTEGER is
			-- Sum of integers in the list
			-- `offset' must be less than `max_offset'
		local
			keep_cursor: CURSOR;
		do
			keep_cursor := cursor;
			from
				start
			until
				off
			loop
				Result := Result+item;
				forth
			end;
			go_to (keep_cursor)
		end;

feature -- Element change

	set_offset (new_offset: INTEGER) is
			-- Set `offset' to `new_offset'.
		require
			offset_large_enough: offset >= 0;
			offset_small_enough: (not is_empty) implies (offset < max_offset)
		do
			offset := new_offset
		ensure
			offset = new_offset
		end

invariant

	non_negative_offset: offset >= 0;
	not_empty_offset_in_bound: (not is_empty) implies (offset <= max_offset)

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class DASH

