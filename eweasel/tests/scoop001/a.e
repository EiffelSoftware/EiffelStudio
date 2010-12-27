class
	A

create
	make

feature {NONE} -- Creation

	make (v: like item)
			-- Initialize object with `v'.
		do
			item := v
		ensure
			item = v
		end

feature -- Access

	item: INTEGER
			-- Current value

	next: INTEGER
			-- Next value
		do
			Result := item + 1
		end

feature -- Modification

	advance
			-- Switch to the next value.
		do
			item := next
		ensure
			item = old next
		end

end