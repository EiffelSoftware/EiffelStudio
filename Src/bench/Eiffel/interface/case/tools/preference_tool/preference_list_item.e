indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PREFERENCE_LIST_ITEM

inherit
	EV_TREE_ITEM

creation
	make_with_element

feature -- Initialization

	make_with_element(par: EV_TREE_ITEM_HOLDER; a_category: RESOURCE_CATEGORY) is
			-- Initialize
		require
			parent_exists: par /= Void
			category_exists: a_category /= Void
		do
			make_with_text(par,a_category.description)
			category := a_category
		end

feature -- Access

	category: RESOURCE_CATEGORY

invariant
	PREFERENCE_LIST_ITEM_not_void: category /= Void
end -- class PREFERENCE_LIST_ITEM
