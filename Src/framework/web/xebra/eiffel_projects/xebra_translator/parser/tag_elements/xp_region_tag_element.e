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
			accept,
			copy_self
		end

create
	make

feature -- Initialization

feature -- Access

	copy_self: XP_TAG_ELEMENT
		do
			create {XP_REGION_TAG_ELEMENT} Result.make (namespace, id, class_name, debug_information)
		end


	set_region (a_region: LIST [XP_TAG_ELEMENT])
			-- Defines the implementation of a region
		do
			children := a_region
		end

	accept (visitor: XP_TAG_ELEMENT_VISITOR)
			-- Element part of the Visitor Pattern
		do
			visitor.visit_region_tag_element (Current)
			accept_children (visitor)
		end

end
