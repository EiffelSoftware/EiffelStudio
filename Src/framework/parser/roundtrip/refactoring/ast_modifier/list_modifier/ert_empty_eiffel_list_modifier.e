note
	description: "[
					Object that for appending items to an empty EIFFEL_LIST.
					Only `append_last_item' is effective because originally, current is an empty list.
					]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ERT_EMPTY_EIFFEL_LIST_MODIFIER

inherit
	ERT_BASIC_EIFFEL_LIST_MODIFIER

create
	make

feature
	make (a_attached_ast: AST_EIFFEL; a_prepend: BOOLEAN; a_list: like match_list)
			-- Initialize instance.
			-- `a_attached_ast' is the AST node to whose text current is to be prepended (if `a_prepend' is Ture) or
			-- to be appended (if `a_prepend' is False).
			-- `a_list' is match list needed for roundtrip operations.
		require
			a_attached_ast_not_void: a_attached_ast /= Void
			a_list_not_void: a_list /= Void
		do
			attached_ast := a_attached_ast
			match_list := a_list
			is_prepended := a_prepend
			create prepend_modifier_list.make
			create append_modifier_list.make
			counter := 1
			separator := ""
			leading_text := ""
			trailing_text := ""
		ensure
			a_attached_ast_set: attached_ast = a_attached_ast
			is_prepended_set: is_prepended = a_prepend
		end

feature -- Applicability

	can_apply: BOOLEAN
			-- Can current modifier be applied?
		do
			Result := True
			if header_text /= Void and then attached header_ast as l_header_ast then
				Result := l_header_ast.can_replace_text (match_list)
			end
			if footer_text /= Void and then attached footer_ast as l_footer_ast then
				Result := l_footer_ast.can_replace_text (match_list)
			end
			if Result then
				if is_prepended then
					Result := attached_ast.can_prepend_text (match_list)
				else
					Result := attached_ast.can_append_text (match_list)
				end
			end
		end

	apply
			-- Apply current modifier.
		local
			l_modifier_list: like prepend_modifier_list
		do
			l_modifier_list := merge_modifier_list
			compute_modification (l_modifier_list)
			if attached header_text as l_header_text and then attached header_ast as l_header_ast then
				l_header_ast.replace_text (l_header_text, match_list)
			end
			if attached footer_text as l_footer_text and then attached footer_ast as l_footer_ast then
				l_footer_ast.replace_text (l_footer_text, match_list)
			end
			l_modifier_list.do_all (agent {ERT_LIST_ITEM_MODIFIER}.apply)
			applied := True
		end

feature {INTERNAL_COMPILER_STRING_EXPORTER} -- Modifier register

	insert_left (item_text: STRING; i: INTEGER)
		require else
			i_is_zero: i = 0
		do
			if is_prepended then
				prepend_modifier_list.extend (create{ERT_PREPENDED_ITEM_MODIFIER}.make(attached_ast, item_text, i, counter, match_list))
			else
				prepend_modifier_list.put_front (create{ERT_APPENDED_ITEM_MODIFIER}.make (attached_ast, item_text, i, counter, match_list))
			end
			counter := counter + 1
		end

	insert_right (item_text: STRING; i: INTEGER)
		require else
			i_is_zero: i = 0
		do
			if is_prepended then
				prepend_modifier_list.put_front (create{ERT_PREPENDED_ITEM_MODIFIER}.make(attached_ast, item_text, i, counter, match_list))
			else
				prepend_modifier_list.extend (create{ERT_APPENDED_ITEM_MODIFIER}.make (attached_ast, item_text, i, counter, match_list))
			end
			counter := counter + 1
		end

	replace (item_text: STRING; i: INTEGER)
			-- Not applicable.			
		do
			check
				not_applicable: False
			end
		end

	prepend (item_text: STRING)
		do
			insert_left (item_text, 0)
		end

	append (item_text: STRING)
		do
			insert_right (item_text, 0)
		end

feature -- Modifier register

	remove (i: INTEGER)
			-- Not applicable.
		do
			check
				not_applicable: False
			end
		end

feature -- Status reporting

	is_empty: BOOLEAN
			-- Is current empty?
		do
			Result := prepend_modifier_list.is_empty and append_modifier_list.is_empty
		end

feature{NONE} -- Implementation

	concatenate_modifier_list (dest, sour: like prepend_modifier_list)
			-- Concatenate `sour' to `dest'.
		do
			from
				sour.start
			until
				sour.after
			loop
				dest.extend (sour.item)
				sour.forth
			end
		end

	merge_modifier_list: like prepend_modifier_list
			-- Merge `prepend_modifier_list' and `append_modifier_list'.
		do
			create Result.make
			if is_prepended then
				concatenate_modifier_list (Result, append_modifier_list)
				concatenate_modifier_list (Result, prepend_modifier_list)
			else
				concatenate_modifier_list (Result, prepend_modifier_list)
				concatenate_modifier_list (Result, append_modifier_list)
			end
		end

	compute_modification (a_modifier_list: like prepend_modifier_list)
			-- Computer separators.
		require
			a_modifier_list_not_void: a_modifier_list /= Void
		local
			i, j: INTEGER
			l_modifier: ERT_LIST_ITEM_MODIFIER
		do
			if not a_modifier_list.is_empty then
				if has_separator then
					if is_prepended then
						i := 2
						j := a_modifier_list.count
						a_modifier_list.first.set_is_separator_needed (False)
						a_modifier_list.first.set_arguments (separator, leading_text, trailing_text)
					else
						i := 1
						j := a_modifier_list.count - 1
						a_modifier_list.last.set_is_separator_needed (False)
						a_modifier_list.last.set_arguments (separator, leading_text, trailing_text)
					end
				else
					i := 1
					j := a_modifier_list.count
				end
				from
				until
					i > j
				loop
					l_modifier := a_modifier_list.i_th (i)
					l_modifier.set_is_separator_needed (has_separator)
					l_modifier.set_arguments (separator, leading_text, trailing_text)
					i := i + 1
				end
			end

			if header_text /= Void and header_ast = Void then
				if is_prepended then
				    create {ERT_PREPENDED_ITEM_MODIFIER} l_modifier.make (attached_ast, header_text, i, counter, match_list)
					a_modifier_list.extend (l_modifier)
				else
					create {ERT_APPENDED_ITEM_MODIFIER} l_modifier.make (attached_ast, header_text, i, counter, match_list)
					a_modifier_list.put_front (l_modifier)
				end
				l_modifier.set_is_separator_needed (False)
				l_modifier.set_arguments ("", "", "")
			end

			if footer_text /= Void and footer_ast = Void then
				if is_prepended then
				    create {ERT_PREPENDED_ITEM_MODIFIER} l_modifier.make (attached_ast, footer_text, i, counter, match_list)
					a_modifier_list.put_front (l_modifier)
				else
					create {ERT_APPENDED_ITEM_MODIFIER} l_modifier.make (attached_ast, footer_text, i, counter, match_list)
					a_modifier_list.extend (l_modifier)
				end
				l_modifier.set_is_separator_needed (False)
				l_modifier.set_arguments ("", "", "")
			end
		end

feature{NONE} -- Implementation

	attached_ast: AST_EIFFEL
			-- AST structure to which text of current list is attached.

	prepend_modifier_list: LINKED_LIST [ERT_LIST_ITEM_MODIFIER]
			-- List of regisitered prepend modifiers

	append_modifier_list: LINKED_LIST [ERT_LIST_ITEM_MODIFIER]
			-- List of regisitered append modifiers

	counter: INTEGER
			-- Internal counter for modifier index

	is_prepended: BOOLEAN
			-- Should current be prepended to text of `attached_ast'.
			-- True if it is to be prepended, False if it is to be appended.

invariant
	attached_ast_not_void: attached_ast /= Void
	trailing_text_not_void: trailing_text /= Void
	leading_text_not_void: leading_text /= Void
	separator_not_void: separator /= Void

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software"
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
