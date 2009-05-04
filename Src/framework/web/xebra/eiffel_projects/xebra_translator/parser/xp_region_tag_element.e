note
	description: "[
		{XP_REGION_TAG_ELEMENT}.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XP_REGION_TAG_ELEMENT

inherit
	XP_TAG_ELEMENT
		redefine
			accept
			--copy_tag_tree
		end

create
	make

feature -- Initialization



feature -- Access

	set_region (a_region: LIST [XP_TAG_ELEMENT])
			-- Defines the implementation of a region
		do
			children := a_region
		end

	accept (visitor: XP_TAG_ELEMENT_VISITOR)
			-- Element part of the Visitor Pattern
		do
			visitor.visit_region_tag_element (Current)
			from
				children.start
			until
				children.after
			loop
				children.item.accept (visitor)
				children.forth
			end
		end

end
