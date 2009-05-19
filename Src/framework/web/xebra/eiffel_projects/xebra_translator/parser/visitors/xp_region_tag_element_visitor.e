note
	description: "[
		Replaces {XP_REGION_TAG_ELEMENT} of a template by the implementation stored in `regions'.
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
		require
			a_regions_attached:
		do
			regions := a_regions
		ensure
			regions_attached: attached regions
			regions_set: regions = a_regions
		end

feature {NONE}

	regions: HASH_TABLE [LIST [XP_TAG_ELEMENT], STRING]
			-- Regions of a template

feature -- Access

	visit_tag_element (a_tag: XP_TAG_ELEMENT)
			-- Precursor
		do
			-- Do nothing
		end

	visit_include_tag_element (a_tag: XP_INCLUDE_TAG_ELEMENT)
			-- Precursor
		do
			-- Do nothing
		end

	visit_region_tag_element (a_tag: XP_REGION_TAG_ELEMENT)
			-- Precursor
		do
			if attached regions [a_tag.retrieve_value ("id")] as region then
				a_tag.set_region (region)
				regions [a_tag.retrieve_value ("id")] := Void
			end
		end

end
