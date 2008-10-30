indexing
	description: "[
		Class text modifier for modifying invariant contracts.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ES_INVARIANT_CONTRACT_TEXT_MODIFIER

inherit
	ES_CONTRACT_TEXT_MODIFIER [INVARIANT_AS]

create
	make

feature -- Access

	contract_ast: ?INVARIANT_AS
			-- <Precursor>
		do
				-- We use the `ast.internal_invariant' because `ast.invariant_part' is detached when there
				-- are not invariants.
			Result := ast.internal_invariant
		end

	contract_insertion_position: INTEGER
			-- <Precursor>
		local
			l_ast: like contract_ast
			l_indexing: INDEXING_CLAUSE_AS
		do
			l_ast := contract_ast
			if l_ast /= Void then
				Result := ast_position (l_ast).start_position
			else
					-- Try bottom indexing
				l_indexing := ast.bottom_indexes
				if l_indexing /= Void then
					Result := ast_position (l_indexing).start_position
				else
						-- Use end keyword
					check
						ast_end_keyword_attached: ast.end_keyword /= Void
					end
					Result := ast_position (ast.end_keyword).start_position
				end
			end
			Result := modified_data.adjusted_position (Result)
		end


feature {NONE} -- Access

	template_identifier: !STRING_32
			-- <Precursor>
		once
			create Result.make_from_string ({EIFFEL_KEYWORD_CONSTANTS}.invariant_keyword)
		end

feature {NONE} -- Element change

	set_template_values (a_table: !CODE_SYMBOL_TABLE)
			-- Sets the values use in rendering a template.
			--
			-- `a_table': The symbol table used to render a template
		do
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
