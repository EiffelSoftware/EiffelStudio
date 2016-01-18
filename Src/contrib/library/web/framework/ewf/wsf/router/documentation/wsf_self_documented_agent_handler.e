note
	description: "[
					Interface defining a self documented handler using a function
					to build the `mapping_documentation'
				]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WSF_SELF_DOCUMENTED_AGENT_HANDLER

inherit
	WSF_SELF_DOCUMENTED_HANDLER

feature -- Access

	is_hidden: BOOLEAN
			-- Is hidden from self documentation?

	descriptions: detachable ARRAYED_LIST [READABLE_STRING_GENERAL]

	self_documentation_builder: detachable FUNCTION [WSF_ROUTER_MAPPING, detachable WSF_REQUEST_METHODS, WSF_ROUTER_MAPPING_DOCUMENTATION]
			-- Function building the `mapping_documentation'.

feature -- Change

	add_description (d: READABLE_STRING_GENERAL)
		local
			lst: like descriptions
		do
			lst := descriptions
			if lst = Void then
				create lst.make (1)
				descriptions := lst
			end
			lst.force (d)
		end

	set_self_documentation_builder (fct: like self_documentation_builder)
			-- Set `self_documentation_builder' to `fct'.
		do
			self_documentation_builder := fct
		end

feature -- Documentation

	mapping_documentation (m: WSF_ROUTER_MAPPING; a_request_methods: detachable WSF_REQUEST_METHODS): WSF_ROUTER_MAPPING_DOCUMENTATION
			-- <Precursor>
		do
			if attached self_documentation_builder as fct then
				Result := fct.item ([m, a_request_methods])
			else
				create Result.make (m)
			end
			if attached descriptions as l_descriptions then
				across
					l_descriptions as c
				loop
					Result.add_description (c.item)
				end
			end
			if is_hidden then
				Result.set_is_hidden (True)
			end
		end

note
	copyright: "2011-2016, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Colin Adams, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
