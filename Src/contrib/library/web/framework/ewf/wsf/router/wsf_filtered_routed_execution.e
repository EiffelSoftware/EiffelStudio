note
	description: "[
			Execution which is first filtered, and then pass to the router
		]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WSF_FILTERED_ROUTED_EXECUTION

inherit
	WSF_FILTERED_EXECUTION
		redefine
			initialize
		end

	WSF_ROUTED_EXECUTION
		undefine
			execute
		redefine
			initialize
		end

	WSF_FILTER
		rename
			execute as filter_execute
		end

feature {NONE} -- Initialize

	initialize
		do
			create_filtered_router
			initialize_filtered_router
		end

	create_filtered_router
			-- Create `router` and `filter`.
		do
			create_router
			create_filter
		end

	initialize_filtered_router
			-- Initialize `router` and `filter`.
		local
			f: like filter
		do
			initialize_router
			initialize_filter

				-- Current is a WSF_FILTER as well in order to call the router
				-- let's add Current at the end of the filter chain.
			append_filter (Current)
		end

feature -- Execute Filter

	filter_execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute the filter.
		do
			router_execute (req, res)
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
