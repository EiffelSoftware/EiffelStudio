indexing
	description: "Object that represents a prepended item in EIFFEL_LIST"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ERT_PREPENDED_ITEM_MODIFIER

inherit
	ERT_ADDED_ITEM_MODIFIER

create
	make

feature -- Initialization

	make (ast: like attached_ast; a_text: STRING; a_owner: INTEGER; a_index: INTEGER; a_list: like match_list) is
			-- Initialize instance.
		require
			ast_not_void: ast /= Void
		do
			attached_ast := ast
			initialize (a_text, a_owner, a_index, -1, a_list)
		ensure
			attached_ast_set: attached_ast = ast
		end

feature -- Applicability

	can_apply: BOOLEAN is
			-- Can current modifier be applied?
		do
			Result := attached_ast.can_prepend_text (match_list)
		end

feature -- Operation

	apply is
			-- Apply current modifier.
		local
			l_text: STRING
		do
			create l_text.make (text.count + trailing_text.count + leading_text.count + separator.count)
			l_text.append (text)
			if is_separator_needed then
				l_text.append (separator)
			end
			l_text.append (trailing_text)
			l_text.append (leading_text)
			attached_ast.prepend_text (l_text, match_list)
			applied := True
		end

end
