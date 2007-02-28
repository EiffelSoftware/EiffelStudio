indexing
	description: "[
		Sequences of values, all of the same type or of a conforming one,
		accessible through integer indices in a contiguous interval.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	date: "$Date$"
	revision: "$Revision$"

frozen external class
	NATIVE_ARRAY [G]

inherit
	SYSTEM_ARRAY

create
	make

feature {NONE} -- Initialization

	make (n: INTEGER) is
			-- Create an array with `n' elements.
		do
			-- Built-in
		end

feature -- Access

	item, infix "@" (i: INTEGER): G is
			-- Entry at index `i', if in index interval
		do
			-- Built-in
		end

feature -- Measurement

	upper: INTEGER is
			-- Maximum index.
		do
			Result := count - 1
		end

	lower: INTEGER is 0
			-- Minimum index.

	count: INTEGER is
			-- Number of available indices.
		do
			-- Built-in
		end

feature -- Element change

	put (i: INTEGER; v:G) is
			-- Replace `i'-th entry, if in index interval, by `v'.
		do
			-- Built-in
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


end -- class NATIVE_ARRAY


