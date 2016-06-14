note
	description: "[
		Represents a full code template model definition file.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CODE_TEMPLATE_DEFINITION

inherit

	USABLE_I

	INTERNAL_COMPILER_STRING_EXPORTER

	AST_ITERATOR
		redefine
			process_feature_as,
			process_index_as,
			process_formal_generic_list_as,
			process_formal_dec_as,
			process_formal_as,
			process_class_type_as,
			process_generic_class_type_as,
			process_routine_as,
			process_body_as,
			process_do_as,
			process_local_dec_list_as,
			process_list_dec_as,
			process_type_dec_list_as,
			process_type_dec_as
		end

	INTERNAL_COMPILER_STRING_EXPORTER

create
	make

feature {NONE} -- Initialization

	make (a_ast: AST_EIFFEL; a_ast_match_list: LEAF_AS_LIST)
		require
			attached_ast: a_ast /= Void
			attached_match_list: a_ast_match_list /= Void
		do
			ast_eiffel := a_ast
			ast_match_list := a_ast_match_list
			set_valid_template (True)
			initialize
		ensure
			ast_set: ast_eiffel = a_ast
			ast_match_list_set: ast_match_list = a_ast_match_list
		end


	initialize
		do
			initialize_code_template_definition
			initialize_text
		end

	initialize_code_template_definition
		do
					-- At the moment we only accept [T -> TYPE]
					-- and discard templates with multigeneric constraints or no constraints
			if
				attached {CLASS_AS} ast_eiffel as l_class_as
			then
				create {ARRAYED_LIST [ES_CODE_TEMPLATE_DEFINITION_ITEM]} items.make (0)
				l_class_as.process (Current)
			end
		end

	initialize_text
		do
			if is_valid_template then
				set_text (ast_eiffel.text_32 (ast_match_list))
			end
		end

feature -- Access

	context: detachable STRING
			-- Code context to apply the template, if any.

	text: detachable STRING_32
			-- String representation of a code template file.

	items: detachable LIST [ES_CODE_TEMPLATE_DEFINITION_ITEM]
			-- Collection of availables templates.

