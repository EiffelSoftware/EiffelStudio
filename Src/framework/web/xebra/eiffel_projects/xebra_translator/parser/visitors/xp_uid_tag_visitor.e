note
	description: "[
		{XP_UID_TAG_VISITOR}.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XP_UID_TAG_VISITOR

inherit
	XP_TAG_ELEMENT_VISITOR

create
	make_with_uid

feature -- Initialization

	make_with_uid (a_uid: STRING)
		do
			uid := a_uid
		end

feature -- Access

	uid: STRING

feature -- Access

	visit_tag_element (tag: XP_TAG_ELEMENT)
			-- Precursor
		do
			tag.set_controller_id (uid)
		end

	visit_include_tag_element (tag: XP_INCLUDE_TAG_ELEMENT)
			-- Precursor
		do
			tag.set_controller_id (uid)
		end

	visit_region_tag_element (tag: XP_REGION_TAG_ELEMENT)
			-- Precursor
		do
			tag.set_controller_id (uid)
		end


end
