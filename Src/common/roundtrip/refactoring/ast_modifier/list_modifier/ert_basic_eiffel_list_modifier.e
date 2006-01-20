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
