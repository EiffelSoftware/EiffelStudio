indexing
	description:
		"Adapter from ARRAYED_LIST to BASIC"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class ARRAYED_ADAPTER [G] inherit

	ARRAYED_LIST [G]
		rename
			replace as list_replace, remove as list_remove
		export
			{NONE} all
		redefine
			extend
		end

create

	-- Not for instantiation

feature -- Element change

	extend (v: G) is
			-- Add `v' to end.
		do
			Precursor (v)
			if off then go_i_th (1) end
		ensure then
			not_off: not off
		end

	replace (v: G; i: INTEGER) is
			-- Replace `i'-th item with `v'.
		local
			old_idx: INTEGER
		do
			old_idx := index
			go_i_th (i)
			list_replace (v)
			go_i_th (old_idx)
		end

feature -- Removal

	remove (i: INTEGER) is
			-- Remove `i'-th.
		local
			old_idx: INTEGER
		do
			old_idx := index
			go_i_th (i)
			list_remove
			go_i_th (old_idx)
		end


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




end -- class ARRAYED_ADAPTER

