note
	description: "[
				Handler that can also play the role of a filter, i.e. 
				than can pre-process incoming data and post-process outgoing data.
		]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WSF_FILTER_HANDLER [G -> WSF_HANDLER]

inherit
	WSF_HANDLER

feature -- Access

	next: detachable G
			-- Next handler

feature -- Element change

	set_next (a_next: like next)
			-- Set `next' to `a_next'
		do
			next := a_next
		ensure
			next_set: next = a_next
		end

note
	copyright: "2011-2013, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
