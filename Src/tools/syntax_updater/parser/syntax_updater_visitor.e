note
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SYNTAX_UPDATER_VISITOR

inherit
	AST_ROUNDTRIP_PRINTER_VISITOR
		redefine
			process_bang_creation_as,
			process_bang_creation_expr_as,
			process_body_as,
			process_create_as,
			process_indexing_clause_as,
			process_object_test_as,
			process_static_access_as,
			process_like_id_as,
			process_like_cur_as,
			process_formal_as,
			process_class_type_as,
			process_generic_class_type_as,
			process_named_tuple_type_as,
			context,
			reset
		end

create
	make_with_default_context

feature -- Status report

	is_updated: BOOLEAN
			-- Did current processing changed the AST?

	is_updating_agents: BOOLEAN
			-- Are we updating agents to drop the first actual generic parameter
			-- and replacing TUPLE with nothing, i.e. PROCEDURE [ANY, TUPLE [STRING]]
			-- becoming PROCEDURE [STRING].

feature -- Status setting

	set_is_updating_agents (v: like is_updating_agents)
			-- Set `is_updating_agents' with `v'.
		do
			is_updating_agents := v
		ensure
			is_updating_agents_set: is_updating_agents = v
		end

feature -- Reset

	reset
			-- Reset `Current'.
		do
			is_updated := False
			Precursor {AST_ROUNDTRIP_PRINTER_VISITOR}
		end

feature -- AST visiting

	process_bang_creation_as (l_as: BANG_CREATION_AS)
			-- Process `l_as'.
		do
			is_updated := True
			if l_as.lbang_symbol /= Void then
					-- If previous token is a text, we need to insert a space.
				add_white_space_if_necessary
					-- Process the previous white spaces if any and ignore the !
				process_leading_leaves (l_as.lbang_symbol.index)
				last_index := l_as.lbang_symbol.index
			end
			if l_as.type /= Void then
				context.add_string ("create {")
					-- Remove all white spaces between the first ! and the type.
				remove_following_spaces
				l_as.type.process (Current)
				context.add_string  ("}" )
			else
				context.add_string ("create")
			end
			if l_as.rbang_symbol /= Void then
					-- Remove spaces between the type and the second !.
				remove_following_spaces
				process_leading_leaves (l_as.rbang_symbol.index)
				last_index := l_as.rbang_symbol.index
			end
				-- Ensure that there is at most one space before `target'.
			context.add_string (" ")
			remove_following_spaces
			safe_process (l_as.target)
			safe_process (l_as.call)
		end

	process_bang_creation_expr_as (l_as: BANG_CREATION_EXPR_AS)
			-- Process `l_as'.
		do
			is_updated := True
			if l_as.lbang_symbol /= Void then
					-- Process the previous white spaces and ignore the !
				process_leading_leaves (l_as.lbang_symbol.index)
				last_index := l_as.lbang_symbol.index
			end
			context.add_string ("create {")
				-- Remove all white spaces between the first ! and the type.
			remove_following_spaces
			l_as.type.process (Current)
			context.add_string  ("}" )
			if l_as.rbang_symbol /= Void then
					-- Remove spaces between the type and the second !.
				remove_following_spaces
				process_leading_leaves (l_as.rbang_symbol.index)
				last_index := l_as.rbang_symbol.index
			end
				-- Ensure that there is at most one space before `target'.
			safe_process (l_as.call)
		end

	process_body_as (l_as: BODY_AS)
			-- <Precursor>
		local
			c_as: CONSTANT_AS
		do
			safe_process (l_as.internal_arguments)
			safe_process (l_as.colon_symbol (match_list))
			safe_process (l_as.type)
			safe_process (l_as.assign_keyword (match_list))
			safe_process (l_as.assigner)
			c_as ?= l_as.content
			if attached {KEYWORD_AS} l_as.is_keyword (match_list) as l_keyword then
				if l_keyword.code = {EIFFEL_TOKENS}.te_is then
					if c_as /= Void then
						process_leading_leaves (l_as.is_keyword_index)
						if c_as /= Void then
							context.add_string ("=")
						end
					else
						remove_following_spaces
					end
					last_index := l_as.is_keyword_index
					is_updated := True
				else
					l_keyword.process (Current)
				end
			end
			if c_as /= Void then
				l_as.content.process (Current)
				safe_process (l_as.indexing_clause)
			else
				safe_process (l_as.indexing_clause)
				safe_process (l_as.content)
			end
		end

	process_create_as (l_as: CREATE_AS)
		local
			l_keyword: KEYWORD_AS
		do
			l_keyword := l_as.create_creation_keyword (match_list)
			if l_keyword /= Void then
				if l_keyword.code = {EIFFEL_TOKENS}.te_creation then
					is_updated := True
					process_leading_leaves (l_as.create_creation_keyword_index)
					last_index := l_as.create_creation_keyword_index
					context.add_string ("create")
				else
					l_keyword.process (Current)
				end
			end
			safe_process (l_as.clients)
			safe_process (l_as.feature_list)
		end

	process_indexing_clause_as (l_as: INDEXING_CLAUSE_AS)
			-- <Precursor>'
		local
			l_keyword: KEYWORD_AS
		do
			l_keyword := l_as.indexing_keyword (match_list)
			if l_keyword /= Void then
				if l_keyword.code = {EIFFEL_TOKENS}.te_indexing then
					is_updated := True
					process_leading_leaves (l_as.indexing_keyword_index)
					last_index := l_as.indexing_keyword_index
					context.add_string ("note")
				else
					l_keyword.process (Current)
				end
			end
			process_eiffel_list (l_as)
			safe_process (l_as.end_keyword (match_list))
		end

	process_object_test_as (l_as: OBJECT_TEST_AS)
		local
			l_index: INTEGER
		do
			if l_as.is_attached_keyword then
				safe_process (l_as.attached_keyword (match_list))
				safe_process (l_as.type)
				l_as.expression.process (Current)
				safe_process (l_as.as_keyword (match_list))
				safe_process (l_as.name)
			else
				is_updated := True
				l_index := l_as.lcurly_symbol_index
				process_leading_leaves (l_index)
				last_index := l_index
					-- We discard the type information when it is exactly the same as the expression
				if attached {LIKE_ID_AS} l_as.type as l_like_id and then l_like_id.anchor.text (match_list).is_case_insensitive_equal (l_as.expression.text (match_list)) then
					context.add_string ("attached ")
				else
					context.add_string ("attached {")
					if attached {LEAF_AS} l_as.type.first_token (match_list) as l_leaf then
						l_index := l_leaf.index
						last_index := l_index
						l_as.type.process (Current)
					end
					context.add_string ("} ")
				end
				if attached {LEAF_AS} l_as.expression.first_token (match_list) as l_leaf then
					l_index := l_leaf.index
					last_index := l_index
					l_as.expression.process (Current)
				end
				context.add_string (" as ")
				if attached {LEAF_AS} l_as.name.first_token (match_list) as l_leaf then
					l_index := l_leaf.index
					last_index := l_index
					l_as.name.process (Current)
				end
				if attached {LEAF_AS} l_as.last_token (match_list) as l_leaf then
					last_index := l_leaf.index
				end
			end
		end

	process_static_access_as (l_as: STATIC_ACCESS_AS)
			-- Process `l_as'.
		do
			if l_as.feature_keyword (match_list) /= Void then
					-- Process the previous white spaces, ignore `feature' and remove
					-- remaining spaces.
				is_updated := True
				process_leading_leaves (l_as.feature_keyword_index)
				last_index := l_as.feature_keyword_index
				remove_following_spaces
			end
				-- Normal processing
			safe_process (l_as.class_type)
			safe_process (l_as.dot_symbol (match_list))
			safe_process (l_as.feature_name)
			safe_process (l_as.internal_parameters)
		end

feature -- Types

	process_like_id_as (l_as: LIKE_ID_AS)
		do
			safe_process (l_as.lcurly_symbol (match_list))
			process_attachment_mark (l_as)
			safe_process (l_as.like_keyword (match_list))
			safe_process (l_as.anchor)
			safe_process (l_as.rcurly_symbol (match_list))
		end

	process_like_cur_as (l_as: LIKE_CUR_AS)
		do
			safe_process (l_as.lcurly_symbol (match_list))
			process_attachment_mark (l_as)
			safe_process (l_as.like_keyword (match_list))
			safe_process (l_as.current_keyword)
			safe_process (l_as.rcurly_symbol (match_list))
		end

	process_formal_as (l_as: FORMAL_AS)
		do
			safe_process (l_as.lcurly_symbol (match_list))
			process_attachment_mark (l_as)
			safe_process (l_as.formal_keyword (match_list))
			safe_process (l_as.name)
			safe_process (l_as.rcurly_symbol (match_list))
		end

	process_class_type_as (l_as: CLASS_TYPE_AS)
		do
			safe_process (l_as.lcurly_symbol (match_list))
			process_attachment_mark (l_as)
			safe_process (l_as.expanded_keyword (match_list))
			safe_process (l_as.separate_keyword (match_list))
			safe_process (l_as.class_name)
			safe_process (l_as.rcurly_symbol (match_list))
		end

	process_generic_class_type_as (l_as: GENERIC_CLASS_TYPE_AS)
		do
			safe_process (l_as.lcurly_symbol (match_list))
			process_attachment_mark (l_as)
			safe_process (l_as.expanded_keyword (match_list))
			safe_process (l_as.separate_keyword (match_list))
			safe_process (l_as.class_name)
			if is_agent_class (l_as.class_name.name_32) then
				simplify_generics_for_agent (l_as.class_name.name_32, l_as.internal_generics)
			else
				safe_process (l_as.internal_generics)
			end
			safe_process (l_as.rcurly_symbol (match_list))
		end

	process_named_tuple_type_as (l_as: NAMED_TUPLE_TYPE_AS)
		do
			safe_process (l_as.lcurly_symbol (match_list))
			process_attachment_mark (l_as)
			safe_process (l_as.separate_keyword (match_list))
			safe_process (l_as.class_name)
			safe_process (l_as.parameters)
			safe_process (l_as.rcurly_symbol (match_list))
		end


feature {NONE} -- Access

	context: ROUNDTRIP_STRING_LIST_CONTEXT

	add_white_space_if_necessary
			-- Add a white space only if the next token is not already a break.
		local
			l_break_as: BREAK_AS
			l_index: INTEGER
		do
			l_index := last_index
			if match_list.valid_index (l_index) then
				l_break_as ?= match_list.i_th (l_index)
				if l_break_as = Void then
					context.add_string (" ")
				end
			end
		end

	remove_following_spaces
			-- Remove all white spaces..
		local
			l_break_as: BREAK_AS
			l_index: INTEGER
			l_string: STRING
			l_done: BOOLEAN
		do
			l_index := last_index + 1
			if match_list.valid_index (l_index) then
				l_break_as ?= match_list.i_th (last_index + 1)
				if l_break_as /= Void then
					l_string := l_break_as.literal_text (match_list)
					if l_string /= Void then
						l_string := l_string.twin
						from
						until
							l_done
						loop
							if not l_string.is_empty then
								inspect
									l_string.item (1)
								when ' ', '%T' then l_string.remove (1)
								else
									l_done := True
								end
							else
								l_done := True
							end
						end
						context.add_string (l_string)
						last_index := l_index
					end
				end
			end
		end

	process_following_breaks
			-- Process all breaks until a non-break is encountered.
		local
			i: INTEGER
			stop: BOOLEAN
			l_break: BREAK_AS
		do
			from
				i := last_index + 1
			until
				stop
			loop
				if match_list.valid_index (i) then
					l_break ?= match_list.i_th (i)
					if l_break /= Void then
						l_break.process (Current)
					else
						stop := True
					end
				else
					stop := True
				end
				i := i + 1
			end
			last_index := i
		end

	process_attachment_mark (a_type: TYPE_AS)
			-- Update ? and ! types to detachable and attached ones.
		require
			a_type_not_void: a_type /= Void
		local
			l_mark: SYMBOL_AS
		do
			l_mark := a_type.attachment_symbol (match_list)
			if l_mark /= Void then
				if l_mark.code = {EIFFEL_TOKENS}.te_bang then
					is_updated := True
					process_leading_leaves (a_type.attachment_mark_index)
					last_index := a_type.attachment_mark_index
					context.add_string ("attached ")
				elseif l_mark.code = {EIFFEL_TOKENS}.te_question then
					is_updated := True
					process_leading_leaves (a_type.attachment_mark_index)
					last_index := a_type.attachment_mark_index
					context.add_string ("detachable ")
				else
					l_mark.process (Current)
				end
			end
		end

feature {NONE} -- Implementation

	is_agent_class (a_name: STRING_32): BOOLEAN
			-- Is agent simplification requested and does `a_name' represent an agent
			-- class, i.e. ROUTINE, PROCEDURE, FUNCTION or PREDICATE?
		do
			Result := is_updating_agents and then
				(a_name.is_case_insensitive_equal (routine_class_name) or
				a_name.is_case_insensitive_equal (procedure_class_name) or
				a_name.is_case_insensitive_equal (function_class_name) or
				a_name.is_case_insensitive_equal (predicate_class_name))
		end

	simplify_generics_for_agent (a_name: STRING_32; l_as: TYPE_LIST_AS)
			-- Simplify actual generics
		require
			is_agent_class: is_agent_class (a_name)
		local
			l_has_two_parameter: BOOLEAN
			l_type: TYPE_AS
			l_tuple: detachable CLASS_TYPE_AS
			l_keep_as_tuple_type: detachable TYPE_AS
		do
			if
				a_name.is_case_insensitive_equal (routine_class_name) or
				a_name.is_case_insensitive_equal (procedure_class_name) or
				a_name.is_case_insensitive_equal (predicate_class_name)
			then
					-- We are done if ROUTINE/PROCEDURE/PREDUCATE doesn't have 2 actual generic parameters
					-- and if 2, the second one has to be a TUPLE.
				if l_as.count = 2 then
					l_has_two_parameter := True
					l_type := l_as.i_th (2)
					if attached {NAMED_TUPLE_TYPE_AS} l_type then
						l_keep_as_tuple_type := l_type
					elseif
						attached {CLASS_TYPE_AS} l_type as l_class and then
						l_class.class_name.name_32.is_case_insensitive_equal (tuple_class_name)
					then
						l_tuple := l_class
							-- If we have PROCEDURE [ANY, TUPLE [TUPLE [...]]], we cannot
							-- convert it to PROCEDURE [TUPLE [...]] as this would be considered
							-- an agent of type PROCEDURE [...].
						if attached l_tuple.generics as l_gen and then l_gen.count = 1 and then is_tuple_type (l_gen.i_th (1)) then
							l_tuple := Void
						end
					elseif attached {FORMAL_AS} l_type as l_formal then
							-- Check if we are handling a formal who is constraint to TUPLE
						if parsed_class.generics.i_th (l_formal.position).constraints.count = 1 then
							if is_tuple_type (parsed_class.generics.i_th (l_formal.position).constraint.type) then
								l_keep_as_tuple_type := l_formal
							end
						end
					end
				end
			else
				check is_predicate: a_name.is_case_insensitive_equal (function_class_name) end
					-- We are done if FUNCTION doesn't have 3 actual generic parameters and if 3, the second
					-- one has to be a TUPLE.			
				if l_as.count = 3 then
					l_has_two_parameter := False
					l_type := l_as.i_th (2)
					if attached {NAMED_TUPLE_TYPE_AS} l_type then
						l_keep_as_tuple_type := l_type
					elseif
						attached {CLASS_TYPE_AS} l_type as l_class and then
						l_class.class_name.name_32.is_case_insensitive_equal (tuple_class_name)
					then
						l_tuple := l_class
							-- If we have FUNCTION [ANY, TUPLE [TUPLE [...]], RES], we cannot
							-- convert it to FUNCTION [TUPLE [...], RES] as this would be considered
							-- an agent of type FUNCTION [..., RES].
						if attached l_tuple.generics as l_gen and then l_gen.count = 1 and then is_tuple_type (l_gen.i_th (1)) then
							l_tuple := Void
						end
					elseif attached {FORMAL_AS} l_type as l_formal then
							-- Check if we are handling a formal who is constraint to TUPLE
						if parsed_class.generics.i_th (l_formal.position).constraints.count = 1 then
							if is_tuple_type (parsed_class.generics.i_th (l_formal.position).constraint.type) then
								l_keep_as_tuple_type := l_formal
							end
						end
					end
				end
			end

				-- If heuristics shows that it has been updated already, we use the default version
			if l_tuple = Void and l_keep_as_tuple_type = Void then
				safe_process (l_as)
			else
				is_updated := True
				if l_has_two_parameter then
					if l_tuple /= Void and then attached l_tuple.generics as l_generics then
							-- Case of a tuple with actual generic parameters
						process_leading_leaves (l_as.opening_bracket_as_index)
						last_index := l_tuple.generics.opening_bracket_as_index
						safe_process (l_generics)
						last_index := l_as.closing_bracket_as_index
					elseif l_keep_as_tuple_type /= Void then
							-- Case of a named tuple or formal constrained to TUPLE, we leave it as is.
						safe_process (l_as.opening_bracket_as (match_list))
						last_index := l_keep_as_tuple_type.first_token (match_list).index
						safe_process (l_keep_as_tuple_type)
						safe_process (l_as.closing_bracket_as (match_list))
					else
							-- Case of an agent of the form PROCEDURE [ANY, TUPLE],
							-- the new declaration is simply PROCEDURE.
							-- We drop everything between the brackets, including them.
						last_index := l_as.closing_bracket_as (match_list).index
					end
				else
					if l_tuple /= Void and then attached l_tuple.generics as l_generics then
						safe_process (l_as.opening_bracket_as (match_list))
						last_index := l_tuple.generics.opening_bracket_as_index
						across l_generics as l_gen loop
							safe_process (l_gen.item)
						end
						last_index := l_tuple.generics.closing_bracket_as_index
						safe_process (l_as.i_th (3))
						safe_process (l_as.closing_bracket_as (match_list))
					elseif l_keep_as_tuple_type /= Void then
							-- Case of a named tuple with actual generic parameters, we leave it as is.
						safe_process (l_as.opening_bracket_as (match_list))
						last_index := l_keep_as_tuple_type.first_token (match_list).index
						safe_process (l_keep_as_tuple_type)
						safe_process (l_as.i_th (3))
						safe_process (l_as.closing_bracket_as (match_list))
					else
							-- Case of an agent of the form FUNCTION [ANY, TUPLE, STRING],
							-- the new declaration is FUNCTION [STRING].
						safe_process (l_as.opening_bracket_as (match_list))
							-- Dropping the first generic parameter, and keeping the one from the tuple.
						last_index := l_as.i_th (3).first_token (match_list).index
						safe_process (l_as.i_th (3))
						safe_process (l_as.closing_bracket_as (match_list))
					end
				end
			end
		end

	is_tuple_type (a_type: TYPE_AS): BOOLEAN
			-- Does `a_type' represent a TUPLE type?
		do
			if attached {NAMED_TUPLE_TYPE_AS} a_type then
				Result := True
			elseif
				attached {CLASS_TYPE_AS} a_type as l_class and then
				l_class.class_name.name_32.is_case_insensitive_equal (tuple_class_name)
			then
				Result := True
			end
		end

	routine_class_name: STRING_32 = "ROUTINE"
	procedure_class_name: STRING_32 = "PROCEDURE"
	function_class_name: STRING_32 = "FUNCTION"
	predicate_class_name: STRING_32 = "PREDICATE"
	tuple_class_name: STRING_32 = "TUPLE"
			-- Name of agent types being in use.

note
	copyright: "Copyright (c) 1984-2015, Eiffel Software"
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
