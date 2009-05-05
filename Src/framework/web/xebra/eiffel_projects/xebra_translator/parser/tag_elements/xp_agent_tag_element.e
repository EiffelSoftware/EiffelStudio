note
	description: "[
		{XP_AGENT_TAG_ELEMENT}.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XP_AGENT_TAG_ELEMENT

inherit
	XP_TAG_ELEMENT
		rename
			make as base_make
		redefine
			put_attribute
		end

create
	make

feature -- Initialization

	make (a_prefix, a_local_part, a_class_name, a_debug_information: STRING; a_attribute_handler: PROCEDURE [ANY, TUPLE [STRING, STRING]])
		require
			a_attribute_handler_valid: a_attribute_handler /= Void
		do
			base_make (a_prefix, a_local_part, a_class_name, a_debug_information)
			attribute_handler := a_attribute_handler
		end

feature -- Access

		attribute_handler: PROCEDURE [ANY, TUPLE [STRING, STRING]]
				-- Handles the incoming attributes

		put_attribute (a_local_part: STRING; a_value: STRING)
				-- <Precursor>
			do
				attribute_handler.call ([a_local_part, a_value])
			end

end
