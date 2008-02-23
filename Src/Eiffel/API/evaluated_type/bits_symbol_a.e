indexing
	description: "Actual type for bits_symbol."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision $"

class BITS_SYMBOL_A

inherit
	BITS_A
		rename
			make as make_with_count
		redefine
			dump, ext_append_to,
			is_equivalent, is_full_named_type, process
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

create {COMPILER_EXPORTER}
	make

feature {NONE} -- Initialization

	make (f: FEATURE_I; c: like bit_count) is
		do
			make_with_count (c)
			feature_name_id := f.feature_name_id
			current_class_id := System.current_class.class_id
			rout_id := f.rout_id_set.first
		end

feature -- Visitor

	process (v: TYPE_A_VISITOR) is
			-- Process current element.
		do
			v.process_bits_symbol_a (Current)
		end

feature -- Properties

	feature_name_id: INTEGER

	feature_name: STRING is
			-- Anchor name
		do
			Result := names_heap.item (feature_name_id)
		end

	rout_id: INTEGER

	current_class_id: INTEGER
			-- Class declaring current

	is_full_named_type: BOOLEAN is False
			-- Current is not fully named

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := bit_count = other.bit_count and then
				rout_id = other.rout_id and then
				feature_name_id = other.feature_name_id and then
				current_class_id = other.current_class_id
		end

feature -- Setting

	set_rout_id (a_routine_id: like rout_id) is
			-- Set `rout_id' with `a_routine_id'.
		require
			a_routine_id_positive: a_routine_id > 0
		do
			rout_id := a_routine_id
		ensure
			rout_id_set: rout_id = a_routine_id
		end

feature -- Output

	dump: STRING is
			-- Dumped trace
		do
			create Result.make (9)
			Result.append ("BIT ")
			Result.append (names_heap.item (feature_name_id))
		end

	ext_append_to (st: TEXT_FORMATTER; c: CLASS_C) is
		do
			st.process_keyword_text ({SHARED_TEXT_ITEMS}.ti_Bit_class, Void)
			st.add_space
			st.add (names_heap.item (feature_name_id))
		end

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

end -- class BITS_SYMBOL_A
