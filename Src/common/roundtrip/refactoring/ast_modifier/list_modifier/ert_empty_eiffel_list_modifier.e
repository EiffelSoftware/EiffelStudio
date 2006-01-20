indexing
	description: "[
					Object that for appending items to an empty EIFFEL_LIST.
					Only `append_last_item' is effective because originally, current is an empty list.
					]"
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
	make (a_attached_ast: AST_EIFFEL; a_prepend: BOOLEAN; a_list: like match_list) is
			-- Initialize instance.
			-- `a_attached_ast' is the AST node to whose text current is to be prepended (if `a_prepend' is Ture) or
			-- to be appended (if `a_prepend' is False).
			-- `a_list' is match list needed for roundtrip operations.
		require
			a_attached_ast_not_void: a_attached_ast /= Void
			a_list_not_void: a_list /= Void
		do
			attached_ast := a_attached_ast
			create modifier_list.make
			header := ""
			footer := ""
			match_list := a_list
			is_prepended := a_prepend
			counter := 1
			modifier_list.extend (create{ERT_EXISTING_ITEM_MODIFIER}.make (attached_ast, Void, 0, counter, a_list))
			counter := counter + 1
		ensure
			a_attached_ast_set: attached_ast = a_attached_ast
			header_set: header.is_equal ("")
			footer_set: footer.is_equal ("")
			is_prepended_set: is_prepended = a_prepend
		end

feature -- Applicability

	can_apply: BOOLEAN is
			-- Can current modifier be applied?
		do
			if is_prepended then
				Result := attached_ast.can_prepend_text (match_list)
			else
				Result := attached_ast.can_append_text (match_list)
			end
		end

	apply is
			-- Apply current modifier.
		local
			i, j, k: INTEGER
			l_cnt: INTEGER
			l_modifier: ERT_LIST_ITEM_MODIFIER
		do
			if is_prepended then
				if not footer.is_empty then
					attached_ast.prepend_text (footer, match_list)
				end
			else
				if not header.is_empty then
					attached_ast.append_text (header, match_list)
				end
			end

			from
				l_cnt := modifier_list.count - 1
				k := 1
				if is_prepended then
					i := l_cnt
					j := -1
				else
					i := 2
					j := 1
				end
			until
				k > l_cnt
			loop
				l_modifier := modifier_list.i_th (i)
				if has_separator and then k < l_cnt then
					modifier_list.i_th (i).set_is_separator_needed (True)
				else
					modifier_list.i_th (i).set_is_separator_needed (False)
				end
				modifier_list.i_th (i).set_arguments (separator, leading_text, trailing_text)
				l_modifier.apply
				i := i + j
				k := k + 1
			end

			if is_prepended then
				if not header.is_empty then
					attached_ast.prepend_text (header, match_list)
				end
			else
				if not footer.is_empty then
					attached_ast.append_text (footer, match_list)
				end
			end
			applied := True
		end

feature

	prepend_item (item_text: STRING; i: INTEGER) is
			-- Not applicable.
		do
		end

	append_item (item_text: STRING; i: INTEGER) is
			-- Not applicable.
		do
		end

	replace_item (item_text: STRING; i: INTEGER) is
			-- Not applicable.
		do
		end

	remove_item (i: INTEGER) is
			-- Not applicable.
		do
		end

	prepend_first_item (item_text: STRING) is
			-- Not applicable.
		do
		end

	append_last_item (item_text: STRING) is
			-- Register a append operation on the last item in `eiffel_list'.
		local
			l_modifier: ERT_ADDED_ITEM_MODIFIER
		do
			if is_prepended then
				l_modifier := create {ERT_PREPENDED_ITEM_MODIFIER}.make (attached_ast, item_text, 0, counter, match_list)
			else
				l_modifier := create {ERT_APPENDED_ITEM_MODIFIER}.make (attached_ast, item_text, 0, counter, match_list)
			end
			counter := counter + 1
			modifier_list.extend (l_modifier)
		end

feature -- Status reporting

	is_empty: BOOLEAN is
			-- Is current empty?
		do
			Result := modifier_list.count = 1
		end

feature -- Access

	header: STRING
			-- Header text which appears before list items

	footer: STRING
			-- Footer text which appears after list items

	set_header (a_header: STRING) is
			-- Set `header' with `a_header'.
		do
			if a_header = Void then
				header := ""
			else
				header := a_header.twin
			end
		ensure
			header_set: (a_header = Void implies header.is_empty) and (a_header /= Void implies header.is_equal (a_header))
		end

	set_footer (a_footer: STRING) is
			-- Set `footer' with `a_footer'.
		do
			if a_footer = Void then
				footer := ""
			else
				footer := a_footer.twin
			end
		ensure
			footer_set: (a_footer = Void implies footer.is_empty) and (a_footer /= Void implies footer.is_equal (a_footer))
		end

feature{NONE} -- Implementation

	attached_ast: AST_EIFFEL
			-- AST structure to which text of current list is attached.

	modifier_list: SORTED_TWO_WAY_LIST [ERT_LIST_ITEM_MODIFIER]
			-- List of regisitered modifiers

	counter: INTEGER
			-- Internal counter for modifier index

	is_prepended: BOOLEAN
			-- Should current be prepended to text of `attached_ast'.
			-- True if it is to be prepended, False if it is to be appended.

invariant
	attached_ast_not_void: attached_ast /= Void
	modifier_list_not_void: modifier_list /= Void
	header_not_void: header /= Void
	footer_not_void: footer /= Void

end
