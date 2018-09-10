expanded class
	VALUE

inherit
	MEMORY
		redefine
			copy,
			default_create
		end

feature {NONE} -- Creation

	default_create
			-- Initialize with a default value.
		do
			create item
		end

feature {VALUE} -- Access

	item: TEST
			-- An object that is moved during GC.

feature -- Duplication

	copy (other: VALUE)
			-- <Precursor>
		do
				-- Trigger GC to move `other.item`.
			full_collect
				-- Use `other.item`.
			other.item.f
				-- Make sure the objects are equal.
			item := other.item
		end

end
