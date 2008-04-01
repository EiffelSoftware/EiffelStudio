indexing
	description: "[

	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ES_INVARIANT_CONTRACT_EDITOR_CONTEXT

inherit
	ES_CLASS_CONTRACT_EDITOR_CONTEXT

feature -- Access

	context_parents: !DS_ARRAYED_LIST [!CLASS_C]
			-- Context parent classes containing contracts
		local
			l_list: LIST [CLASS_C]
			l_cursor: CURSOR
		do
			create Result.make_default
			l_list := context_stone.e_class.parents_classes
			if l_list /= Void then
				l_cursor := l_list.cursor
				from l_list.start until l_list.after loop
					if {l_class: !CLASS_C} l_list.item then
						Result.force_last (l_class)
					end
					l_list.forth
				end
				l_list.go_to (l_cursor)
			end
		end

feature -- Query

	contract_keywords (a_origin: BOOLEAN): !ARRAYED_LIST [EDITOR_TOKEN]
			-- <Precursor>
		do
			create Result.make (1)
			Result.extend (create {EDITOR_TOKEN_KEYWORD}.make ("invariant"))
		end

	has_contracts_in_class (a_class: !CLASS_C): BOOLEAN
			-- <Precursor>
		do
			Result := context_stone.e_class /= Void and then context_stone.e_class.has_invariant
		ensure then
			has_invariants: Result implies (context_stone.e_class /= Void and then context_stone.e_class.has_invariant)
		end

feature {NONE} -- Factory

	create_text_modifier: !ES_INVARIANT_CONTRACT_TEXT_MODIFIER
			-- <Precursor>
		do
			create Result.make (context_class)
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
