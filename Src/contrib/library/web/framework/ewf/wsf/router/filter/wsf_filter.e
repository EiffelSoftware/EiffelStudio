note
	description: "Objects than can pre-process incoming data and post-process outgoing data."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WSF_FILTER

feature -- Access

	next: detachable WSF_FILTER assign set_next
			-- Next filter

	last: WSF_FILTER
			-- Last filter in the chain following `next'.
		do
			from
				Result := Current
			until
				not attached Result.next as l_next
			loop
				Result := l_next
			end
		ensure
			is_closing: Result /= Void and then Result.next = Void
		end			

feature -- Element change

	set_next (a_next: like next)
			-- Set `next' to `a_next'
		do
			next := a_next
		ensure
			next_set: next = a_next
		end

	append (a_filter: attached like next)
			-- Append `a_filter' to the `last' filter.
		do
			last.set_next (a_filter)
		end

	insert_after (a_filter: attached like next)
			-- Append `a_filter' to the `last' filter.
		local
			f: like next
		do
			f := next
			set_next (a_filter)
			if f /= Void then
				a_filter.append (f)
			end
		end

feature -- Basic operations

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute the filter.
		require
			req_attached: req /= Void
			res_attached: res /= Void
		deferred
		end

feature {NONE} -- Implementation

	execute_next (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute the `next' filter.
		require
			req_attached: req /= Void
			res_attached: res /= Void
		do
			if attached next as n then
				n.execute (req, res)
			end
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
