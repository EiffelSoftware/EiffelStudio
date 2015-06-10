note
	description: "[
			Component to launch the service using the default connector

					libFCGI for this class

			How-to:

				s: WSF_DEFAULT_SERVICE_LAUNCHER
				create s.make_and_launch (agent execute)

				execute (req: WSF_REQUEST; res: WSF_RESPONSE)
					do
						-- ...
					end
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_LIBFCGI_SERVICE_LAUNCHER

inherit
	WSF_SERVICE_LAUNCHER

create
	make,
	make_and_launch,
	make_callback,
	make_callback_and_launch

feature {NONE} -- Initialization

	initialize
		do
			create connector.make (Current)
		end

feature -- Execution

	launch
		do
			if attached connector as conn then
				conn.launch
			end
		end

feature -- Status report

	connector: detachable WGI_LIBFCGI_CONNECTOR
			-- Default service name

;note
	copyright: "2011-2012, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
