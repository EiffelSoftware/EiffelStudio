indexing
	description: "[
		A AST-augmented Eiffel code class text modifier.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ES_CLASS_TEXT_AST_MODIFIER

inherit
	ES_CLASS_TEXT_MODIFIER
		redefine
			modified_data,
			create_modified_data
		end

feature -- Access

	ast: ?CLASS_AS
			-- Resulting class AST node.
			-- Note: This is the original AST node not the modified one. To access the modified one
			--       the changes must be commited and the ast re-prepared.
		require
			is_prepared: is_prepared
			is_ast_available: is_ast_available
		do
			Result := modified_data.ast
		end

	ast_match_list: ?LEAF_AS_LIST
			-- Resulting class AST node match list (for roundtrip)
			-- Note: This is the original AST match list not the modified one. To access the modified one
			--       the changes must be commited and the ast re-prepared.
		require
			is_prepared: is_prepared
			is_ast_available: is_ast_available
		do
			Result := modified_data.ast_match_list
		end

feature {NONE} -- Access

	modified_data: !ES_CLASS_TEXT_AST_MODIFIER_DATA
			-- <Precursor>

feature -- Status report

	is_ast_available: BOOLEAN
			-- Indicates if the AST information is available.
		require
			is_prepared: is_prepared
		do
			Result := modified_data.is_ast_available
		ensure
			modified_data_is_ast_available: Result implies modified_data.is_ast_available
		end

feature -- Query

	ast_position (a_ast: AST_EIFFEL): TUPLE [start_position: INTEGER; end_position: INTEGER]
			-- Retrieve an AST node's position.
			-- Note: The result is unadjusted! To account for ajustement, pass through `modified_data.adjusted_position'.
			--
			-- `a_ast': An AST node to retrieve a position for.
			-- `Result': Original start and end positions for the supplied AST node.
		require
			is_prepared: is_prepared
			is_ast_available: is_ast_available
			a_ast_attached: a_ast /= Void
		local
			l_data: like modified_data
			l_first_leaf: LEAF_AS
			l_last_leaf: LEAF_AS
		do
			l_data := modified_data
			l_first_leaf := a_ast.first_token (l_data.ast_match_list)
			l_last_leaf := a_ast.last_token (l_data.ast_match_list)
			if l_first_leaf /= Void and then l_last_leaf /= Void then
				Result := [l_first_leaf.start_position, l_last_leaf.end_position]
			else
					-- Invalid parser!
				check False end
				Result := [0, 0]
			end
		ensure
			result_attached: Result /= Void
			result_start_position_small_enough: Result.start_position <= Result.end_position
		end

feature -- Basic operations

	remove_ast_code (a_ast: AST_EIFFEL; a_remove_ws: BOOLEAN)
			-- Removes an AST node and sets `insertion_position' to the beginning of the removed AST position.
			--
			-- `a_ast': The AST node to remove from the code.
			-- `a_remove_ws': True to intelligently remove all trailing whitespace after the AST node.
		require
			is_prepared: is_prepared
			is_ast_available: is_ast_available
			a_ast_attached: a_ast /= Void
		local
			l_position: like ast_position
			l_text: like original_text
			l_count, i: INTEGER
			l_nl_switched: BOOLEAN
		do
			l_text := original_text
			l_position := ast_position (a_ast)

			if a_remove_ws then
					-- Locate first non whitespace character (on the first line only)
				from
					i := l_position.end_position + 1
					l_count := l_text.count
				until
					i > l_count or not l_text.item (i).is_space or (l_nl_switched and l_text.item (i) = '%N')
				loop
					if not l_nl_switched then
							-- Looking for the second new line to ensure the next AST block is brought up
						l_nl_switched := l_text.item (i) = '%N'
					end
					i := i + 1
				end

				if i <= l_count then
					if l_text.item (i) /= '%N' then
							-- Remove the last in
						i := i - 1
					end
					l_position.end_position := i
				end
			end

				-- Perform removal.
			remove_code (l_position.start_position, l_position.end_position)
		end

feature {NONE} -- Factory

	create_modified_data: like modified_data
			-- <Precursor>
		local
			l_class: like context_class
			l_editor: like active_editor_for_class
			l_text: !STRING
		do
			l_class := context_class
			l_editor := active_editor_for_class (l_class)
			if l_editor = Void then
					-- There's no open editor, use the class text from disk instead.
				l_text := original_text
			else
				l_text ?= l_editor.text
			end
			create Result.make (l_class, l_text)
		end

;indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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

end
