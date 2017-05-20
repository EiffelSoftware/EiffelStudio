note
	description: "simple application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

inherit
	WSF_STANDALONE_SERVICE [APPLICATION_EXECUTION]
		redefine
			initialize
		end

create
	make_and_launch

feature {NONE} -- Initialization

	initialize
			-- Initialize current service.
		local
			opts: WSF_STANDALONE_SERVICE_OPTIONS
		do
				-- Specific to `standalone' connector (the EiffelWeb server).
				-- See `{WSF_STANDALONE_SERVICE_LAUNCHER}.initialize'
			create opts
			opts.port := 9090
			opts.socket_recv_timeout := 5 -- seconds

			opts.import_ini_file_options ("simple.ini")
			import_service_options (opts)
		end

end