feature -- Visitor

	process_feature_as (l_as: FEATURE_AS)
		do
				-- Create an item and add it to the list of
				-- features if it's a query or command.
			is_context_set := True
			create item.make (l_as, ast_match_list)
			if l_as.is_function then
				item.mark_query
				items.force (item)
			elseif l_as.is_procedure then
				item.mark_command
				items.force (item)
			else
				set_valid_template (False)
					-- Not a query or command.
			end
			Precursor (l_as)
		end

	process_routine_as (l_as: ROUTINE_AS)
			-- <Precursor>
		do
			Precursor (l_as)
		end

	process_body_as (l_as: BODY_AS)
		do
			if attached item as l_item then
				 -- l_item.set_arguments (l_as.arguments)
				if
					attached generic_constraints as l_generic_constraints and then
					attached {FORMAL_AS} l_as.type as l_type and then
					attached l_type.name as l_name
				then
					if
						attached l_generic_constraints.item (l_name.name_32) as l_generic and then
						not l_generic.is_empty
					then
						l_item.set_return_type (l_generic)
					else
						l_item.set_return_type (l_name.name_32)
					end
				end
			end
			Precursor (l_as)
		end

	process_do_as (l_as: DO_AS)
		local
			l_token_region: ERT_TOKEN_REGION
		do
			if attached item as l_item then
				if
					attached l_as.first_token (ast_match_list) as l_first and then
					attached l_as.last_token (ast_match_list) as l_last
				then
					create l_token_region.make (l_first.index + 2, l_last.index)
					item.set_code (ast_match_list.text_32 (l_token_region))
				end
			end
			Precursor (l_as)
		end

	process_local_dec_list_as (l_as: LOCAL_DEC_LIST_AS)
			-- Process `l_as'.
		do
			create local_variables.make_caseless (1)
			is_local := True
			Precursor (l_as)
			is_local := False
			if attached item as l_item then
				l_item.set_locals (local_variables)
			end
		end

	process_list_dec_as (l_as: LIST_DEC_AS)
		local
			l_id_list: IDENTIFIER_LIST
			j: INTEGER
			l_name: STRING_32
		do
			l_id_list := l_as.id_list
			create local_type.make_empty
			Precursor (l_as)
			if attached local_variables as l_variables then
				if l_id_list.count > 0 then
					from
						j := 1
					until
						j > l_id_list.count
					loop
						l_name := l_as.item_name (j)
						j := j + 1
						l_variables.force (local_type, l_name)
					end
				end
			end
		end

	process_type_dec_list_as (l_as: TYPE_DEC_LIST_AS)
					-- Process `l_as'.
		do
			create arguments.make_caseless (1)
			is_argument := True
			Precursor (l_as)
			if attached item as l_item then
				l_item.set_arguments (arguments)
				if arguments.count > 1 then
					set_valid_template (False)
						-- Too many arguments
				end
			end
			is_argument := False
		end

	process_type_dec_as (l_as: TYPE_DEC_AS)
		local
			l_id_list: IDENTIFIER_LIST
			j: INTEGER
			l_name: STRING_32
		do
			l_id_list := l_as.id_list
			create argument_type.make_empty
			Precursor (l_as)
			if attached arguments as l_arguments then
				if l_id_list.count > 0 then
					from
						j := 1
					until
						j > l_id_list.count
					loop
						l_name := l_as.item_name (j)
						j := j + 1
						l_arguments.force (argument_type, l_name)
					end
				end
			end
		end

	process_index_as (l_as: INDEX_AS)
		do
			-- TODO refactor
			--! Extract hardcoded values into a constant class.
			if
				attached item as l_item and then
				attached {ID_AS} l_as.tag as l_tag
			then
				if l_tag.name_32.is_case_insensitive_equal ("title") then
					if
					 	attached l_as.index_list as l_index_list and then
					 	not l_index_list.is_empty and then
					 	attached {STRING_AS} l_index_list.at (1) as l_string
					then
						l_item.set_title (l_string.value_32)
					end
				elseif l_tag.name_32.is_case_insensitive_equal ("description") then
					if
					 	attached l_as.index_list as l_index_list and then
					 	not l_index_list.is_empty and then
					 	attached {STRING_AS} l_index_list.at (1) as l_string
					then
						l_item.set_description (l_string.value_32)
					end
				elseif l_tag.name_32.is_case_insensitive_equal ("tags") then
					if
					 	attached l_as.index_list as l_index_list and then
					 	not l_index_list.is_empty and then
					 	attached {STRING_AS} l_index_list.at (1) as l_string
					then
						l_item.set_tags (l_string.value_32.split (','))
					end
				end
			end
			Precursor (l_as)
		end

	process_formal_generic_list_as (l_as: FORMAL_GENERIC_LIST_AS)
			-- <Precursor>
		do
			if not l_as.is_empty then
				create generic_constraints.make_caseless (1)
			end
			Precursor (l_as)
		end

	process_formal_dec_as (l_as: FORMAL_DEC_AS)
			-- <Precursor>
		do
			reset_constraining_type
			generic_constraints.force ("", l_as.name.name_32)
			last_formal := l_as.name.name_32
			Precursor (l_as)
		end

	process_formal_as (l_as: FORMAL_AS)
			-- <Precursor>
		do
					-- template context
			if not is_context_set then
				if
					last_formal = Void and then
					attached context as l_context
				then
					last_formal := l_as.name.name_32
					if
						attached generic_constraints as l_generic_constraints and then
						attached l_generic_constraints.item (last_formal) as l_constraint and then
						not l_constraint.is_empty
					then
						l_context.append (l_constraint)
					else
						l_context.append (last_formal)
					end
				elseif attached context as l_context then
					last_formal := l_as.name.name_32
					l_context.append (", ")
					if
						attached generic_constraints as l_generic_constraints and then
						attached l_generic_constraints.item (last_formal) as l_constraint and then
						not l_constraint.is_empty
					then
						l_context.append (l_constraint)
					else
						l_context.append (last_formal)
					end
				end
			end
				-- feature arguments
			if is_argument then
				if
					last_argument_type = Void and then
					attached argument_type as l_argument_type
				then
					last_argument_type := l_as.name.name_32
					if
						attached generic_constraints as l_generic_constraints and then
						attached l_generic_constraints.item (last_argument_type) as l_constraint and then
						not l_constraint.is_empty
					then
						l_argument_type.append (l_constraint)
					else
						l_argument_type.append (last_argument_type)
					end
				elseif attached argument_type as l_argument_type then
					last_argument_type := l_as.name.name_32
					l_argument_type.append (", ")
					if
						attached generic_constraints as l_generic_constraints and then
						attached l_generic_constraints.item (last_argument_type) as l_constraint and then
						not l_constraint.is_empty
					then
						l_argument_type.append (l_constraint)
					else
						l_argument_type.append (last_argument_type)
					end
				end
			end
				-- feature locals
			if is_local then
				if
					last_local_type = Void and then
					attached local_type as l_local_type
				then
					last_local_type := l_as.name.name_32
					if
						attached generic_constraints as l_generic_constraints and then
						attached l_generic_constraints.item (last_local_type) as l_constraint and then
						not l_constraint.is_empty
					then
						l_local_type.append (l_constraint)
					else
						l_local_type.append (last_local_type)
					end
				elseif attached local_type as l_local_type then
					last_local_type := l_as.name.name_32
					l_local_type.append (", ")
					if
						attached generic_constraints as l_generic_constraints and then
						attached l_generic_constraints.item (last_local_type) as l_constraint and then
						not l_constraint.is_empty
					then
						l_local_type.append (l_constraint)
					else
						l_local_type.append (last_local_type)
					end
				end
			end

			Precursor (l_as)
			if attached context as l_context and not is_context_set then
				l_context.append ("]")
			end
			if is_argument and then attached argument_type as l_argument_type then
				l_argument_type.append ("]")
			end
			if is_local and then attached local_type as l_local_type then
				l_local_type.append ("]")
			end
		end

	process_class_type_as (l_as: CLASS_TYPE_AS)
			-- <Precursor>
		do
			if
				attached generic_constraints as l_generic_constraints
			then
				if last_constraining_type = Void then
					last_constraining_type := l_as.class_name.name_32
					generic_constraints.force (last_constraining_type, last_formal)
				else
					set_valid_template (False)
						-- Multiple Constraints Not Supported.
				end
			end
			Precursor (l_as)
		end

	process_generic_class_type_as (l_as: GENERIC_CLASS_TYPE_AS)
			-- <Precursor>
		do
			if not is_context_set then
				if
					l_as.class_name.name_32.is_case_insensitive_equal ("TEMPLATE")
				then
					reset_formal
					create context.make_empty
				elseif
					attached context as l_context then
					l_context.append (l_as.class_name.name_32)
					l_context.append (" [")
				end
			end
			if is_argument then
				last_argument_type := Void
				argument_type.append (l_as.class_name.name_32)
				argument_type.append ("[")
			end
			Precursor (l_as)
		end

