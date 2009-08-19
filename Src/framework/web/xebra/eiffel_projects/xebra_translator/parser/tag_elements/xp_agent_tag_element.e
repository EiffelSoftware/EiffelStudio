note
	description: "[
		A {XP_TAG_ELEMENT} which executes an agent on setting an attribute. Be aware that the agent is executed but the first time.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
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

	make_with_additional_arguments (a_namespace: STRING; a_id: STRING; a_class_name: STRING; a_debug_information: STRING; a_attribute_handler: detachable PROCEDURE [ANY, TUPLE [STRING, XP_TAG_ARGUMENT]])
			-- <Precursor>
			-- `a_attribute_handler': Handles attributes passed to this tag
		require
			a_attribute_handler_attached: attached a_attribute_handler
		do
			make (a_namespace, a_id, a_class_name, a_debug_information)
			attribute_handler := a_attribute_handler
		ensure
			attribute_handler_attached: attached attribute_handler
			attribute_handler_set: attribute_handler = a_attribute_handler
		end

feature {XP_TAG_ELEMENT}  -- Access

		attribute_handler: detachable PROCEDURE [ANY, TUPLE [STRING, XP_TAG_ARGUMENT]]
				-- Handles the incoming attributes

		executed: BOOLEAN assign set_executed
				-- Has the attribute_handler been executed?

feature {XP_TAG_ELEMENT} -- Status setting

		set_executed (a_executed: BOOLEAN)
				-- `a_executed': Has the attribute_handler been executed yet?
			do
				executed := a_executed
			ensure
				executed_set: executed = a_executed
			end

feature -- Access

		copy_self: XP_TAG_ELEMENT
				-- <Precursor>
			local
				l_agent_tag: XP_AGENT_TAG_ELEMENT
			do
				create {XP_AGENT_TAG_ELEMENT} l_agent_tag.make_with_additional_arguments (namespace, id, class_name, debug_information, attribute_handler)
				l_agent_tag.executed := executed
				Result := l_agent_tag
			end

		put_attribute (a_local_part: STRING; a_value: XP_TAG_ARGUMENT)
				-- <Precursor>
			require else
				a_value_attached: a_value /= Void
				a_local_part_attached: a_local_part /= Void
			do
				Precursor  (a_local_part, a_value)
				if not executed and attached attribute_handler as l_attribute_handler then
					l_attribute_handler.call ([a_local_part, a_value])
					executed := True
				end
			end

invariant

	attribute_handler_attached: attached attribute_handler

end
