indexing
	description: "Tree Item which describes a linkable."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	LINKABLE_TREE_ITEM

inherit
	EV_TREE_ITEM

creation
	make_with_linkable

feature -- Initialization

	make_with_linkable ( par: EV_TREE_ITEM_HOLDER;link: LINKABLE_DATA;pix: EV_PIXMAP)  is
			-- Initialize
		require
			parent_exists: par /= Void
			linkable_exists: link /= Void
		do
			--make_with_all(par,link.name, pix)
			if link /= Void then
				make_with_text (par, link.name)
				linkable := link
			end
		end

feature -- Access

	linkable: LINKABLE_DATA

end -- class LINKABLE_TREE_ITEM
