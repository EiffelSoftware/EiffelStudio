note
	description: "[
		{XP_CONTROLLER_SET_VISITOR}.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XP_CONTROLLER_SET_VISITOR

inherit
	XP_TAG_ELEMENT_VISITOR

create
	make

feature -- Initialization

	make (a_controller_id: STRING)
		do
			controller_id := a_controller_id
		end

feature -- Access

	controller_id: STRING
			-- Id of the controller

	visit_tag_element (tag: XP_TAG_ELEMENT)
			-- Precursor
		do
			set_controller (tag)
		end

	visit_include_tag_element (tag: XP_INCLUDE_TAG_ELEMENT)
			-- Precursor
		do
			set_controller (tag)
		end

	visit_region_tag_element (tag: XP_REGION_TAG_ELEMENT)
			-- Precursor
		do
			set_controller (tag)
		end

	set_controller (tag: XP_TAG_ELEMENT)
			-- Sets the controller id.
		do
			tag.set_controller_id (controller_id)
		ensure
			controller_has_been_set: tag.controller_id /= Void
		end

end
