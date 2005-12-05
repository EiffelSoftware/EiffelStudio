indexing
	description: "Bit description"
	date: "$Date$"
	revision: "$Revision$"

class BITS_DESC

inherit
	ATTR_DESC
		rename
			Bits_level as level
		redefine
			is_bits, same_as
		end

feature -- Access

	value: INTEGER
			-- Bits value

	type_i: TYPE_I is
			-- Correspdonding instance of BIT type.
		do
			create {BIT_I} Result.make (value)
		end

	sk_value: INTEGER is
			-- Sk value
		do
			Result := Sk_bit + value
		end

feature -- Status report

	is_bits: BOOLEAN is True
			-- Is the attribute a bits one ?

feature -- Comparisons

	same_as (other: ATTR_DESC): BOOLEAN is
			-- Is `other' equal to Current ?
		local
			other_bits: BITS_DESC
		do
			if Precursor {ATTR_DESC} (other) then
				other_bits ?= other
				Result := (other_bits /= Void) and then (other_bits.value = value)
			end
		end

feature -- Settings

	set_value (i: INTEGER) is
			-- Assign `i' to `value'.
		require
			i_positive: i >= 0
		do
			value := i
		ensure
			value_set: value = i
		end

feature -- Code generation

	generate_code (buffer: GENERATION_BUFFER) is
			-- Generate type code for current attribute description in
			-- `buffer'.
		do
			buffer.put_string ("SK_BIT + ")
			buffer.put_integer (value)
		end

feature -- Debug

	trace is
		do
			io.error.put_string (attribute_name)
			io.error.put_string ("[BITS ")
			io.error.put_integer (value)
			io.error.put_string ("]")
		end

end
