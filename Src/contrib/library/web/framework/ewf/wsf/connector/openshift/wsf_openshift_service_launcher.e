note
	description: "[
			Component to launch the service using the default connector

				Eiffel Web Nino customized for OpenShift


				This default connector support options:
					base: base_url (very specific to standalone server)
					verbose: to display verbose output, useful for Nino
					force_single_threaded: use only one thread, useful for Nino

			check WSF_SERVICE_LAUNCHER for more documentation
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_OPENSHIFT_SERVICE_LAUNCHER

inherit
	WSF_NINO_SERVICE_LAUNCHER
		redefine
			initialize
		end

create
	make,
	make_and_launch,
	make_callback,
	make_callback_and_launch

feature {NONE} -- Initialization

	initialize
		local
			l_env: EXECUTION_ENVIRONMENT
		do
			Precursor
			create l_env

			if attached l_env.get (Openshift_ip) as l_ip then
				server_name := l_ip.to_string_8
			else
				die (Openshift_ip + " is not defined")
			end

			if attached l_env.get (Openshift_port) as l_port then
				if l_port.is_integer then
					port_number := l_port.to_integer
				else
					die ("could not parse " + Openshift_port)
				end
			else
				die (Openshift_port + " is not defined")
			end
		end

feature {NONE} -- Implementation

	die (a_message: STRING)
			-- Die with `a_message'.
		local
			l_exceptions: EXCEPTIONS
		do
			io.put_string (a_message)
			io.put_new_line
			create l_exceptions
			l_exceptions.die (1)
		end

	Openshift_ip: STRING = "OPENSHIFT_INTERNAL_IP"
			-- OpenShift IP environment variable name

	Openshift_port: STRING = "OPENSHIFT_INTERNAL_PORT"
			-- OpenShift port environment variable name


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
