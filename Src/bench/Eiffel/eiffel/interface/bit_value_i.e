indexing
	description: "Representation of a manifest BIT value"
	date: "$Date$"
	revision: "$Revision$"

class BIT_VALUE_I 

inherit
	VALUE_I
		redefine
			is_bit,
			set_real_type
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to current object ?
		do
			Result := bit_count = other.bit_count and then
				bit_value.is_equal (other.bit_value)
		end

feature -- Access

	bit_value: STRING
			-- Integer constant value

	bit_count: INTEGER
			-- real number of bits

feature -- Status Report

	is_bit: BOOLEAN is True
			-- Is current constant a bit one?

	valid_type (t: TYPE_A): BOOLEAN is
			-- Is current value compatible with `t' ?
		local
			class_type: BITS_A
		do
			class_type ?= t
			check
				class_type_not_void: class_type /= Void
			end
			Result := class_type /= Void and then bit_value.count <= class_type.bit_count 
		end

feature -- Settings

	set_bit_value (v: STRING) is
			-- Assign `v' to `bit_value'.
		require
			v_not_void: v /= Void
		do
			bit_value := v
		ensure
			bit_value_set: bit_value = v
		end

	set_real_type (t: TYPE_A) is
			-- Set real number of bits.
		local
			class_type: BITS_A
		do
			class_type ?= t
			if class_type /= Void then
				bit_count := class_type.bit_count
			end
		end

feature -- Code generation

	generate (buffer: GENERATION_BUFFER) is
			-- Generate value in `buffer'.
		do
			buffer.putstring ("RTMB(%"")
			buffer.escape_string (buffer,bit_value)
			buffer.putchar ('"')
			buffer.putstring (", ")
			buffer.putint (bit_count)
			buffer.putchar (')')
		end

	generate_il is
			-- Generate IL code for BIT constant value.
		do
			check
				not_implemented: False
			end
		end

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a BIT constant value.
		do
			ba.append (Bc_bit)
			ba.append_integer (bit_count)
			ba.append_bit (bit_value)
		end

	dump: STRING is
		do
			Result := bit_value			
		end

end
