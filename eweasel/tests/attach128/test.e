class TEST

create
	make,
	make_with

feature {NONE} -- Creation

	make
			-- Run test.
		do
				-- Initialize Current.
			item := Current
				-- Pass Current to update it with a new reference.
			;(create {TEST}.make_with (Current)).do_nothing
		end

	make_with (other: TEST)
		do
				-- Call an assigner command passing an incompletely initialized Current.
			other.item := Current
				-- Complete initialization.
			item := Current
		end

feature -- Access

	item: TEST assign put
			-- An attribute to be initialized at creation.

	put (value: TEST)
			-- Set `item` to `value`.
		do
			item := value
		end

end
