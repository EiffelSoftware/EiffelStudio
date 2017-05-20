note
	description : "Concurrent specific feature to implement HTTPD_REQUEST_HANDLER"
	date        : "$Date$"
	revision    : "$Revision$"

deferred class
	HTTPD_REQUEST_HANDLER

inherit
	HTTPD_REQUEST_HANDLER_I
		redefine
			is_persistent_connection_supported
		end

feature -- Status report	

	is_persistent_connection_supported: BOOLEAN = False
			-- <Precursor>
			-- When there is no concurrency support, do not try to support
			-- persistent connection!	

note
	copyright: "2011-2015, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
