note
	description: "Unevaluated BIT x type."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	UNEVALUATED_BITS_SYMBOL_A

inherit
	TYPE_A
		redefine
			associated_class, internal_is_valid_for_class, same_as, is_class_valid
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_string: like dump)
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

	process (v: TYPE_A_VISITOR)
			-- Process current element.
		do
			v.process_unevaluated_bits_symbol_a (Current)
		end

feature -- Access

	symbol_name_id: INTEGER
			-- Id of `symbol' in `names_heap'.

	symbol: STRING
			-- Anchor name
		do
			Result := names_heap.item (symbol_name_id)
		end

	hash_code: INTEGER
		do
			Result := {SHARED_HASH_CODE}.bit_code
		end

	associated_class: CLASS_C
			-- Associated class
		do
			if attached System.bit_class as c then
				Result := c.compiled_class
			end
		end

feature -- Status Report

	is_class_valid: BOOLEAN = False

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object ?
		do
			Result := symbol_name_id = other.symbol_name_id
		end

feature -- Output

	ext_append_to (a_text_formatter: TEXT_FORMATTER;  c: CLASS_C)
			-- Append Current type to `st'.
		do
			a_text_formatter.process_keyword_text ({SHARED_TEXT_ITEMS}.ti_Bit_class, Void)
			a_text_formatter.add_space
			a_text_formatter.add_string (symbol)
		end

	dump: STRING
		do
			create Result.make (9)
			Result.append ("BIT ")
			Result.append (symbol)
		end

feature {TYPE_A} -- Helpers

	internal_is_valid_for_class (a_class: CLASS_C): BOOLEAN
			-- An unevaluated type is never valid.
		do
		end

feature {NONE} -- Implementation

	same_as (other: TYPE_A): BOOLEAN
			-- Is the current type the same as `other' ?
		local
			l_other: like Current
		do
			l_other ?= other
			Result := l_other /= Void and then symbol_name_id = l_other.symbol_name_id
		end

feature {NONE} -- Not applicable

	conform_to (a_context_class: CLASS_C; other: TYPE_A): BOOLEAN
		do
		end

	create_info: CREATE_INFO
		do
		end

invariant
	non_void_symbol: symbol /= Void

note
	copyright:	"Copyright (c) 1984-2011, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class UNEVALUATED_LIKE_TYPE
