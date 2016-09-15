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
			process_class_as,
			process_feature_as,
			process_index_as,
			process_formal_generic_list_as,
			process_formal_dec_as,
			process_formal_as,
			process_class_type_as,
			process_generic_class_type_as,
			process_body_as,
			process_do_as,
			process_local_dec_list_as,
			process_list_dec_as,
			process_type_dec_list_as,
			process_type_dec_as,
			process_parent_list_as,
			process_routine_as,
			process_list_dec_list_as
		end
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
			if attached {CLASS_AS} ast_eiffel as l_class_as then
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
			-- Void means ANY.

	text: detachable STRING_32
			-- String representation of a code template file.

	items: detachable LIST [ES_CODE_TEMPLATE_DEFINITION_ITEM]
			-- Collection of availables templates.

	top_notes: detachable STRING_TABLE [STRING_32]
			-- Indexing clause at top of class.

feature -- Visitor

	process_class_as (a_as: CLASS_AS)
			-- <Precursor>
		do
			is_generic_argument := True
			process_top_notes (a_as.top_indexes)
			Precursor (a_as)
		end

	process_routine_as (a_as: ROUTINE_AS)
			-- <Precursor>
		do
			create local_variables.make_caseless (1)
			is_local := True
			local_type := Void
			last_local_type := Void
			Precursor (a_as)
		end

	process_feature_as (a_as: FEATURE_AS)
			-- <Precursor>
		do
				-- Create an item and add it to the list of
				-- features if it's a query or command.
			is_context_set := True
			create item.make (a_as, ast_match_list)
			item.set_context (context)
			if a_as.is_function then
				item.mark_query
				items.force (item)
			elseif a_as.is_procedure then
				item.mark_command
				items.force (item)
			else
				set_valid_template (False)
					-- Not a query or command.
			end
			Precursor (a_as)
		end

	process_body_as (a_as: BODY_AS)
			-- <Precursor>
		do
			if
				attached item as l_item and then
				attached generic_constraints as l_generic_constraints and then
				attached {FORMAL_AS} a_as.type as l_type and then
				attached l_type.name as l_name
			then
				if attached l_generic_constraints.item (l_name.name_32) as l_generic and then not l_generic.is_empty then
					l_item.set_return_type (l_generic)
				else
					l_item.set_return_type (l_name.name_32)
				end
			end
			Precursor (a_as)
		end

	process_do_as (a_as: DO_AS)
			-- <Precursor>
		local
			l_token_region: ERT_TOKEN_REGION
		do
			if
				attached item as l_item and then
				attached a_as.first_token (ast_match_list) as l_first and then
				attached a_as.last_token (ast_match_list) as l_last
			then
				create l_token_region.make (l_first.index + 2, l_last.index)
				item.set_code (ast_match_list.text_32 (l_token_region))
			end
			Precursor (a_as)
		end

	process_local_dec_list_as (a_as: LOCAL_DEC_LIST_AS)
			-- <Precursor>
		do
			Precursor (a_as)
			is_local := False
			is_local_dec_list := False
			if attached item as l_item then
				l_item.set_locals (local_variables)
			end
		end

	process_list_dec_list_as (a_as: LIST_DEC_LIST_AS)
			-- <Precursor>
		do
			is_local_dec_list := True
			Precursor (a_as)
		end

	process_list_dec_as (a_as: LIST_DEC_AS)
			-- <Precursor>
		local
			l_id_list: IDENTIFIER_LIST
			j: INTEGER
			l_name: STRING_32
		do
			l_id_list := a_as.id_list
			create local_type.make_empty
			Precursor (a_as)
			if
				attached local_variables as l_variables and then
				l_id_list.count > 0
			then
				from
					j := 1
				until
					j > l_id_list.count
				loop
					l_name := a_as.item_name (j)
					j := j + 1
					l_variables.force (local_type, l_name)
				end
			end
		end

	process_parent_list_as (a_as: PARENT_LIST_AS)
			-- <Precursor>
		do
			reset_constraining_type
			is_generic_argument := False
			Precursor (a_as)
		end

	process_type_dec_list_as (a_as: TYPE_DEC_LIST_AS)
			-- <Precursor>
		do
			create {ARRAYED_LIST [TUPLE [name: STRING_32; type: STRING_32]]} arguments.make (1)
			is_argument := True
			Precursor (a_as)
			if attached item as l_item then
				l_item.set_arguments (arguments)
