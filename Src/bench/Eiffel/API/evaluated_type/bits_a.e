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
			is_bits, conform_to,
			associated_class, dump,
			same_as, ext_append_to,
			format, is_equivalent, process
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
			other_bits ?= other.conformance_type
			if other_bits /= Void then
				Result := other_bits.bit_count >= bit_count
			else
				Result := Precursor {BASIC_A} (other)
			end
		end

	type_i: BIT_I is
			-- C type
		do
			create Result.make (bit_count)
		end

	format (ctxt: FORMAT_CONTEXT) is
		do
			ctxt.put_string ("BIT ")
			ctxt.put_string (bit_count.out)
		end

invariant
	bit_count_positive: bit_count > 0

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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
