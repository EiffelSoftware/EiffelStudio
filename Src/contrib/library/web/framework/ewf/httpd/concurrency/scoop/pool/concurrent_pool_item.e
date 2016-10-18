note
	description: "[
			Item create by the CONCURRENT_POOL_FACTORY, and managed by the CONCURRENT_POOL 
			for SCOOP concurrency mode.
		]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CONCURRENT_POOL_ITEM

feature	{NONE} -- Access

	pool: detachable separate CONCURRENT_POOL [CONCURRENT_POOL_ITEM]
			-- Associated concurrent pool component.

feature {CONCURRENT_POOL} -- Change

	set_pool (p: like pool)
			-- Set associated `pool' to `p'.
		do
			pool := p
		end

feature {CONCURRENT_POOL, HTTPD_CONNECTION_HANDLER_I} -- Basic operation

	release
			-- Release Current pool item from associated pool.
		do
			if attached pool as p then
				pool_release (p)
			end
		end

feature {NONE} -- Implementation

	pool_release (p: separate CONCURRENT_POOL [CONCURRENT_POOL_ITEM])
		do
			p.release_item (Current)
		end

note
	copyright: "2011-2016, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
