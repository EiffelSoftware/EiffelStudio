indexing
	description: "Object that represents an existing item (which appears before any modification) in EIFFEL_LIST"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ERT_EXISTING_ITEM_MODIFIER

inherit
	ERT_LIST_ITEM_MODIFIER

create
	make

feature -- Initialization

	make (a_item_ast: like item_ast; a_separator_ast: like separator_ast;  a_owner: INTEGER; a_index: INTEGER; a_list: like match_list) is
			-- Initialize instance.
		require
			ast_not_void: a_item_ast /= Void
		do
			item_ast := a_item_ast
			separator_ast := a_separator_ast
			initialize (Void, a_owner, a_index, 0, a_list)
		ensure
			item_ast_set: item_ast = a_item_ast
			separator_ast_set: separator_ast = a_separator_ast
		end

feature -- Applicability

	can_apply: BOOLEAN is
			-- Can current modifier be applied?
		do
			Result := True
			if has_text_changed then
				Result := item_ast.can_replace_text (match_list)
			end
			if is_separator_needed then
				if not already_has_separator then
					Result := item_ast.can_append_text (match_list)
				end
			else
				if already_has_separator then
					Result := separator_ast.can_replace_text (match_list)
				end
			end
		end

feature -- Operation

	apply is
			-- Apply current modifier.
		do
			if has_text_changed then
				item_ast.replace_text (text, match_list)
			end
			if is_separator_needed then
				if not already_has_separator then
					item_ast.append_text (separator, match_list)
				end
			else
				if already_has_separator then
					separator_ast.replace_text ("", match_list)
				end
			end
			applied := True
		end

feature -- Setting

	set_text (a_text: STRING) is
			-- Set `text' with `a_text'.
			-- `a_text' is empty means remove current item.
		require
			a_text_not_void: a_text /= Void
		do
			text := a_text.twin
		ensure
			text_set: text.is_equal (a_text)
		end

feature	-- Status reporting

	has_text_changed: BOOLEAN is
			-- Has text changed?
		do
			Result := text /= Void
		end

	already_has_separator: BOOLEAN is
			-- Does current item already has a separator?
		do
			Result := separator_ast /= Void
		end

	is_removed: BOOLEAN is
			-- Is current item removed?
		do
			Result := has_text_changed and then text.is_empty
		end

feature

	item_ast: AST_EIFFEL
			-- Item AST node

	separator_ast: AST_EIFFEL
			-- Separator AST node, if any

invariant
	item_ast_not_void: item_ast /= Void

end
