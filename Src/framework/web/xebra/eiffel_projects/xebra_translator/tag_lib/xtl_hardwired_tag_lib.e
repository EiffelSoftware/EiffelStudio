note
	description: "[
		{XTL_HARDWIRED_TAG_LIB}.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XTL_HARDWIRED_TAG_LIB

inherit
	XTL_TAG_LIBRARY
		redefine
			create_tag
		end

create
	make_hard_wired

feature -- Initialization

	make_hard_wired (a_id: STRING)
		require
			a_id_valid: not a_id.is_empty
		do
			make
			id := a_id
		end

feature {NONE} -- Access

feature -- Access

	create_tag (a_prefix, a_local_part, a_class_name, a_debug_information: STRING): XP_TAG_ELEMENT
			-- Creates the appropriate XP_TAG_ELEMENT
		do
			if attached {XTL_AGENT_TAG_DESCRIPTION} tags [a_local_part] as tag then
				create {XP_AGENT_TAG_ELEMENT} Result.make (a_prefix, a_local_part, a_class_name, a_debug_information, tag.attribute_handler)
			else
				create Result.make (a_prefix, a_local_part, a_class_name, a_debug_information)
			end
		end

feature -- Query

end
