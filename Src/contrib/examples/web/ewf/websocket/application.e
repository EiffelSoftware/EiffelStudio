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
			opts: WSF_SERVICE_LAUNCHER_OPTIONS
		do
			create {WSF_SERVICE_LAUNCHER_OPTIONS_FROM_INI} opts.make_from_file ("ws.ini")
			create l_launcher.make_and_launch (options)
		end

	options: WSF_SERVICE_LAUNCHER_OPTIONS
			-- Initialize current service.
		do
			create {WSF_SERVICE_LAUNCHER_OPTIONS_FROM_INI} Result.make_from_file ("ws.ini")
		end

end
