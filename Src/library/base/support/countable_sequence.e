indexing

	description:
		"Infinite sequences, indexed by integers"

	status: "See notice at end of class"
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

	i_th (i: INTEGER): G is
			-- Item of rank `i'
		deferred
		end

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

	library: "[
			EiffelBase: Library of reusable components for Eiffel.
			]"

	status: "[
			Copyright 1986-2001 Interactive Software Engineering (ISE).
			For ISE customers the original versions are an ISE product
			covered by the ISE Eiffel license and support agreements.
			]"

	license: "[
			EiffelBase may now be used by anyone as FREE SOFTWARE to
			develop any product, public-domain or commercial, without
			payment to ISE, under the terms of the ISE Free Eiffel Library
			License (IFELL) at http://eiffel.com/products/base/license.html.
			]"

	source: "[
			Interactive Software Engineering Inc.
			ISE Building
			360 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Electronic mail <info@eiffel.com>
			Customer support http://support.eiffel.com
			]"

	info: "[
			For latest info see award-winning pages: http://eiffel.com
			]"

end -- class COUNTABLE_SEQUENCE


