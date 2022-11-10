note
	description: "Summary description for {PE_POOL}."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_POOL

inherit

	REFACTORING_HELPER

create
	make

feature {NONE} -- Implementation

	make
		do
			size := 0
			max_size := 200
			create base.make_filled (0, 1, 200)
		ensure
			size_zero: size = 0
			max_size: max_size = 200
			base_empty: base.capacity = 200
		end

feature -- Access

	size: NATURAL

	max_size: NATURAL

	base: ARRAY [NATURAL_8]

	confirm (new_size: NATURAL)
			-- C++ uses ensure
		require
			valid_size: size + new_size <= max_size
		do
			if size + new_size > max_size then
				if size + new_size < max_size * 2 then
					max_size := max_size * 2
				else
					max_size := (max_size + new_size) * 2
				end
				base.conservative_resize_with_default (0, 1, max_size.to_integer_32)
			end
		ensure
			new_max_size: base.capacity.to_natural_32 = max_size
		end

feature -- Element Change

	increment_size
			-- Increment size by 1.
		do
			size := size + 1
		ensure
			size_incremented: old size + 1 = size
		end

	increment_size_by (a_value: NATURAL)
			-- Increment size by `a_value`.
		do
			size := size + a_value
		ensure
			size_incremented: old size + a_value = size
		end

end
