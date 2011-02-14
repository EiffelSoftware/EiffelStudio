note
	description: "String_32 tools"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

class
	DATABASE_STRING_32_EX [G -> DATABASE create default_create end]

inherit

	STRING_32

	HANDLE_SPEC [G]
		undefine
			is_equal, out, copy
		end

create -- Creation procedure

	make

feature -- Status setting

	get_value (no_descriptor: INTEGER; index: INTEGER)
			-- Put in `Current' value of index-th column of selection.
		do
			set_count (db_spec.put_data_32 (no_descriptor, index, Current, capacity))
		ensure
			capacity_unchanged: capacity = old capacity
		end

feature -- Element Change

	force_right_adjust
			-- Remove all trailing whitespace.
		local
			i, nb: INTEGER
			nb_space: INTEGER
			l_area: like area
		do
				-- Compute number of spaces at the right of current string.
			from
				nb := count - 1
				i := nb
				l_area := area
			until
				i < 0 or else not l_area.item (i).is_character_8 or else not l_area.item (i).is_space
			loop
				nb_space := nb_space + 1
				i := i - 1
			end

			if nb_space > 0 then
					-- Set new count.
				count := nb + 1 - nb_space
				internal_hash_code := 0
			end
		end

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




end -- class DATABASE_STRING_EX


