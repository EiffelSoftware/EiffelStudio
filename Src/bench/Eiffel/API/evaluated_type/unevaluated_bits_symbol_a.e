indexing
	description: "Unevaluated BIT x type."
	date: "$Date$"
	revision: "$Revision$"

class
	UNEVALUATED_BITS_SYMBOL_A

inherit
	TYPE_A
		redefine
			associated_class, is_valid, same_as
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_string: like dump) is
			-- Initialize `symbol' to `a_string'
		require
			non_void_string: a_string /= Void
		do
			names_heap.put (a_string)
			symbol_name_id := names_heap.found_item
		ensure
			set: symbol.is_equal (a_string)
		end

feature -- Visitor

	process (v: TYPE_A_VISITOR) is
			-- Process current element.
		do
			v.process_unevaluated_bits_symbol_a (Current)
		end

feature -- Properties

	symbol_name_id: INTEGER
			-- Id of `symbol' in `names_heap'.

	symbol: STRING is
			-- Anchor name
		do
			Result := names_heap.item (symbol_name_id)
		end

	is_valid: BOOLEAN is False
			-- An unevaluated type is never valid.

feature -- Access

	associated_class: CLASS_C is
			-- Associated class
		once
			Result := System.bit_class.compiled_class
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := symbol_name_id = other.symbol_name_id
		end

feature -- Output

	ext_append_to (a_text_formatter: TEXT_FORMATTER; f: E_FEATURE) is
			-- Append Current type to `st'.
		do
			a_text_formatter.add (ti_Bit_class)
			a_text_formatter.add_space
			a_text_formatter.add_string (symbol)
		end

	dump: STRING is
		do
			create Result.make (9)
			Result.append ("BIT ")
			Result.append (symbol)
		end

feature {NONE} -- Implementation

	same_as (other: TYPE_A): BOOLEAN is
			-- Is the current type the same as `other' ?
		local
			l_other: like Current
		do
			l_other ?= other
			Result := l_other /= Void and then symbol_name_id = l_other.symbol_name_id
		end

feature {NONE} -- Not applicable

	conform_to (other: TYPE_A): BOOLEAN is
		do
		end

	type_i: TYPE_I is
		do
		end

	create_info: CREATE_INFO is
		do
		end

invariant
	non_void_symbol: symbol /= Void

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

end -- class UNEVALUATED_LIKE_TYPE
