indexing
	description: "[
		Contiguous integer interval that calls an action sequence
		when it changes.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "event, action, linked, list"
	date: "$Date$"
	revision: "$Revision$"

class
	ACTIVE_INTEGER_INTERVAL

inherit
	INTEGER_INTERVAL
		redefine
			extend, put,
			resize,
			resize_exactly,
			copy,
			adapt
		end

create
	make

feature -- Initialization

	adapt (other: INTEGER_INTERVAL) is
			-- Reset to be the same interval as `other'.
		do
			Precursor (other)
			on_change
		end

feature -- Element change

	extend (v: INTEGER) is
			-- Make sure that interval goes all the way
			-- to `v' (up or down).
		do
			put (v)
		end

	put (v: INTEGER) is
			-- Make sure that interval goes all the way
			-- to `v' (up or down).
		local
			l_change: BOOLEAN
		do
			l_change := v < lower_internal or else v > upper_internal
			Precursor (v)
			if l_change then
				on_change
			end
		end

feature -- Resizing

	resize (min_index, max_index: INTEGER) is
			-- Rearrange interval to go from at most
			-- `min_index' to at least `max_index',
			-- encompassing previous bounds.
		local
			l_change: BOOLEAN
		do
			l_change := lower_internal /= min_index or else upper_internal /= max_index
			Precursor (min_index, max_index)
			if l_change then
				on_change
			end
		end

	resize_exactly (min_index, max_index: INTEGER) is
			-- Rearrange interval to go from
			-- `min_index' to `max_index'.
		local
			l_change: BOOLEAN
		do
			l_change := lower_internal /= min_index or else upper_internal /= max_index
			Precursor (min_index, max_index)
			if l_change then
				on_change
			end
		end

feature -- Duplication

	copy (other: like Current) is
			-- Reset to be the same interval as `other'.
		do
			Precursor (other)
			on_change
		end

feature -- Event handling

	change_actions: ACTION_SEQUENCE [TUPLE] is
			-- Actions performed when interval changes.
		local
			r: ?ACTION_SEQUENCE [TUPLE]
		do
			r := opo_change_actions
			if r = Void then
				create r
				opo_change_actions := r
			end
			Result := r
		ensure
			not_void: Result /= Void
		end

feature {NONE} -- Implementation

	on_change is
			-- Called when interval changes.
		local
			a: ?ACTION_SEQUENCE [TUPLE]
		do
			a := opo_change_actions
			if a /= Void then
				a.call (Void)
			end
		end

	opo_change_actions: ?ACTION_SEQUENCE [TUPLE];
			-- Once per object implementation for `change_actions'

indexing
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2008, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class ACTIVE_INTEGER_INTERVAL

