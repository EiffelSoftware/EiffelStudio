indexing
	description: "Actual type for bits."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class BITS_A

inherit
	BASIC_A
		rename
			make as cl_make
		redefine
			is_bit, is_class_valid, internal_is_valid_for_class, conform_to,
			associated_class, dump,
			same_as, ext_append_to,
			is_equivalent, process,
			generate_cid, generate_cid_array, generate_cid_init,
			make_gen_type_byte_code, associated_class_type, has_associated_class_type,
			metamorphose, is_external, reference_type
		end

create
	make

feature {NONE} -- Initialization

	make (c: like bit_count) is
			-- Initialize new instance of BITS_A with `c' bits.
		do
			bit_count := c
			cl_make (associated_class.class_id)
				-- Set expanded mark explicitly because
				-- associated class BIT_REF is reference.
			set_expanded_mark
		ensure
			bit_count_set: bit_count = c
		end

feature -- Visitor

	process (v: TYPE_A_VISITOR) is
			-- Process current element.
		do
			v.process_bits_a (Current)
		end

feature -- Status Report

	is_bit: BOOLEAN is True
			-- Is the current actual type a bits type?

	is_class_valid: BOOLEAN is
		do
			Result := bit_count > 0
		end

	is_external: BOOLEAN is False
			-- <Precursor>

	has_associated_class_type (a_context_type: TYPE_A): BOOLEAN
		do
			Result := not associated_class.types.is_empty
		end

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

	associated_class_type (a_context_type: TYPE_A): CLASS_TYPE is
			-- Associated class type
		do
				-- Return class type for BIT_REF.
			Result := associated_class.types.first
		end

	bit_count: INTEGER
			-- Bit count

feature -- Settings

	set_bit_count (a_count: INTEGER) is
			-- Set `bit_count' with `a_count'.
		require
			a_count_positive: a_count > 0
		do
			bit_count := a_count
		ensure
			bit_count_set: bit_count = a_count
		end

feature -- Generic conformance

	generate_cid (buffer : GENERATION_BUFFER; final_mode, use_info : BOOLEAN; a_context_type: TYPE_A) is
		do
			buffer.put_integer (generated_id (final_mode, a_context_type))
			buffer.put_character (',')
			buffer.put_integer (bit_count)
			buffer.put_character (',')
		end

	generate_cid_array (buffer: GENERATION_BUFFER; final_mode, use_info: BOOLEAN; idx_cnt: COUNTER; a_context_type: TYPE_A) is
		local
			dummy: INTEGER
		do
			generate_cid (buffer, final_mode, use_info, a_context_type)
				-- Increment counter twice.
			dummy := idx_cnt.next
			dummy := idx_cnt.next
		end

	generate_cid_init (buffer: GENERATION_BUFFER; final_mode, use_info: BOOLEAN; idx_cnt: COUNTER; a_level: NATURAL) is
		local
			dummy: INTEGER
		do
				-- Increment counter twice.
			dummy := idx_cnt.next
			dummy := idx_cnt.next
		end

	make_gen_type_byte_code (ba : BYTE_ARRAY; use_info : BOOLEAN; a_context_type: TYPE_A) is
		do
			Precursor (ba, use_info, a_context_type)
				-- FIXME: Manu 08/06/2003: There is no limitation about the size
				-- of a BIT to 2^15, therefore when `size' is greater than 2^15
				-- we have a problem!!!!. It does not only apply to current routine
				-- but to all the generic conformance stuff.
			ba.append_short_integer (bit_count)
		end

feature -- C code generation

	metamorphose (reg, value: REGISTRABLE; buffer: GENERATION_BUFFER) is
			-- Generate the metamorphism from simple type to reference and
			-- put result in register `reg'. The value of the basic type is
			-- held in `value'.
		do
			reg.print_register
			buffer.put_string (" = ")
			value.print_register
		end

feature -- Output

	dump: STRING is
			-- Dumped trace
		do
			create Result.make (10)
			Result.append ("BIT ")
			Result.append_integer (bit_count)
		end

	ext_append_to (st: TEXT_FORMATTER; c: CLASS_C) is
		do
			st.process_keyword_text ({SHARED_TEXT_ITEMS}.ti_bit_class, Void)
			st.add_space
			st.add_int (bit_count)
		end

feature {TYPE_A} -- Helpers

	internal_is_valid_for_class (a_class: CLASS_C): BOOLEAN is
			-- Is current type valid?
		do
			Result := bit_count > 0
		end

feature {COMPILER_EXPORTER}

	reference_type: BITS_A is
			-- We can use Current as `reference type' since they share the same code.
		do
			Result := Current
		end

	conform_to (other: TYPE_A): BOOLEAN is
			-- Does Current conform to `other'?
		local
			other_bits: BITS_A
		do
			other_bits ?= other.conformance_type
			if other_bits /= Void then
				Result := other_bits.bit_count >= bit_count
			else
				Result := Precursor {BASIC_A} (other)
			end
		end

	c_type: BIT_I is
			-- C type
		do
			create Result.make (bit_count)
		end

invariant
	bit_count_positive: is_valid implies bit_count > 0

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class BITS_A
