indexing
	description: "[
		Feature text modifier for modifying contract postconditions.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ES_POSTCONDITION_CONTRACT_TEXT_MODIFIER

inherit
	ES_FEATURE_CONTRACT_TEXT_MODIFIER [ENSURE_AS]

create
	make

feature {NONE} -- Access

	template_identifier: !STRING_32
			-- <Precursor>
		once
			create Result.make_from_string ("ensure")
		end

feature {NONE} -- Element change

	set_template_values (a_table: !CODE_SYMBOL_TABLE)
			-- Sets the values use in rendering a template.
			--
			-- `a_table': The symbol table used to render a template
		local
			l_parents: ARRAYED_LIST [CLASS_C]
			l_value: !CODE_SYMBOL_VALUE
			l_str_value: !STRING_32
		do
			l_parents := context_feature.precursors
			if l_parents = Void or else l_parents.is_empty then
				create l_value.make_empty
			else
				create l_str_value.make (then_id_name.count + 1)
				l_str_value.append_character (' ')
				l_str_value.append (then_id_name)
				create l_value.make (l_str_value)
			end
			a_table.force (l_value, then_id_name)
		end

feature {NONE} -- Query

	contract_insertion_position: INTEGER
			-- <Precursor>
		local
			l_ast: like contract_ast
			l_routine: ?ROUTINE_AS
			l_locals: ?LOCAL_DEC_LIST_AS
		do
			l_ast := contract_ast
			if l_ast /= Void then
				Result := ast_position (l_ast).start_position
			else
				l_routine ?= ast_feature.body.content
				if l_routine /= Void then
					l_locals := l_routine.internal_locals
					if l_locals = Void then
							-- No locals, use routine body
						Result := ast_position (l_routine.routine_body).start_position
					else
						Result := ast_position (l_locals).start_position
					end
				end
			end
			Result := modified_data.adjusted_position (Result)
		end

	contract_ast: ?ENSURE_AS
			-- <Precursor>
		local
			l_routine: ?ROUTINE_AS
		do
			l_routine ?= ast_feature.body.content
			if l_routine /= Void then
				Result := l_routine.postcondition
			end
		end

feature {NONE} -- Constants

	then_id_name: !STRING = "then"
			-- Else identifier name

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
