indexing
	description: "[
		Sequences of values, all of the same type or of a conforming one,
		accessible through integer indices in a contiguous interval.
		]"
	date: "$Date$"
	revision: "$Revision$"

external frozen class
	NATIVE_ARRAY [G -> SYSTEM_OBJECT]

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
			-- Minimum index.
		do
			-- Built-in
		end

	lower: INTEGER is
			-- Maximum index.
		do
			-- Built-in
		end

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

end -- class NATIVE_ARRAY


