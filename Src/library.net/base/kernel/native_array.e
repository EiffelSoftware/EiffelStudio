external class
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

feature

	put (i: INTEGER; v:G) is
		do
		end

	item, infix "@" (i: INTEGER): G is
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
		end

end


