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
			set_uid_tag_if_not_set(uid, tag)
		end

	visit_include_tag_element (tag: XP_INCLUDE_TAG_ELEMENT)
			-- Precursor
		do
			set_uid_tag_if_not_set(uid, tag)
		end

	visit_region_tag_element (tag: XP_REGION_TAG_ELEMENT)
			-- Precursor
		do
			set_uid_tag_if_not_set(uid, tag)
		end

	set_uid_tag_if_not_set (a_uid: STRING; a_tag: XP_TAG_ELEMENT)
		do
			if (not attached a_tag.controller_id) or a_tag.controller_id.is_empty then
				a_tag.set_controller_id (a_uid)
			end
		end

end
