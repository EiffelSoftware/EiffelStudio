note
	description: "[
		Sets all the uids of the {XP_TAG_ELEMENT} tree.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
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
			-- `a_uid': The unique controller identifier
		require
			a_uid_valid: attached a_uid and not a_uid.is_empty
		do
			uid := a_uid
		ensure
			uid_attached: attached uid
			uid_set: uid = a_uid
		end

feature -- Access

	uid: STRING
		-- The unique controller identifier

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
		require
			a_uid_valid: attached a_uid and not a_uid.is_empty
		do
			if (not attached a_tag.controller_id) or a_tag.controller_id.is_empty then
				a_tag.set_controller_id (a_uid)
			end
		end

invariant
	uid_attached: attached uid

end