--				if arguments.count > 1 then
--						--					set_valid_template (False)
--						-- Now we accept multiple arguments
--						--| like (a:T1; b:T2; c:T3)
--						--| where the first argument `a' is the context,
--						--| if the type is ANY, it means the feature is a global
--						--| template, in other case it determine the context where the
--						--| template will be available.
--						--| the others arguments, if any, will be used a input arguments
--						--| where the default values will be filled with defaults if they exist.
--				end
			end
			is_argument := False
		end

	process_type_dec_as (a_as: TYPE_DEC_AS)
			-- <Precursor>
		local
			l_id_list: IDENTIFIER_LIST
			j: INTEGER
			l_name: STRING_32
		do
			l_id_list := a_as.id_list
			if is_argument then
				create argument_type.make_empty
			end
			if is_local_dec_list then
				create local_type.make_empty
			end
			Precursor (a_as)
				-- Arguments
			if
				is_argument and then
				attached arguments as l_arguments and then
				l_id_list.count > 0
			then
				from
					j := 1
				until
					j > l_id_list.count
				loop
					l_name := a_as.item_name (j)
					j := j + 1
					l_arguments.force ([l_name, argument_type])
				end
			end
				-- Locals
			if
				is_local and then is_local_dec_list and then
				attached local_variables as l_variables and then
				l_id_list.count > 0
			then
				from
					j := 1
				until
					j > l_id_list.count
				loop
					l_name := a_as.item_name (j)
					j := j + 1
					l_variables.force (local_type, l_name)
				end
			end
		end

	process_index_as (a_as: INDEX_AS)
			-- <Precursor>
		local
			l_str: STRING_32
		do
			if
				attached item as l_item and then attached a_as.tag as l_tag
			then
				if l_tag.name_32.is_case_insensitive_equal ({ES_CODE_TEMPLATE_CONSTANTS}.title) then
					if attached a_as.index_list as l_index_list and then not l_index_list.is_empty and then attached {STRING_AS} l_index_list.at (1) as l_string then
						l_item.set_title (l_string.value_32)
					end
				elseif l_tag.name_32.is_case_insensitive_equal ({ES_CODE_TEMPLATE_CONSTANTS}.description) then
					if attached a_as.index_list as l_index_list and then not l_index_list.is_empty and then attached {STRING_AS} l_index_list.at (1) as l_string then
						l_item.set_description (l_string.value_32)
					end
				elseif l_tag.name_32.is_case_insensitive_equal ({ES_CODE_TEMPLATE_CONSTANTS}.tags) then
					if attached a_as.index_list as l_index_list and then not l_index_list.is_empty and then attached {STRING_AS} l_index_list.at (1) as l_string then
						l_item.set_tags (l_string.value_32.split (','))
					end
				elseif l_tag.name_32.is_case_insensitive_equal ({ES_CODE_TEMPLATE_CONSTANTS}.default_value) then
					if attached a_as.index_list as l_index_list and then not l_index_list.is_empty and then attached {STRING_AS} l_index_list.at (1) as l_string then
							-- remove white spaces if any.
						across
							l_string.value_32.split (',') as ic
						loop
							l_str := ic.item
							l_str.adjust
							l_item.add_default_value (l_str)
						end
					end
				end
			end
			Precursor (a_as)
		end

	process_formal_generic_list_as (a_as: FORMAL_GENERIC_LIST_AS)
			-- <Precursor>
		do
			if not a_as.is_empty then
				create generic_constraints.make_caseless (1)
			end
			Precursor (a_as)
		end

	process_formal_dec_as (a_as: FORMAL_DEC_AS)
			-- <Precursor>
		do
			reset_constraining_type
			generic_constraints.force ("", a_as.name.name_32)
			last_formal := a_as.name.name_32
			Precursor (a_as)
		end

	process_formal_as (a_as: FORMAL_AS)
			-- <Precursor>
		do
				-- template context
			if not is_context_set then
				pre_process_context (a_as)
			end
				-- feature arguments
			if is_argument then
				pre_process_arguments (a_as)
			end
				-- feature locals
			if is_local then
				pre_process_locals (a_as)
			end
			Precursor (a_as)

				-- Context
			post_process_context

				-- Arguments
			post_process_arguments

				-- Locals
			post_process_locals
		end

	process_class_type_as (a_as: CLASS_TYPE_AS)
			-- <Precursor>
		do
			if is_generic_argument and then attached generic_constraints as l_generic_constraints then
				if last_constraining_type = Void then
					last_constraining_type := a_as.class_name.name_32
					generic_constraints.force (last_constraining_type, last_formal)
				else
					set_valid_template (False)
						-- Multiple Constraints Not Supported.
				end
			end
			if is_argument and then attached argument_type as l_argument_type then
				l_argument_type.append (a_as.class_name.name_32)
			end
			if is_local_dec_list and then attached local_type as l_local_type then
				l_local_type.append (a_as.class_name.name_32)
			end
			Precursor (a_as)
		end

	process_generic_class_type_as (a_as: GENERIC_CLASS_TYPE_AS)
			-- <Precursor>
		do
			if not is_context_set then
				if a_as.class_name.name_32.is_case_insensitive_equal ({ES_CODE_TEMPLATE_CONSTANTS}.template) then
					reset_formal
					create context.make_empty
				elseif attached context as l_context then
					l_context.append (a_as.class_name.name_32)
					l_context.append (" [")
				end
			end
			if is_argument then
				last_argument_type := Void
				argument_type.append (a_as.class_name.name_32)
				argument_type.append ("[")
			end
			Precursor (a_as)
		end

feature {NONE} -- Change element

	process_top_notes (a_as: INDEXING_CLAUSE_AS)
			-- Process top notes
		local
			l_cursor: INTEGER
		do
			if attached a_as then
				create top_notes.make_caseless (1)
				from
					l_cursor := a_as.index
					a_as.start
				until
					a_as.after
				loop
					if
						attached a_as.item as l_item and then
						attached l_item.tag as l_tag and then
						attached l_item.index_list as l_index_list and then not
						l_index_list.is_empty and then
						attached {STRING_AS} l_index_list.at (1) as l_string
					then
						top_notes.force (l_string.value_32, l_tag.name_32)
					end
					a_as.forth
				end
				a_as.go_i_th (l_cursor)
			end
		end

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

feature {NONE} -- Visitor Implementation

	pre_process_context (a_as: FORMAL_AS)
			-- Process formal generics `a_as' at context level.
		do
			if last_formal = Void and then attached context as l_context then
				last_formal := a_as.name.name_32
				if attached generic_constraints as l_generic_constraints and then attached l_generic_constraints.item (last_formal) as l_constraint and then not l_constraint.is_empty then
					l_context.append (l_constraint)
				else
					l_context.append (last_formal)
				end
			elseif attached context as l_context then
				last_formal := a_as.name.name_32
				l_context.append (", ")
				if attached generic_constraints as l_generic_constraints and then attached l_generic_constraints.item (last_formal) as l_constraint and then not l_constraint.is_empty then
					l_context.append (l_constraint)
				else
					l_context.append (last_formal)
				end
			end
		end

	post_process_context
			-- Porcess context if apply.
		do
			if
				attached context as l_context and then
				not is_context_set and then
				l_context.has ('[')
			then
				l_context.append ("]")
			end
		end

	pre_process_arguments (a_as: FORMAL_AS)
			-- Process formal generics `a_as' at feature arguments level.
		do
			if last_argument_type = Void and then attached argument_type as l_argument_type then
				last_argument_type := a_as.name.name_32
				if attached generic_constraints as l_generic_constraints and then attached l_generic_constraints.item (last_argument_type) as l_constraint and then not l_constraint.is_empty then
					l_argument_type.append (l_constraint)
				else
					l_argument_type.append (last_argument_type)
				end
			elseif attached argument_type as l_argument_type then
				last_argument_type := a_as.name.name_32
				l_argument_type.append (", ")
				if attached generic_constraints as l_generic_constraints and then attached l_generic_constraints.item (last_argument_type) as l_constraint and then not l_constraint.is_empty then
					l_argument_type.append (l_constraint)
				else
					l_argument_type.append (last_argument_type)
				end
			end
		end

	post_process_arguments
			-- Process arguments if apply.
		do
			if
				is_argument and then
				attached argument_type as l_argument_type and then
				l_argument_type.has ('[')
			then
				l_argument_type.append ("]")
			end
		end

	pre_process_locals (a_as: FORMAL_AS)
			-- Process formal generics `a_as' at feature locals level.
		do
			if last_local_type = Void and then attached local_type as l_local_type then
				last_local_type := a_as.name.name_32
				if attached generic_constraints as l_generic_constraints and then attached l_generic_constraints.item (last_local_type) as l_constraint and then not l_constraint.is_empty then
					l_local_type.append (l_constraint)
				else
					l_local_type.append (last_local_type)
				end
			elseif attached local_type as l_local_type then
				last_local_type := a_as.name.name_32
				l_local_type.append (", ")
				if attached generic_constraints as l_generic_constraints and then attached l_generic_constraints.item (last_local_type) as l_constraint and then not l_constraint.is_empty then
					l_local_type.append (l_constraint)
				else
					l_local_type.append (last_local_type)
				end
			end
		end

	post_process_locals
			-- Process locals if apply
		do
			if
				is_local and then
				attached local_type as l_local_type and then
				l_local_type.has ('[')
			then
				l_local_type.append ("]")
			end
		end


feature {NONE} -- Implementation

	set_valid_template (a_boolean: BOOLEAN)
			-- Set `valid_template' to `a_boolean' value.
		do
			is_valid_template := a_boolean
		ensure
			is_valid_template_set: is_valid_template = a_boolean
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

		--	arguments: detachable STRING_TABLE [STRING_32]
		-- Table with pairs: variable name, variable type.

	arguments: detachable LIST [TUPLE [name: STRING_32; type: STRING_32]]

	is_local: BOOLEAN
			-- Visiting local variables?

	is_local_dec_list: BOOLEAN
			-- Visiting local dec list variables?

	is_argument: BOOLEAN
			-- Visiting argument variables?

	is_generic_argument: BOOLEAN
			-- Visiting generic constraint?

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
	ast_match_list_not_void: attached ast_match_list;

note
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
