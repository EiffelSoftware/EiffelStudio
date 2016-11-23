note
	description: "Summary description for {EMBEDDED_WEB_SERVICE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EMBEDDED_WEB_SERVICE [G -> EMBEDDED_WEB_EXECUTION create make end]

inherit
	WSF_SERVICE

	SHARED_EMBEDED_WEB_SERVICE_INFORMATION

feature -- Initialization

	make
		do
		end

feature -- Execution

	launch
		local
			launcher: WSF_STANDALONE_SERVICE_LAUNCHER [G]
			opts: WSF_SERVICE_LAUNCHER_OPTIONS
		do
			create opts.default_create
			opts.set_option ("port", port_number)
			create launcher.make (opts)
			observer := launcher.connector.observer
			launcher.on_launched_actions.force (agent on_launched)
			launcher.launch
		end

	observer: detachable separate WGI_STANDALONE_SERVER_OBSERVER

	on_launched (conn: WGI_STANDALONE_CONNECTOR [G])
		do
			set_port_number (conn.port)
			if attached on_launched_action as act then
				call_action (act)
			end
		end

	call_action (act: attached like on_launched_action)
		do
			act.call (Void)
		end

feature -- Access

	on_launched_action: detachable separate PROCEDURE [TUPLE]

	set_on_launched_action (act: like on_launched_action)
		do
			on_launched_action := act
		end

end
