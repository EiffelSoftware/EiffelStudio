note
	description: "Summary description for {IRON_NODE_SERVER_LAUNCHER_I}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IRON_NODE_SERVER_LAUNCHER_I [G -> WSF_EXECUTION create make end]

feature {WSF_SERVICE} -- Launcher

	launch (opts: detachable WSF_SERVICE_LAUNCHER_OPTIONS)
		local
			launcher: WSF_DEFAULT_SERVICE_LAUNCHER [G]
		do
			create launcher.make_and_launch (opts)
		end

end

