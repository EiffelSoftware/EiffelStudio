indexing
	description: "[
		Base class text modifiers for modifying class and feature contracts.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	ES_CONTRACT_TEXT_MODIFIER [G -> AST_EIFFEL]

inherit
	ES_CLASS_TEXT_AST_MODIFIER

feature -- Access

	contract_ast: ?G
			-- Applicable contract AST node
		require
			is_prepared: is_prepared
			is_ast_available: is_ast_available
		deferred
		end

feature {NONE} -- Access

	template: ?CODE_TEMPLATE_DEFINITION
			-- Contract code template
		local
			l_service: like code_template_catalog
		do
			l_service := code_template_catalog
			if l_service.is_service_available then
				Result := l_service.service.template_by_shortcut (template_identifier)
			end
		end

	template_identifier: !STRING_32
			-- Template identifer used to look up the contract code template
		deferred
		ensure
			not_result_is_empty: not Result.is_empty
		end

feature {NONE} -- Element change

	set_template_values (a_table: !CODE_SYMBOL_TABLE)
			-- Sets the values use in rendering a template.
			--
			-- `a_table': The symbol table used to render a template
		deferred
		end

feature {NONE} -- Helpers

	frozen code_template_catalog: SERVICE_CONSUMER [CODE_TEMPLATE_CATALOG_S]
			-- Access to the code template catalog
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Query

	contract_insertion_position: INTEGER
			-- Retrieve the start location for contract insertion
		require
			is_prepared: is_prepared
			is_ast_available: is_ast_available
		deferred
		ensure
			result_positive: Result > 0
		end

feature -- Basic operations

	replace_contracts (a_assertions: DS_BILINEAR [STRING])
			-- Replaces the precondition contracts of a feature.
			--
			-- `a_assertions': Asssertions to replace contracts with.
		require
			is_prepared: is_prepared
			is_ast_available: is_ast_available
			a_assertions_attached: a_assertions /= Void
			a_assertions_contains_attached_items: not a_assertions.has (Void)
		local
			l_code: !STRING
			l_ws: !STRING
			l_pos: INTEGER
			l_st_builder: CODE_SYMBOL_TABLE_BUILDER
			l_table: !CODE_SYMBOL_TABLE
			l_value: !CODE_SYMBOL_VALUE
			l_renderer: !CODE_TEMPLATE_STRING_RENDERER
			l_contract_ast: ?G
			l_version: !CODE_VERSION
		do
			if not a_assertions.is_empty then
					-- No preconditions (or invalid AST)
				l_pos := contract_insertion_position
				if l_pos > 0 then
						-- Fetch initial whitespace
					l_ws := initial_whitespace (l_pos)
				end

				if {l_template: !like template} template then
						-- Build symbol table and code template.
					create l_st_builder.make (l_template)
					l_table := l_st_builder.symbol_table

							-- Generate code for contracts
					create l_code.make (200)
					from a_assertions.start until a_assertions.after loop
						if not a_assertions.is_first then
								-- The template already contains the spacing necessary.
							l_code.append ("%T")
						end
						l_code.append (a_assertions.item_for_iteration)
						l_code.append ("%N")
						a_assertions.forth
					end

						-- Set value.
					if {l_code_32: !STRING_32} l_code.as_string_32 then
						if l_table.has_id ({CODE_TEMPLATE_ENTITY_NAMES}.selection_token_name) then
							l_value := l_table.item ({CODE_TEMPLATE_ENTITY_NAMES}.selection_token_name)
							l_value.set_value (l_code_32)
						else
							create l_value.make (l_code_32)
							l_table.put (l_value, {CODE_TEMPLATE_ENTITY_NAMES}.selection_token_name)
						end
					end

						-- Give Current a chance to add additional values.
					set_template_values (l_table)

						-- Render template.
					if {l_actual_template: !CODE_TEMPLATE} l_template.applicable_item then
						create l_renderer
						l_renderer.render_template (l_actual_template, l_table)

							-- Add indentation.
						l_renderer.code.replace_substring_all (("%N").as_string_32, ("%N" + l_ws).as_string_32)

							-- Insert code.
						insert_code (l_pos, l_renderer.code)
					else
							-- Report error
						if logger.is_service_available then
							logger.service.put_message_format_with_severity ("No suitable contract template could be found for `{1}' in {2}, for the current version of the compiler.", [template_identifier, context_class.name], {ENVIRONMENT_CATEGORIES}.editor, {PRIORITY_LEVELS}.high)
						end
					end
				end
			end

			l_contract_ast := contract_ast
			if l_contract_ast /= Void then
					-- Remove the contracts, because we've added the contracts anyway.
				remove_ast_code (l_contract_ast, True)
			end
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