feature {NONE} -- Change element

	set_text (a_text: READABLE_STRING_32)
			-- set `text' with `a_text'.
		do
			text := a_text
		ensure
			text_set: text.same_string_general (a_text)
		end

feature -- Status report

	is_interface_usable: BOOLEAN
			-- <Precursor>
		do
			Result := attached ast_eiffel
		ensure then
			is_initialized: Result implies (attached ast_eiffel)
		end

	is_valid_template: BOOLEAN
			-- Is the current template valid?
		do
			Result := valid_template
		end

feature {NONE} -- Implementation

	valid_template:  BOOLEAN
			-- True if the Eiffel template is valid, False in other case.

	set_valid_template (a_boolean: BOOLEAN)
			-- Set `valid_template' to `a_boolean' value.
		do
			valid_template := a_boolean
		ensure
			valid_template_set:  valid_template = a_boolean
		end

	ast_eiffel: AST_EIFFEL
			-- ast generated of the current template.

	ast_match_list: LEAF_AS_LIST
			-- match list generated of the current templates.


	item: detachable ES_CODE_TEMPLATE_DEFINITION_ITEM
			-- template definition.

	generic_constraints: detachable STRING_TABLE [STRING_32]
			-- table with pairs [T, TYPE]
			-- for generics constraints if any.
			--! ARRAY_TEMPLATE [T -> COMPARABLE]
			--! HASH_TEMPLATE [G, H -> HASHABLE]

	local_variables: detachable STRING_TABLE [STRING_32]
			-- Table with pairs: variable name, variable type.

	arguments: detachable STRING_TABLE [STRING_32]
			-- Table with pairs: variable name, variable type.	

	is_local: BOOLEAN
			-- Visiting local variables?

	is_argument: BOOLEAN
			-- Visiting argument variables?		

	local_type: detachable STRING_32
			-- Local variable type.

	last_local_type: detachable STRING_32
			-- Last local variable type.

	argument_type: detachable STRING_32
			-- Argument type.		

	last_argument_type: detachable STRING_32
			-- Last argument type.

	last_formal: detachable STRING_32
			-- last formal generic parameter declaration.

	last_constraining_type: detachable STRING_32
			--  last generic_parameters constraint type of a formal generic parameter declaration.

	is_context_set: BOOLEAN
			-- Is the context set?

	reset_constraining_type
		do
			last_constraining_type := Void
		end

	reset_formal
		do
			last_formal := Void
		end


invariant

		ast_not_void: attached ast_eiffel
		ast_match_list_not_void: attached ast_match_list

;note
	copyright: "Copyright (c) 1984-2016, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
