note
	description: "[
		A {XP_TAG_ELEMENT} which executes an agent on setting an attribute.
		Be aware that the agent is executed but the first time.
	]"
	legal: "See notice at end of class."
	status: "Community Preview 1.0"
	date: "$Date$"
	revision: "$Revision$"

class
	XP_AGENT_TAG_ELEMENT

inherit
	XP_TAG_ELEMENT
		redefine
			extend_attribute,
			copy_self,
			extend_attribute_for_copy
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

feature -- Access

		copy_self: XP_TAG_ELEMENT
				-- <Precursor>
			local
				l_agent_tag: XP_AGENT_TAG_ELEMENT
			do
				create {XP_AGENT_TAG_ELEMENT} l_agent_tag.make_with_additional_arguments (namespace, id, class_name, debug_information, attribute_handler)
				Result := l_agent_tag
			end

		extend_attribute (a_local_part: STRING; a_value: XP_TAG_ARGUMENT)
				-- <Precursor>
			require else
				a_value_attached: a_value /= Void
				a_local_part_attached: a_local_part /= Void
			do
				Precursor  (a_local_part, a_value)
				if attached attribute_handler as l_attribute_handler then
					l_attribute_handler.call ([a_local_part, a_value])
				end
			end

		extend_attribute_for_copy (a_id: STRING; a_value: XP_TAG_ARGUMENT)
				-- <Precursor>
			do
				-- Do nothing
			end

invariant

	attribute_handler_attached: attached attribute_handler

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
