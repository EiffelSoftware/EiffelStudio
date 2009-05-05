note
	description: "[
		{XP_TAG_ELEMENT_VISITOR}.
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XP_TAG_ELEMENT_VISITOR

feature -- Initialization
feature -- Access

	visit_tag_element (tag: XP_TAG_ELEMENT)
			-- Visits a {XP_TAG_ELEMENT}. Part of the Visit Pattern
		deferred
		end

	visit_include_tag_element (tag: XP_INCLUDE_TAG_ELEMENT)
			-- Visits a {XP_INCLUDE_TAG_ELEMENT}. Part of the Visit Pattern
		deferred
		end

	visit_region_tag_element (tag: XP_REGION_TAG_ELEMENT)
			-- Visits a {XP_REGION_TAG_ELEMENT}. Part of the Visit Pattern
		deferred
		end

end
