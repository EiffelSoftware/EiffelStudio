note
	description: "Summary description for {IRON_NODE_SERVER_LAUNCHER_I}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IRON_NODE_SERVER_LAUNCHER_I

feature {WSF_SERVICE} -- Launcher

	launch (a_service: WSF_SERVICE; opts: detachable WSF_SERVICE_LAUNCHER_OPTIONS)
		local
			launcher: WSF_DEFAULT_SERVICE_LAUNCHER
		do
			create launcher.make_and_launch (a_service, opts)
		end

end

