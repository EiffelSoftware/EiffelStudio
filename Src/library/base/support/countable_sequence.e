indexing

	description:
		"Infinite sequences, indexed by integers"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	names: countable_sequence, infinite_sequence;
	access: cursor, membership;
	contents: generic;
	date: "$Date$"
	revision: "$Revision$"

deferred class COUNTABLE_SEQUENCE [G]

inherit

	COUNTABLE [G]
		rename
			item as i_th
		end

	ACTIVE [G]
		export
			{NONE}
					fill, prune_all, put,
					prune,
					wipe_out, replace, remove
		end

	LINEAR [G]
		redefine
			linear_representation
		end

feature -- Access

	index: INTEGER
			-- Index of current position

	item: G is
			-- Item at current position
		do
			Result := i_th (index)
		end

feature -- Status report

	after: BOOLEAN is False
			-- Is current position past last item? (Answer: no.)

	extendible: BOOLEAN is False
			-- May items be added? (Answer: no.)

	prunable: BOOLEAN is False
			-- May items be removed? (Answer: no.)

	readable: BOOLEAN is True
			-- Is there a current item that may be read?
			-- (Answer: yes.)

	writable: BOOLEAN is False
			-- Is there a current item that may be written?
			-- (Answer: no.)

feature -- Cursor movement

	forth is
			-- Move to next position.
		do
			index := index + 1
		end

	start is
			-- Move to first position.
		do
			index := 1
		end

feature {NONE} -- Inapplicable

	extend (v: G) is
			-- Add `v' at end.
		do
		end

	finish is
			-- Move to last position.
		do
		ensure then
			failure: False
		end

	linear_representation: LINEAR [G] is
			-- Representation as a linear structure
		do
		end

	prune (v: G) is
			-- Remove first occurrence of `v', if any.
		do
		end

	put (v: G) is
			-- Add `v' to the right of current position.
		do
		end

	remove is
			-- Remove item to the right of current position.
		do
		end

	replace (v: G) is
			-- Replace by `v' item at current position.
		do
		end

	wipe_out is
			-- Remove all items.
		do
		end

indexing
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"







end -- class COUNTABLE_SEQUENCE


