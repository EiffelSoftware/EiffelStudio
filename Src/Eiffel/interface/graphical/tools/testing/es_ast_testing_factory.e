indexing
	description: "[
							Ast parser factory for testing tool
							This factory only analyzes indexing related codes.
																												]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_AST_TESTING_FACTORY

inherit
	AST_NULL_FACTORY
		redefine
				new_index_as,
				new_eiffel_list_atomic_as,
				new_filled_id_as,
				new_filled_id_as_with_existing_stub,
				new_filled_bit_id_as,
				new_indexing_clause_as,
				new_class_as
		end

feature -- Query

	top_indexing: INDEXING_CLAUSE_AS
				-- Top indexing clause

feature {NONE} -- Visitor

	new_class_as (n: ID_AS; ext_name: STRING_AS;
			is_d, is_e, is_s, is_fc, is_ex, is_par: BOOLEAN;
			top_ind, bottom_ind: INDEXING_CLAUSE_AS;
			g: EIFFEL_LIST [FORMAL_DEC_AS];
			cp: PARENT_LIST_AS;
			ncp: PARENT_LIST_AS
			c: EIFFEL_LIST [CREATE_AS];
			co: CONVERT_FEAT_LIST_AS;
			f: EIFFEL_LIST [FEATURE_CLAUSE_AS];
			inv: INVARIANT_AS;
			s: SUPPLIERS_AS;
			o: STRING_AS;
			ed: KEYWORD_AS): CLASS_AS
		is
			-- <Precursor>
		do
			top_indexing := top_ind
		end

	new_indexing_clause_as (n: INTEGER): INDEXING_CLAUSE_AS is
			-- <Precursor>
		do
			create Result.make (n)
		end

	new_index_as (t: ID_AS; i: EIFFEL_LIST [ATOMIC_AS]; c_as: SYMBOL_AS): INDEX_AS is
			-- Create a new INDEX AST node.
		do
			if i /= Void then
				create Result.initialize (t, i, c_as)
			end
		end

	new_eiffel_list_atomic_as (n: INTEGER): EIFFEL_LIST [ATOMIC_AS] is
			-- <Precursor>
		do
			create Result.make (n)
		end

	new_filled_id_as (a_scn: EIFFEL_SCANNER_SKELETON): ID_AS is
			-- <Precursor>
		local
			l_cnt: INTEGER
			l_str: STRING
		do
			l_cnt := a_scn.text_count
			create l_str.make (l_cnt)
			a_scn.append_text_to_string (l_str)
			create Result.initialize (l_str)
			Result.set_position (a_scn.line, a_scn.column, a_scn.position, l_cnt)
		end

	new_filled_id_as_with_existing_stub (a_scn: EIFFEL_SCANNER_SKELETON; a_index: INTEGER): ID_AS is
			-- <Precursor>
		do
			Result := new_filled_id_as (a_scn)
		end

	new_filled_bit_id_as (a_scn: EIFFEL_SCANNER): ID_AS is
			-- <Precursor>
		local
			l_cnt: INTEGER
			l_str: STRING
		do
			l_cnt := a_scn.text_count - 1
			create l_str.make (l_cnt)
			a_scn.append_text_substring_to_string (1, l_cnt, l_str)
			create Result.initialize (l_str)
			Result.set_position (a_scn.line, a_scn.column, a_scn.position, l_cnt)
		end

indexing
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
