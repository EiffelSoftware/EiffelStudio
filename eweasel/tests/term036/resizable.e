note

	description:
		"Finite structures whose item count is subject to change"

	status: "See notice at end of class"
	names: storage;
	size: resizable;
	date: "$Date$"
	revision: "$Revision$"

deferred class RESIZABLE [G] inherit

	BOUNDED [G]

feature -- Measurement


	Growth_percentage: INTEGER = 50
			-- Percentage by which structure will grow automatically

	Minimal_increase: INTEGER = 5
			-- Minimal number of additional items

	additional_space: INTEGER
			-- Proposed number of additional items
			--| Result is a reasonable value, resulting from a space-time tradeoff.
		do
			Result := (capacity * Growth_percentage // 100).max (Minimal_increase)
		ensure
			At_least_one: Result >= 1
		end

feature -- Status report

	resizable: BOOLEAN
			-- May `capacity' be changed? (Answer: yes.)
		do
			Result := True
		end

feature -- Resizing

	automatic_grow
			-- Change the capacity to accommodate at least
			-- `Growth_percentage' more items.
			--| Trades space for time:
			--| allocates fairly large chunks of memory but not very often.
		do
			grow (capacity + additional_space)
		ensure
			increased_capacity:
				capacity >= old capacity + old capacity * Growth_percentage // 100
		end

	grow (i: INTEGER)
			-- Ensure that capacity is at least `i'.
		deferred
		ensure
			new_capacity: capacity >= i
		end

invariant

	increase_by_at_least_one: Minimal_increase >= 1

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

end -- class RESIZABLE


