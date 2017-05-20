note
	description: "Websocket server."
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

inherit
	WEB_SOCKET_SERVICE [APPLICATION_EXECUTION]
		redefine
			set_options
		end

create
	make_and_launch

feature {NONE} -- Initialization

	set_options (opts: WEB_SOCKET_SERVICE_OPTIONS)
		do
			opts.set_is_verbose (True) -- For debug purpose
			opts.set_verbose_level ("debug")

			opts.set_is_secure (True) -- If SSL is supported
			opts.set_secure_certificate ("ca.crt") -- Change to use your own crt file.
			opts.set_secure_certificate_key ("ca.key") -- Change to use your own key file.

			opts.set_port (default_port_number)
		end

feature -- Access

	default_port_number: INTEGER = 9090

note
	copyright: "2011-2016, Javier Velilla, Jocelyn Fiat and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

