indexing
	description: "Class modifier used to modify EIS feature entries."
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EIS_FEATURE_MODIFIER

inherit
	ES_FEATURE_TEXT_AST_MODIFIER

	ES_EIS_CODE_MODIFIER

create
	make

feature -- Modification: Feature

	modify_feature_entry (a_old_entry, a_new_entry: !EIS_ENTRY) is
			-- Modify `a_old_entry' to `a_new_entry' in the feature.
		require
			is_interface_usable: is_interface_usable
			is_prepared: is_prepared
			is_ast_available: is_ast_available
			is_modifiable: is_modifiable
		local
			l_insertion_code: STRING_32
			l_output: ES_EIS_ENTRY_OUTPUT
		do
			remove_feature_entry (a_old_entry, False)
			if last_entry_removed then
				l_insertion_code := "%N%T%T%T"
				create l_output
				l_output.process (a_new_entry)
				l_insertion_code.append (l_output.last_output_code)
				insert_code (last_removed_position, l_insertion_code)
			end
		ensure
			is_dirty: is_dirty
		end

	write_feature_entry (a_entry: !EIS_ENTRY) is
			-- Write `a_entry' into the class.
		require
			is_interface_usable: is_interface_usable
			is_prepared: is_prepared
			is_ast_available: is_ast_available
			is_modifiable: is_modifiable
		local
			l_ast: ?FEATURE_AS
			l_indexes: ?INDEXING_CLAUSE_AS
			l_insertion_point: INTEGER
			l_p: TUPLE [start_position: INTEGER; end_position: INTEGER]
			l_insertion_code: STRING_32
			l_output: ES_EIS_ENTRY_OUTPUT
			l_entry: !EIS_ENTRY
			l_routine: ?ROUTINE_AS
		do
			l_entry := a_entry
			l_ast := ast_feature
			l_indexes := l_ast.indexes
			if l_indexes = Void then
				l_insertion_code := keyword_note_or_indexing + "%N%T%T%T"
				l_routine ?= l_ast.body.content
				if l_routine /= Void then
					if l_routine.precondition /= Void then
						l_insertion_point := ast_position (l_routine.precondition).start_position
					elseif l_routine.internal_locals /= Void then
						l_insertion_point := ast_position (l_routine.internal_locals).start_position
					else
						l_insertion_point := ast_position (l_routine.routine_body).start_position
					end
				end
			else
				l_insertion_code := "%N%T%T%T"
				l_p := ast_position (l_indexes)
				l_insertion_point := l_p.end_position + 1
			end
			create l_output
			l_output.process (l_entry)
			l_insertion_code.append (l_output.last_output_code)
			if l_indexes = Void then
				l_insertion_code.append ("%N%T%T")
			end
			insert_code (l_insertion_point, l_insertion_code)
		ensure
			is_dirty: is_dirty
		end

	remove_feature_entry (a_entry: !EIS_ENTRY; a_clean_empty_clause: BOOLEAN) is
			-- Remove `a_entry' from the class if exists.
			-- `a_clean_empty_clause' to clean the leading empty clause if any.
		require
			is_interface_usable: is_interface_usable
			is_prepared: is_prepared
			is_ast_available: is_ast_available
			is_modifiable: is_modifiable
		local
			l_ast: ?FEATURE_AS
			l_indexes: ?INDEXING_CLAUSE_AS
			l_entry: ?EIS_ENTRY
			l_feature_id: ?STRING
			l_found: BOOLEAN
		do
			last_entry_removed := False
			last_removed_position := 0
			l_feature_id := id_solution.id_of_feature (context_feature)
			if l_feature_id.is_equal (a_entry.id) then
				l_ast := ast_feature
				l_indexes := l_ast.indexes
				from
					l_indexes.start
				until
					l_indexes.after or l_found
				loop
					if {lt_index: INDEX_AS}l_indexes.item then
						l_entry := eis_entry_from_index (lt_index, l_feature_id)
						if l_entry /= Void and then l_entry.same_entry (a_entry) then
							if l_indexes.count = 1 and then a_clean_empty_clause then
									-- Remove the entire note/indexing clause
								remove_ast_code (l_indexes, remove_white_space_trailing)
								last_removed_position := ast_position (l_indexes).start_position - 1
							else
									-- Remove the note/index
								remove_ast_code (lt_index, remove_white_space_heading)
								last_removed_position := ast_position (lt_index).end_position - 1
							end
							l_found := True
							last_entry_removed := True
						end
					end
					l_indexes.forth
				end
			end
			set_is_dirty (True)
		ensure
			is_dirty: is_dirty
		end

feature {NONE} -- Implementation

	last_entry_removed: BOOLEAN

	last_removed_position: INTEGER

	keyword_note_or_indexing: !STRING is
			-- Get eis container structure keyword from parser.
			-- Either note or indexing
		local
			l_syntax_level: CONF_VALUE_CHOICE
		do
			l_syntax_level := context_class.options.syntax_level
			if l_syntax_level.item /= {CONF_OPTION}.syntax_level_obsolete  then
				Result := {EIFFEL_KEYWORD_CONSTANTS}.note_keyword
			else
				Result := {EIFFEL_KEYWORD_CONSTANTS}.indexing_keyword
			end
		end

indexing
	copyright: "Copyright (c) 1984-2007, Eiffel Software"
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
