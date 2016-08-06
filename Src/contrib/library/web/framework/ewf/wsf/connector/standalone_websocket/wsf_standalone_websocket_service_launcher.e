note
	description: "[
			Component to launch the service using the default connector

				Eiffel Web httpd for this class


				The httpd default connector support options:
					port: numeric such as 8099 (or equivalent string as "8099")
					base: base_url (very specific to standalone server)
					verbose: to display verbose output, useful for standalone connector
					force_single_threaded: use only one thread, useful for standalone connector

			check WSF_SERVICE_LAUNCHER for more documentation
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_STANDALONE_WEBSOCKET_SERVICE_LAUNCHER [G -> WSF_WEBSOCKET_EXECUTION create make end]

inherit
	WSF_STANDALONE_SERVICE_LAUNCHER [G]
		redefine
			connector
		end

create
	make,
	make_and_launch

feature -- Status report

	connector: WGI_STANDALONE_WEBSOCKET_CONNECTOR [G]
			-- Default connector

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

