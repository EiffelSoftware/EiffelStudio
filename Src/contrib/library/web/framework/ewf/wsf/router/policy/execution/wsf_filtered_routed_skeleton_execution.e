note
	description: "[
			Skeleton execution based on filtered routed execution.
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WSF_FILTERED_ROUTED_SKELETON_EXECUTION

inherit
	WSF_ROUTED_SKELETON_EXECUTION
		undefine
			execute
		redefine
			initialize
		end

	WSF_FILTERED_EXECUTION
		redefine
			initialize
		end

	WSF_FILTER
		rename
			execute as filter_execute
		end

feature {NONE} -- Initialize

	initialize
		local
			f: like filter
		do
			Precursor {WSF_ROUTED_SKELETON_EXECUTION}
			Precursor {WSF_FILTERED_EXECUTION}
				-- Current is a WSF_FILTER as well in order to call the router
				-- let's add Current at the end of the filter chain.
			from
				f := filter
			until
				not attached f.next as l_next
			loop
				f := l_next
			end
			f.set_next (Current)
		end

feature -- Execute Filter

	filter_execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute the filter.
		do
			execute_skeleton (req, res)
		end

note
	copyright: "2011-2015, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Colin Adams, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
