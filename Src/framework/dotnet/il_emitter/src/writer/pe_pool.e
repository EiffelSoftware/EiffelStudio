note
	description: "Summary description for {PE_POOL}."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_POOL

inherit
	DEBUG_OUTPUT

	REFACTORING_HELPER

create
	make

feature {NONE} -- Implementation

	make
		do
			size := 0
			max_size := 200
			create base.make_filled (0, 200)
		ensure
			size_zero: size = 0
			max_size: max_size = 200
			base_empty: base.capacity = 200
		end

feature -- Access

	size: NATURAL_32

	max_size: NATURAL_32

	base: SPECIAL [NATURAL_8]
			-- todo double check if we need to use
			-- SPECIAL instead of ARRAY

	confirm (new_size: NATURAL_32)
			-- C++ uses ensure
		do
			if size + new_size > max_size then
				if size + new_size < max_size * 2 then
					max_size := max_size * 2
				else
					max_size := (max_size + new_size) * 2
				end
				base := base.resized_area_with_default (0, max_size.to_integer_32)
			end
		ensure
			new_max_size: base.capacity.to_natural_64 = max_size
		end

feature -- Status report

	debug_output: STRING_32
		do
			Result := "size=" + size.out + " (0x" + size.to_hex_string + ")"
		end

feature -- Element Change

	increment_size
			-- Increment size by 1.
		do
			size := size + 1
		ensure
			size_incremented: old size + 1 = size
		end

	increment_size_by (a_value: NATURAL_32)
			-- Increment size by `a_value`.
		do
			size := size + a_value
		ensure
			size_incremented: old size + a_value = size
		end

	copy_data (a_index: INTEGER; a_data: ARRAY [NATURAL_8]; a_count: NATURAL_32)
		local
			l_index: INTEGER
			i,n: INTEGER
		do
				-- TODO double check if
				-- base.copy_data (other: SPECIAL [T], source_index, destination_index, n: INTEGER_32)
				-- could replace the following code.
			l_index := a_index
			from
				i := 1
				n := a_count.to_integer_32
				check no_truncation: n.to_natural_64 = a_count end
			until
				i > n
			loop
				if i <= a_data.count then
					base [l_index] := a_data [i]
					l_index := l_index + 1
				else
					base [l_index] := null_natural_8_code
					l_index := l_index + 1
				end
				i := i + 1
			end
			base [l_index] := null_natural_8_code
		end

	null_natural_8_code: NATURAL_8
		once
			Result := ('%U').code.to_natural_8
		end

end
