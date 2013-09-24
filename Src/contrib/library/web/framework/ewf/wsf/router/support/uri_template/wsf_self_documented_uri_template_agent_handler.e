note
	description: "Summary description for {WSF_SELF_DOCUMENTED_URI_TEMPLATE_AGENT_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_SELF_DOCUMENTED_URI_TEMPLATE_AGENT_HANDLER

inherit
	WSF_URI_TEMPLATE_AGENT_HANDLER
		rename
			make as make_handler
		end

	WSF_SELF_DOCUMENTED_AGENT_HANDLER

create
	make,
	make_with_descriptions,
	make_hidden

feature {NONE} -- Initialization

	make (a_action: like action; a_self_doc: like self_documentation_builder)
			-- <Precursor>
			-- and using `a_self_doc' function to build the `mapping_documentation'.
		do
			set_self_documentation_builder (a_self_doc)
			make_handler (a_action)
		end

	make_with_descriptions (a_action: like action; a_descriptions: ITERABLE [READABLE_STRING_GENERAL])
		do
			across
				a_descriptions as c
			loop
				add_description (c.item)
			end
			make_handler (a_action)
		end

	make_hidden (a_action: like action)
			-- <Precursor>
			-- and using `a_self_doc' function to build the `mapping_documentation'
			-- mark it as `hidden'.
		do
			is_hidden := True
			make (a_action, Void)
		end

note
	copyright: "2011-2013, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Colin Adams, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
