indexing
	description: "Object that represents an added item in EIFFEL_LIST"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ERT_ADDED_ITEM_MODIFIER

inherit
	ERT_LIST_ITEM_MODIFIER
		redefine
			has_text_changed, is_removed
		end

feature

	attached_ast: AST_EIFFEL
			-- AST node to which current modification is attached

feature	-- Status reporting

	has_text_changed: BOOLEAN is True

	is_removed: BOOLEAN is False

invariant

	attached_ast_not_void: attached_ast /= Void

end
