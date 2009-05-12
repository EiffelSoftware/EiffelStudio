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
		redefine
			put_attribute,
			copy_self
		end

create
	make_with_additional_arguments, make

feature -- Initialization

	make_with_additional_arguments (a_namespace: STRING; a_id: STRING; a_class_name: STRING; a_debug_information: STRING; a_attribute_handler: PROCEDURE [ANY, TUPLE [STRING, STRING]])
		do
			make (a_namespace, a_id, a_class_name, a_debug_information)
			attribute_handler := a_attribute_handler
		end

feature {XP_TAG_ELEMENT}  -- Access

		attribute_handler: PROCEDURE [ANY, TUPLE [STRING, STRING]]
				-- Handles the incoming attributes

feature -- Access

		copy_self: XP_TAG_ELEMENT
			do
				create {XP_AGENT_TAG_ELEMENT} Result.make_with_additional_arguments (namespace, id, class_name, debug_information, attribute_handler)
			end

		put_attribute (a_local_part: STRING; a_value: STRING)
				-- <Precursor>
			do
				Precursor  (a_local_part, a_value)
				attribute_handler.call ([a_local_part, a_value])
			end

end
