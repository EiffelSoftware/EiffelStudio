external class
	ARRAY [G]

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

feature

	put (i: INTEGER; v:G) is
		do
		end

	item (i: INTEGER): G is
		do
		end

	upper: INTEGER is
		do
		end

	lower: INTEGER is
		do
		end

	count: INTEGER is
		do
			Result := upper - lower + 1
		end

end


