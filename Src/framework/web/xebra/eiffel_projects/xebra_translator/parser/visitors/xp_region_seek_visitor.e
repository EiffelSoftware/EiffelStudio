note
	description: "[
		{XP_REGION_SEEK_VISITOR}.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XP_REGION_SEEK_VISITOR

inherit
	XP_TAG_ELEMENT_VISITOR
create
	make

feature -- Initialization

	make (a_region: STRING)
		do
			region := a_region
			current_template := ""
			template := ""
		end

feature {NONE} -- Access

	current_template: STRING
			-- current enclosing template of an include

	region: STRING
			-- The region to search for

feature -- Access

	template: STRING
			-- The found template

	visit_tag_element (tag: XP_TAG_ELEMENT)
			-- Precursor
		do
		end

	visit_include_tag_element (tag: XP_INCLUDE_TAG_ELEMENT)
			-- Precursor
		do
			current_template := tag.retrieve_value ("template")
		end

	visit_region_tag_element (tag: XP_REGION_TAG_ELEMENT)
			-- Precursor
		do
			if region.is_equal (tag.retrieve_value ("id")) then
				template := current_template
			end
		end

end
