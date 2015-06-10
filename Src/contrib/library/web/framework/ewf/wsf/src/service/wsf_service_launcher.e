note
	description: "[
			Component to launch the service using the default connector

			How-to:

				s: WSF_SERVICE_LAUNCHER
				create s.make_and_launch (service)

				`service' can be Current if inherit from WSF_SERVICE
				or also  `create {WSF_CALLBACK_SERVICE}.make (agent execute)'

				execute (req: WSF_REQUEST; res: WSF_RESPONSE)
					do
						-- ...
					end
					
				You can also provide specific options that might be relevant
				only for specific connectors such as


				For instance, you can use
				create s.make_and_launch_and_options (agent execute, <<["port", 8099]>>)

				And if Nino is the default connector it will support:
					port: numeric such as 8099 (or equivalent string as "8099")
					base: base_url (very specific to standalone server)
					force_single_threaded: use only one thread, useful for Nino
					verbose: to display verbose output, useful for Nino
		]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WSF_SERVICE_LAUNCHER [G -> WSF_EXECUTION create make end]

feature {NONE} -- Initialization

	frozen make (a_options: like options)
		do
			options := a_options
			initialize
		ensure
			options_set: options = a_options
			launchable: launchable
		end

	frozen make_and_launch (a_options: like options)
		do
			make (a_options)
			launch
		end

	initialize
			-- Initialize Current using `options' if attached
			-- and build the connector
		deferred
		ensure
			connector_attached: connector /= Void
		end

feature -- Status report

	launchable: BOOLEAN
			-- Is default service launchable?
		do
			Result := connector /= Void
		end

	connector: detachable WGI_CONNECTOR
			-- Connector associated to current default service
		deferred
		end

	connector_name: READABLE_STRING_8
			-- Connector's name associated to current default service	
		do
			if attached connector as conn then
				Result := conn.name
			else
				check
					connector_attached: False
				end
				Result := ""
			end
		end

feature -- Execution

	launch
			-- Launch default service
		require
			launchable: launchable
		deferred
		end

feature {NONE} -- Implementation

	options: detachable WSF_SERVICE_LAUNCHER_OPTIONS
			-- Custom options which might be support (or not) by the default service

invariant
	connector_attached: connector /= Void

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
