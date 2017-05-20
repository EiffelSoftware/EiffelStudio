note
	description: "[
			Object used to control (i.e shutdown) the server.
			Mostly needed in SCOOP concurrency mode.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	HTTPD_CONTROLLER

feature -- Operation

	shutdown
			-- Request the associated server to be shutdown.
		do
			shutdown_requested := True
		end

feature -- Status report.		

	shutdown_requested: BOOLEAN
			-- Shutdown requested.

;note
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
