class
	A

inherit
	EXECUTION_ENVIRONMENT
		rename
			item as exec_item
		end

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
			-- Current value.

	next: INTEGER
			-- Next value.
		do
			Result := item + 1
		end

	real_value: REAL_64
			-- `item' as {REAL_64}.
		do
			Result := item
		end

feature -- Modification

	advance
			-- Switch to the next value.
		do
			item := next
		ensure
			item = old next
		end

	copy_from (other: separate A)
			-- Copy from `other' after waiting for a while.
			-- Used to check for deadlocks.
		do
				-- Sleep for 1 second.
			sleep (1_000_000_000)
				-- Access `other' with waiting.
			item := other.item
		end

end