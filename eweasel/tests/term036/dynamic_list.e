note

	description: "[
		Sequential, dynamically modifiable lists,
		without commitment to a particular representation
		]"

	status: "See notice at end of class"
	names: dynamic_list, sequence;
	access: index, cursor, membership;
	contents: generic;
	date: "$Date$"
	revision: "$Revision$"

deferred class DYNAMIC_LIST [G] inherit

	LIST [G]
		undefine
			prune,
			sequential_index_of, sequential_has,
			remove, prune_all
		end

	DYNAMIC_CHAIN [G]
		rename
			wipe_out as chain_wipe_out
		export
			{NONE} chain_wipe_out
		undefine
			is_equal
		redefine
			put_right,
			remove_left, remove_right
		end

	DYNAMIC_CHAIN [G]
		undefine
			is_equal
		redefine
			put_right,
			remove_left, remove_right, wipe_out
		select
			wipe_out
		end

feature -- Element change

	put_left (v: like item)
			-- Add `v' to the left of cursor position.
			-- Do not move cursor.
		local
			temp: like item
		do
			if is_empty then
				put_front (v)
			elseif after then
				back
				put_right (v)
				move (2)
			else
				temp := item
				replace (v)
				put_right (temp)
				forth
			end
		end

	put_right (v: like item)
			-- Add `v' to the right of cursor position.
			-- Do not move cursor.
		deferred
		end

	merge_left (other: like Current)
			-- Merge `other' into current structure before cursor
			-- position. Do not move cursor. Empty `other'.
		do
			from
				other.start
			until
				other.is_empty
			loop
				put_left (other.item)
				other.remove
			end
		end

	merge_right (other: like Current)
			-- Merge `other' into current structure after cursor
			-- position. Do not move cursor. Empty `other'.
		do
			from
				other.finish
			until
				other.is_empty
			loop
				put_right (other.item)
				other.back
				other.remove_right
			end
		end

feature -- Removal

	remove
			-- Remove current item.
			-- Move cursor to right neighbor
			-- (or `after' if no right neighbor).
		deferred
		ensure then
			after_when_empty: is_empty implies after
		end

	remove_left
			-- Remove item to the left of cursor position.
			-- Do not move cursor.
		require else
			not_before: not before
		deferred
		end

	remove_right
			-- Remove item to the right of cursor position.
			-- Do not move cursor.
		deferred
		end

	wipe_out
			-- Remove all items.
		do
			chain_wipe_out
			back
		ensure then
			is_before: before
		end

note

	library: "[
			EiffelBase: Library of reusable components for Eiffel.
			]"

	status: "[
--| Copyright (c) 1993-2006 University of Southern California and contributors.
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

end -- class DYNAMIC_LIST



