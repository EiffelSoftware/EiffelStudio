indexing
	description: "Actual type for bits."
	date: "$Date$"
	revision: "$Revision$"

class BITS_A

inherit
	BASIC_A
		rename
			make as cl_make
		redefine
			is_bits, conform_to, 
			associated_class, dump,
			same_as, ext_append_to,
			format, is_equivalent
		end

create
	make

feature {NONE} -- Initialization

	make (c: like bit_count) is
			-- Initialize new instance of BITS_A with `c' bits.
		require
			c_positive: c > 0
		do
			bit_count := c
			cl_make (associated_class.class_id)
		ensure
			bit_count_set: bit_count = c
		end

feature -- Property

	is_bits: BOOLEAN is True
			-- Is the current actual type a bits type?

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object?
		do
			Result := bit_count = other.bit_count
		end

feature -- Access

	same_as (other: TYPE_A): BOOLEAN is
			-- Is `other' the same as Current?
		local
			other_bits: BITS_A
		do
			other_bits ?= other
			Result := other_bits /= Void and then other_bits.bit_count = bit_count
		end

	associated_class: CLASS_C is
			-- Associated class
		once
			Result := System.bit_class.compiled_class
		end

	bit_count: INTEGER
			-- Bit count

feature -- Output

	dump: STRING is
			-- Dumped trace
		do
			create Result.make (10)
			Result.append ("BIT ")
			Result.append_integer (bit_count)
		end

	ext_append_to (st: STRUCTURED_TEXT; f: E_FEATURE) is
		do
			st.add (ti_bit_class)
			st.add_space
			st.add_int (bit_count)
		end

feature {COMPILER_EXPORTER}

	conform_to (other: TYPE_A): BOOLEAN is
			-- Does Current conform to `other'?
		local
			other_bits: BITS_A
		do
			other_bits ?= other.actual_type
			if other_bits /= Void then
				Result := other_bits.bit_count >= bit_count
			else
				Result := Precursor {BASIC_A} (other)
			end
		end

	type_i: BIT_I is
			-- C type
		do
			create Result
			Result.set_size (bit_count)
		end

	format (ctxt: FORMAT_CONTEXT) is
		do
			ctxt.put_string ("BIT ")
			ctxt.put_string (bit_count.out)
		end

invariant
	bit_count_positive: bit_count > 0

end -- class BITS_A
