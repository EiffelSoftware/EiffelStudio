note
	description: "Summary description for {WSF_ROUTING_CONDITION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WSF_ROUTING_CONDITION

feature -- Status report

	accepted (req: WSF_REQUEST): BOOLEAN
			-- Does `req` satisfy Current condition?
		deferred
		end

feature -- Factory

	conjuncted alias "and" (cond: WSF_ROUTING_CONDITION): WSF_ROUTING_AND_CONDITION
		do
			create Result.make (Current, cond)
		end

	disjuncted alias "or" (cond: WSF_ROUTING_CONDITION): WSF_ROUTING_OR_CONDITION
		do
			create Result.make (Current, cond)
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Colin Adams, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
