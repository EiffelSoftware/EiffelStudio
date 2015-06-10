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
	copyright: "2011-2013, Javier Velilla, Jocelyn Fiat and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
