note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XC_WEBAPP_CONFIG

create
	make_empty

feature {NONE} -- Initialization

	make_empty
			-- Initialization for `Current'.
		do
			create name.make_empty
			create port.make_empty
			create host.make_empty
			create arg_config.make_empty
			create {ARRAYED_LIST [TUPLE [name: STRING; ecf: STRING; path: STRING]]} taglibs.make (3)
		ensure then
			arg_config_attached: arg_config /= Void
			name_attached: name /= Void
			host_attached: host /= Void
			port_attached: port /= Void
			taglibs_attached: taglibs /= Void
		end

feature -- Access

	name: SETTABLE_STRING assign set_name
		-- The name of the application.

	host: SETTABLE_STRING assign set_host
		-- The host of the application.	

	port: SETTABLE_INTEGER assign set_port
		-- The port on which the application listens.

	taglibs: LIST [TUPLE [name: STRING; ecf: STRING; path: STRING]]
		-- Specifies the taglibs the webapp is using.

	arg_config: XC_WEBAPP_ARG_CONFIG
			-- The config settings read from the execute arguments.		

feature -- Status report

feature -- Status setting

	set_name (a_name: like name)
			-- Sets name
		require
			a_name_attached: a_name /= Void
		do
			name := a_name
		ensure
			name_set: name = a_name
		end

	set_host (a_host: like host)
			-- Sets host
		require
			a_host_attached: a_host /= Void
		do
			host := a_host
		ensure
			host_set: host = a_host
		end

	set_port  (a_port: like port)
			-- Sets port
		require
			a_port_attached: a_port /= Void
		do
			port  := a_port
		ensure
			port_set: port  = port
		end

invariant
	arg_config_attached: arg_config /= Void
	name_attached: name /= Void
	host_attached: host /= Void
	port_attached: port /= Void
	taglibs_attached: taglibs /= Void
end

