indexing
	description: "Actual type for bits."
	date: "$Date$"
	revision: "$Revision $"

class BITS_A

inherit
	BASIC_A
		redefine
			is_bits, internal_conform_to, associated_class, dump,
			heaviest, same_as, append_to,
			check_conformance, format, is_equivalent
		end

feature -- Property

	is_bits: BOOLEAN is True
			-- Is the current actual type a bits type ?

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := bit_count = other.bit_count
		end

feature -- Access

	same_as (other: TYPE_A): BOOLEAN is
			-- Is `other' the same as Current ?
		local
			other_bits: BITS_A
		do
			other_bits ?= other
			Result :=	other_bits /= Void
						and then
						other_bits.bit_count = bit_count
		end

	associated_class: CLASS_C is
			-- Associated class
		once
			Result := System.bit_class.compiled_class
		end

	bit_count: INTEGER
			-- Bit count

feature -- Setting

	set_bit_count (c: like bit_count) is
			-- Assign `c' to `set_bit_count'.
		do
			bit_count := c
		end

feature -- Output

	dump: STRING is
			-- Dumped trace
		do
			!!Result.make (10)
			Result.append ("BIT ")
			Result.append_integer (bit_count)
		end

	append_to (st: STRUCTURED_TEXT) is
		do
			st.add_string ("BIT ")
			st.add_int (bit_count)
		end

feature {COMPILER_EXPORTER}

	check_conformance (target_name: STRING; target_type: TYPE_A) is
			-- Check if Current conforms to `other'.
			-- If not, insert error into Error handler
			-- which uses `context' for initialisation of the
			-- error.
		local
			vncb: VNCB
		do
			if not conform_to (target_type) then
				!!vncb
				context.init_error (vncb)
				vncb.set_target_name (target_name)
				vncb.set_source_type (Current)
				vncb.set_target_type (target_type)
				Error_handler.insert_error (vncb)
			end
		end

	internal_conform_to (other: TYPE_A; in_generics: BOOLEAN): BOOLEAN is
			-- Does Current conform to `other' ?
		local
			other_bits: BITS_A
		do
			other_bits ?= other.actual_type
			if other_bits /= Void then
				if in_generics then
					Result := other_bits.bit_count = bit_count
				else
					Result := other_bits.bit_count >= bit_count
				end
			else
				Result := {BASIC_A} Precursor (other, False)
			end
		end

	heaviest (type: TYPE_A): TYPE_A is
			-- Heaviest numeric type for balancing rule
		require else
			good_argument: type /= Void
			consistency: is_bits and then type.is_bits
		local
			other: BITS_A
		do
			other ?= type
			if other.bit_count > bit_count then
				Result := type
			else
				Result := Current
			end
		end

	type_i: BIT_I is
			-- C type
		do
			!!Result
			Result.set_size (bit_count)
		end

	format (ctxt: FORMAT_CONTEXT) is
		do
			ctxt.put_string ("BIT ")
			ctxt.put_string (bit_count.out)
		end

end -- class BITS_A
