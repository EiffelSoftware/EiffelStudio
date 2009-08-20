note
	description: "Summary description for {XP_REGION_CHECK_VISITOR}."
	date: "$Date$"
	legal: "See notice at end of class."
	status: "Pre-release"
	revision: "$Revision$"

class
	XP_REGION_CHECK_VISITOR

inherit
	XP_TAG_ELEMENT_VISITOR

create
	make

feature -- Initialization

	make
		do
			all_set := True
		end

feature -- Access

	all_set: BOOLEAN
			-- Are there no undefined regions?

feature {NONE} -- Implementation

	visit_tag_element (a_tag: XP_TAG_ELEMENT)
			-- <Precursor>
		do
		end

	visit_include_tag_element (a_tag: XP_INCLUDE_TAG_ELEMENT)
			-- <Precursor>
		do
		end

	visit_region_tag_element (a_tag: XP_REGION_TAG_ELEMENT)
			-- <Precursor>
		do
			if not a_tag.has_children then
				all_set := False
			end
		end

end
