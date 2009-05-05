note
	description: "[
		{XP_REGION_TAG_ELEMENT_VISITOR}.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XP_REGION_TAG_ELEMENT_VISITOR

inherit
	XP_TAG_ELEMENT_VISITOR

create
	make

feature -- Initialization

	make (a_regions: HASH_TABLE [LIST [XP_TAG_ELEMENT], STRING])
			-- `regions': Mapping between region name and tag tree
		do
			regions := a_regions
		end

feature {NONE}

	regions: HASH_TABLE [LIST [XP_TAG_ELEMENT], STRING]
			-- Regions of a template

feature -- Access

	visit_tag_element (tag: XP_TAG_ELEMENT)
			-- Precursor
		do
			-- Do nothing
		end

	visit_include_tag_element (tag: XP_INCLUDE_TAG_ELEMENT)
			-- Precursor
		do
			-- Do nothing
		end

	visit_region_tag_element (tag: XP_REGION_TAG_ELEMENT)
			-- Precursor
		do
			if attached regions [tag.retrieve_value ("id")] as region then
				tag.set_region (region)
				regions [tag.retrieve_value ("id")] := Void
			end
		end

end
