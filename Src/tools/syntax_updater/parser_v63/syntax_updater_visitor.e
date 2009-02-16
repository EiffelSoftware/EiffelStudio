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
			if {l_keyword: KEYWORD_AS} l_as.is_keyword (match_list) then
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
				if {l_like_id: LIKE_ID_AS} l_as.type and then l_like_id.anchor.text (match_list).is_case_insensitive_equal (l_as.expression.text (match_list)) then
					context.add_string ("attached ")
				else
					context.add_string ("attached {")
					if {l_leaf: LEAF_AS} l_as.type.first_token (match_list) then
						l_index := l_leaf.index
						last_index := l_index
						l_as.type.process (Current)
					end
					context.add_string ("} ")
				end
				if {l_leaf: LEAF_AS} l_as.expression.first_token (match_list) then
					l_index := l_leaf.index
					last_index := l_index
					l_as.expression.process (Current)
				end
				context.add_string (" as ")
				if {l_leaf: LEAF_AS} l_as.name.first_token (match_list) then
					l_index := l_leaf.index
					last_index := l_index
					l_as.name.process (Current)
				end
				if {l_leaf: LEAF_AS} l_as.last_token (match_list) then
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
			safe_process (l_as.reference_or_expanded_keyword (match_list))
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
			safe_process (l_as.internal_generics)
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
			l_mark := a_type.attachment_mark (match_list)
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

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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
