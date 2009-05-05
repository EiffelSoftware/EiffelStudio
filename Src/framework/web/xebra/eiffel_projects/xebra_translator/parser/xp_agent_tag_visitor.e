note
	description: "[
		{XP_AGENT_TAG_VISITOR}.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XP_AGENT_TAG_VISITOR

inherit
	XP_TAG_ELEMENT_VISITOR

create
	make

feature -- Initialization

	make (a_tag_element_agent, a_include_tag_element_agent, a_region_tag_element_agent: PROCEDURE [ANY, TUPLE [XP_TAG_ELEMENT]])
			-- `regions': Mapping between region name and tag tree
		do
		end

feature{NONE} -- Access

		tag_element_agent, include_tag_element_agent, region_tag_element_agent: PROCEDURE [ANY, TUPLE [XP_TAG_ELEMENT]]

feature -- Access

	visit_tag_element (tag: XP_TAG_ELEMENT)
			-- Precursor
		do
			tag_element_agent.call ([tag])
		end

	visit_include_tag_element (tag: XP_INCLUDE_TAG_ELEMENT)
			-- Precursor
		do
			include_tag_element_agent.call ([tag])
		end

	visit_region_tag_element (tag: XP_REGION_TAG_ELEMENT)
		do
			region_tag_element_agent.call ([tag])
		end

end
