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

	footer_text: STRING
			-- Footer text		

feature -- Item modification

	prepend_item (item_text: STRING; i: INTEGER) is
			-- Register a prepend operation on `i'-th item in `eiffel_list'.
		require
			item_text_not_void: item_text /= Void
			item_text_not_empty: not item_text.is_empty
		deferred
		end

	append_item (item_text: STRING; i: INTEGER) is
			-- Register an append operation on `i'-th item in `eiffel_list'.
		require
			item_text_not_void: item_text /= Void
			item_text_not_empty: not item_text.is_empty
		deferred
		end

	replace_item (item_text: STRING; i: INTEGER) is
			-- Register a replace operation on `i'-th item in `eiffel_list'.
		require
			item_text_not_void: item_text /= Void
			item_text_not_empty: not item_text.is_empty
		deferred
		end

	remove_item (i: INTEGER) is
			-- Register a remove operation on `i'-th item in `eiffel_list'.
		deferred
		end

	prepend_first_item (item_text: STRING) is
			-- Register a prepend operation on the first item in `eiffel_list'.
		require
			item_text_not_void: item_text /= Void
			item_text_not_empty: not item_text.is_empty
		deferred
		end

	append_last_item (item_text: STRING) is
			-- Register a append operation on the last item in `eiffel_list'.
		require
			item_text_not_void: item_text /= Void
			item_text_not_empty: not item_text.is_empty
		deferred
		end

feature -- Status reporting

	is_empty: BOOLEAN is
			-- Is current empty?
		deferred
		end

end
