note
	description : "simple application root class"
	date        : "$Date$"
	revision    : "$Revision$"

class
	APPLICATION

create
	make_and_launch

feature {NONE} -- Initialization

	make_and_launch
		local
			l_launcher: WSF_STANDALONE_WEBSOCKET_SERVICE_LAUNCHER [APPLICATION_EXECUTION]
			opts: WSF_STANDALONE_WEBSOCKET_SERVICE_OPTIONS
		do
			create opts
			if opts.is_secure_connection_supported then
				opts.is_secure := True
				opts.set_secure_protocol_to_tls_1_2
				opts.secure_certificate := "ca.crt"
				opts.secure_certificate_key := "ca.key"
			end

			opts.import_ini_file_options ("ws.ini")
			create l_launcher.make_and_launch (opts)
		end

end
