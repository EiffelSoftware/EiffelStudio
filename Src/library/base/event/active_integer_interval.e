indexing
	description: "[
		Contiguous integer interval that calls an action sequence
		when it changes.
		]"
	status: "See notice at end of class"
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
			Precursor {INTEGER_INTERVAL} (other)
			on_change
		end

feature -- Element change
	
	extend (v: INTEGER) is
			-- Make sure that interval goes all the way
			-- to `v' (up or down).
		do
			Precursor {INTEGER_INTERVAL}(v)
			on_change
		end

	put (v: INTEGER) is
			-- Make sure that interval goes all the way
			-- to `v' (up or down).
		do
			Precursor {INTEGER_INTERVAL}(v)
			on_change
		end

feature -- Resizing

	resize (min_index, max_index: INTEGER) is
			-- Rearrange interval to go from at most
			-- `min_index' to at least `max_index',
			-- encompassing previous bounds.
		do	 
			Precursor {INTEGER_INTERVAL} (min_index, max_index)
			on_change
		end

	resize_exactly (min_index, max_index: INTEGER) is
			-- Rearrange interval to go from
			-- `min_index' to `max_index'.
		do	 
			Precursor {INTEGER_INTERVAL} (min_index, max_index)
			on_change
		end

feature -- Duplication

	copy (other: like Current) is
			-- Reset to be the same interval as `other'.
		do
			Precursor {INTEGER_INTERVAL} (other)
			on_change
		end

feature -- Event handling

	change_actions: ACTION_SEQUENCE [TUPLE []] is
			-- Actions performed when interval changes.
		do
			if opo_change_actions = Void then
				create opo_change_actions
			end
			Result := opo_change_actions
		ensure
			not_void: Result /= Void
		end

feature {NONE} -- Implementation

	on_change is
			-- Called when interval changes.
		do
			if opo_change_actions /= Void then
				opo_change_actions.call (Void)
			end
		end

	opo_change_actions: ACTION_SEQUENCE [TUPLE []];
			-- Once per object implementation for `change_actions'

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

end -- class ACTIVE_INTEGER_INTERVAL

