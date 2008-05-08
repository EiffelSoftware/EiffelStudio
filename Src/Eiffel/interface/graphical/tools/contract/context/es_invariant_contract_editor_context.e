indexing
	description: "[
		A contract editor ({ES_CONTRACT_EDITOR_WIDGET}) context for class invariant contracts.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ES_INVARIANT_CONTRACT_EDITOR_CONTEXT

inherit
	ES_CLASS_CONTRACT_EDITOR_CONTEXT

feature -- Contracts

	contracts_for_class (a_class: !CLASS_I; a_live: BOOLEAN): !TUPLE [contracts: !DS_LIST [TAGGED_AS]; modifier: !ES_CONTRACT_TEXT_MODIFIER [AST_EIFFEL]]
			-- <Precursor>
		local
			l_modifier: !like text_modifier
			l_class_i: !CLASS_I
			l_class_c: !CLASS_C
			l_class_as: ?CLASS_AS
			l_invariant_as: ?INVARIANT_AS
			l_invariants: ?EIFFEL_LIST [TAGGED_AS]
			l_parent_context: ES_INVARIANT_CONTRACT_EDITOR_CONTEXT
			l_result: !DS_ARRAYED_LIST [TAGGED_AS]
		do
			create l_result.make_default

			if a_class = context_class then
				l_modifier := text_modifier
			else
					-- Create a temporary context object to fetch a text modifier.
				create l_parent_context
				l_parent_context.set_stone (create {CLASSI_STONE}.make (a_class))
				l_modifier := l_parent_context.text_modifier
			end

			if a_live then
					-- We have a text modifier now, extract the contracts
				if not l_modifier.is_prepared then
						-- Prepare to parse class
					l_modifier.prepare
				end

				if l_modifier.is_ast_available then
						-- Use live AST
					l_class_as := l_modifier.ast
				end
			end

			if l_class_as /= Void then
					-- Should only be avilable when requesting live data.
				check a_live: a_live end

					-- Use live AST
				l_invariant_as := l_class_as.invariant_part
			elseif not a_live then
					-- Class contains syntax errors or request to use the non-live data, use compiled data
				l_class_i := l_modifier.context_class
				if l_class_i.is_compiled then
					l_class_c ?= l_class_i.compiled_class
					if l_class_c.has_invariant then
							-- Use compiled AST
						l_invariant_as := l_class_c.invariant_ast
					end
				end
			end

			if l_invariant_as /= Void then
					-- Extract contracts
				l_invariants := l_invariant_as.assertion_list
				if l_invariants /= Void then
					from l_invariants.start until l_invariants.after loop
						l_result.force_last (l_invariants.item)
						l_invariants.forth
					end
				end
			end

			Result ?= [l_result, l_modifier]
		end

	template_category: !STRING = "invariant"
			-- <Precondition>		

feature -- Query

	contract_keywords (a_origin: BOOLEAN): !ARRAYED_LIST [EDITOR_TOKEN]
			-- <Precursor>
		do
			create Result.make (1)
			Result.extend (create {EDITOR_TOKEN_KEYWORD}.make ("invariant"))
		end

feature {NONE} -- Factory

	create_text_modifier: !ES_INVARIANT_CONTRACT_TEXT_MODIFIER
			-- <Precursor>
		do
			create Result.make (context_class)
		end

	create_parent_text_modifier (a_parent: !CLASS_C): !ES_INVARIANT_CONTRACT_TEXT_MODIFIER
			-- <Precursor>
		local
			l_class_i: !CLASS_I
		do
			l_class_i ?= a_parent.lace_class
			create Result.make (l_class_i)
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
