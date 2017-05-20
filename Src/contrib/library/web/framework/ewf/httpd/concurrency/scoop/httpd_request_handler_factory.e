note
	description: "Implementation of request handler factory for concurrency mode: SCOOP"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	HTTPD_REQUEST_HANDLER_FACTORY

inherit
	HTTPD_REQUEST_HANDLER_FACTORY_I

	CONCURRENT_POOL_FACTORY [HTTPD_REQUEST_HANDLER]
		rename
			new_separate_item as new_handler
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
