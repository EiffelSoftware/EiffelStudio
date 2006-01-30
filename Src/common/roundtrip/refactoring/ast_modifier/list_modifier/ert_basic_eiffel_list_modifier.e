indexing
	description: "EIFFEL_LIST modifier"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ERT_BASIC_EIFFEL_LIST_MODIFIER

inherit
	ERT_AST_MODIFIER

	ERT_EIFFEL_LIST_ITEM_ARGUMENTS

feature -- Header/footer

	set_header_text (a_text: STRING) is
			-- Set header text of the EIFFEL_LIST node.
			-- `a_text' is empty means remove header from current node.	
		do
			header_text := a_text
		end

	set_footer_text (a_text: STRING) is
			-- Set footer text of the EIFFEL_LIST node.
			-- `a_text' is empty means remove footer from current node.	
		do
			footer_text := a_text
		end

	set_header_ast (ast: AST_EIFFEL) is
			-- Set `header_ast' with `ast'.
		do
			header_ast := ast
		ensure
			header_ast_set: header_ast = ast
		end

	set_footer_ast (ast: AST_EIFFEL) is
			-- Set `footer_ast' with `ast'.
		do
			footer_ast := ast
		ensure
			footer_ast_set: footer_ast = ast
		end

	header_ast: AST_EIFFEL
			-- AST node of header of `eiffel_list'.

	footer_ast: AST_EIFFEL
			-- AST node of footer of `eiffel_list'.

	header_text: STRING
			-- Header text
			-- For example, in the following code
			--
			-- 		indexing
			--			description: "demo"
			--			author: ""
			--
			-- "indexing" is header text.
			-- And there is no footer text here.

	footer_text: STRING
			-- Footer text		
			-- For example, in the following code
			--
			-- feature {CLASS_A, CLASS_B}
			--
			-- "}" is footer text.
			-- And "{" is header text.

feature -- Item modification

	insert_left (item_text: STRING; i: INTEGER) is
			-- Register a left-insertion operation on `i'-th item in `eiffel_list'.
			-- e.g. `item_text' will be inserted before `i'-th item.
		require
			item_text_not_void: item_text /= Void
			item_text_not_empty: not item_text.is_empty
		deferred
		end

	insert_right (item_text: STRING; i: INTEGER) is
			-- Register an right-insertion operation on `i'-th item in `eiffel_list'.
			-- e.g. `item_text' will be inserted after `i'-th item.			
		require
			item_text_not_void: item_text /= Void
			item_text_not_empty: not item_text.is_empty
		deferred
		end

	replace (item_text: STRING; i: INTEGER) is
			-- Register a replace operation on `i'-th item in `eiffel_list'.
		require
			item_text_not_void: item_text /= Void
			item_text_not_empty: not item_text.is_empty
		deferred
		end

	remove (i: INTEGER) is
			-- Register a remove operation on `i'-th item in `eiffel_list'.
		deferred
		end

	prepend (item_text: STRING) is
			-- Register a prepend operation on `eiffel_list'.
			-- e.g. `item_text' will be inserted before the first item.			
		require
			item_text_not_void: item_text /= Void
			item_text_not_empty: not item_text.is_empty
		deferred
		end

	append (item_text: STRING) is
			-- Register a append operation on  `eiffel_list'.
			-- e.g. `item_text' will be inserted after the last item.
		require
			item_text_not_void: item_text /= Void
			item_text_not_empty: not item_text.is_empty
		deferred
		end

	merge_left (other_eiffel_list: EIFFEL_LIST [AST_EIFFEL]; other_match_list: like match_list) is
			-- Merge `other_eiffel_list' into current structure before the first item.
		require
			other_eiffel_list_not_void: other_eiffel_list /= void
			other_match_list_not_void: other_match_list /= Void
		local
			i: INTEGER
			l_count: INTEGER
		do
			if not other_eiffel_list.is_empty then
				from
					l_count := other_eiffel_list.count
					i := l_count
				until
					i = 0
				loop
					prepend (other_eiffel_list.i_th (i).text (other_match_list))
					i := i - 1
				end
			end
		end

	merge_right (other_eiffel_list: EIFFEL_LIST [AST_EIFFEL]; other_match_list: like match_list) is
			-- Merge `other_eiffel_list' into current structure after the last item.
		require
			other_eiffel_list_not_void: other_eiffel_list /= void
		local
			i: INTEGER
			l_count: INTEGER
		do
			if not other_eiffel_list.is_empty then
				from
					l_count := other_eiffel_list.count
					i := 1
				until
					i > l_count
				loop
					append (other_eiffel_list.i_th (i).text (other_match_list))
					i := i + 1
				end
			end
		end

feature -- Status reporting

	is_empty: BOOLEAN is
			-- Is current empty?
		deferred
		end

feature{NONE} -- Implementation

	match_list: LEAF_AS_LIST
			-- Match list used by roundtrip

invariant
	match_list_not_void: match_list /= Void


end
