note
	description: "Class modifier used to modify EIS class entries."
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EIS_CLASS_MODIFIER

inherit
	ES_CLASS_TEXT_AST_MODIFIER
		redefine
			commit
		end

	ES_EIS_CODE_MODIFIER

create
	make

feature -- Modification

	new_empty_class_entry
			-- New empty EIS entry.
		require
			is_interface_usable: is_interface_usable
			is_prepared: is_prepared
			is_ast_available: is_ast_available
			is_modifiable: is_modifiable
		local
			l_entry: EIS_ENTRY
		do
			l_entry := entry_factory.create_default_entry (id_solution.id_of_class (context_class.config_class))
			write_class_entry (l_entry)
			last_create_entry := l_entry
		ensure
			is_dirty: is_dirty
			last_create_entry_not_void: last_create_entry /= Void
		end

	modify_class_entry (a_old_entry, a_new_entry: EIS_ENTRY)
			-- Modify `a_old_entry' to `a_new_entry' in the class.
		require
			is_interface_usable: is_interface_usable
			is_prepared: is_prepared
			is_ast_available: is_ast_available
			is_modifiable: is_modifiable
			a_old_entry_attached: attached a_old_entry
			a_new_entry_attached: attached a_new_entry
		local
			l_insertion_code: STRING_32
		do
			remove_class_entry (a_old_entry, False)
			if last_entry_removed then
				l_insertion_code := "%N%T"
				eis_output.process (a_new_entry)
				l_insertion_code.append (eis_output.last_output_code)
				insert_code (last_removed_position, l_insertion_code)
			end
		ensure
			is_dirty: is_dirty
		end

	write_class_entry (a_entry: EIS_ENTRY)
			-- Write `a_entry' into the class.
		require
			is_interface_usable: is_interface_usable
			is_prepared: is_prepared
			is_ast_available: is_ast_available
			is_modifiable: is_modifiable
			a_entry_attached: attached a_entry
		local
			l_ast: detachable CLASS_AS
			l_indexes: detachable INDEXING_CLAUSE_AS
			l_insertion_point: INTEGER
			l_p: TUPLE [start_position: INTEGER; end_position: INTEGER]
			l_insertion_code: STRING_32
			l_output: ES_EIS_ENTRY_OUTPUT
			l_entry: EIS_ENTRY
		do
			l_entry := a_entry
			l_ast := ast
				-- We only add new entry in top note clause.
			l_indexes := l_ast.top_indexes
			if not attached l_indexes then
				l_insertion_code := keyword_note_or_indexing + "%N%T"
				l_insertion_point := 1
			else
				l_insertion_code := "%N%T"
				l_p := ast_position (l_indexes)
				l_insertion_point := l_p.end_position + 1
			end
			create l_output
			l_output.process (l_entry)
			l_insertion_code.append (l_output.last_output_code)
			if not attached l_indexes then
				l_insertion_code.append ("%N%N")
			end
			insert_code (l_insertion_point, l_insertion_code)
		ensure
			is_dirty: is_dirty
		end

	remove_class_entry (a_entry: EIS_ENTRY; a_clean_empty_clause: BOOLEAN)
			-- Remove `a_entry' from the class if exists.
			-- `a_clean_empty_clause' to clean the leading empty clause if any.
		require
			is_interface_usable: is_interface_usable
			is_prepared: is_prepared
			is_ast_available: is_ast_available
			is_modifiable: is_modifiable
			a_entry_attached: attached a_entry
		local
			l_ast: detachable CLASS_AS
			l_indexes: detachable INDEXING_CLAUSE_AS
			l_entry: detachable EIS_ENTRY
			l_class_id: detachable STRING
			l_list: ARRAYED_LIST [INDEXING_CLAUSE_AS]
			l_found: BOOLEAN
		do
			last_entry_removed := False
			last_removed_position := 0
			l_class_id := id_solution.id_of_class (context_class.config_class)
			if l_class_id.is_equal (a_entry.target_id) then
				l_ast := ast
					-- We check entry in top and bottom note clause.
				create l_list.make (2)
				l_indexes := l_ast.top_indexes
				if attached l_indexes then
					l_list.extend (l_indexes)
				end
				l_indexes := l_ast.bottom_indexes
				if attached l_indexes then
					l_list.extend (l_indexes)
				end
				from
					l_list.start
				until
					l_list.after or l_found
				loop
					l_indexes := l_list.item_for_iteration
					from
						l_indexes.start
					until
						l_indexes.after or l_found
					loop
						if attached l_indexes.item as l_index then
							l_entry := eis_entry_from_index (l_index, l_class_id)
							if attached l_entry and then l_entry.same_entry (a_entry) then
								if l_indexes.count = 1 and then a_clean_empty_clause then
										-- Remove the entire note/indexing clause
									remove_ast_code (l_indexes, remove_white_space_trailing)
									last_removed_position := ast_position (l_indexes).start_position
								else
										-- Remove the note/index
									remove_ast_code (l_index, remove_white_space_heading)
									last_removed_position := ast_position (l_index).end_position
								end
								l_found := True
								last_entry_removed := True
							end
						end
						l_indexes.forth
					end
					l_list.forth
				end
			end
			set_is_dirty (True)
		ensure
			is_dirty: is_dirty
		end

	commit
			-- <Precursor>
		do
			Precursor {ES_CLASS_TEXT_AST_MODIFIER}
			if attached active_editors_for_class (context_class) as l_list then
				across
					l_list as l_c
				loop
					l_c.item.setup_eis_links
				end
			end
		end

feature -- Access

	last_create_entry: detachable EIS_ENTRY
			-- Last created eis entry.

feature {NONE} -- Implementation

	last_entry_removed: BOOLEAN

	last_removed_position: INTEGER

	keyword_note_or_indexing: STRING
			-- Get eis container structure keyword from parser.
			-- Either note or indexing
		local
			l_syntax: CONF_VALUE_CHOICE
		do
			l_syntax := context_class.options.syntax
			if l_syntax.index /= {CONF_OPTION}.syntax_index_obsolete then
				Result := {EIFFEL_KEYWORD_CONSTANTS}.note_keyword
			else
				Result := {EIFFEL_KEYWORD_CONSTANTS}.indexing_keyword
			end
		ensure
			result_attached: attached Result
			not_result_is_empty: not Result.is_empty
		end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software"
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
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
