note
	description: "Minimal array interface (non-generic)."
	status: skip

class F_I_ARRAY

create
	make

feature {NONE} -- Initialization

	make (n: INTEGER)
			-- Create an array of size `n'.
		note
			status: creator
			skip: True
		require
			size_non_negative: n >= 0
		do
		ensure
			count_set: count = n
		end

feature -- Access		

	count: INTEGER
			-- Size of the array.

	item alias "[]" (i: INTEGER): INTEGER
			-- Element at position `i'.
		note
			skip: True
		require
			closed: closed
			in_bounds: 1 <= i and i <= count
		do
		end

feature -- Update	

	put (v, i: INTEGER)
			-- Replace element at position `i' with `v'.
		note
			skip: True
		require
			in_bounds: 1 <= i and i <= count
		do
		ensure
			new_item: item (i) = v
			same_size: count = old count
		end

invariant
	count_non_negative: count >= 0

end
