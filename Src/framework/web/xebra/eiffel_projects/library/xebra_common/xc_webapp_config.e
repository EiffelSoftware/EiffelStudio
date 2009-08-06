note
	description: "[
		Contains configuration info about a webapp.
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
			create ecf.make_empty
			create arg_config.make_empty
			create {ARRAYED_LIST [TUPLE [name: STRING; ecf: STRING; path: STRING]]} taglibs.make (3)
		ensure then
			arg_config_attached: arg_config /= Void
			name_attached: name /= Void
			ecf_attached: ecf /= Void
			host_attached: host /= Void
			port_attached: port /= Void
			taglibs_attached: taglibs /= Void
		end

feature -- Access

	ecf: SETTABLE_STRING assign set_ecf
		-- The ecf file path of the application.

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

	is_interactive: BOOLEAN
			-- Specifies if the webapp is executed in interactive mode. This property is not set by the file but by the execution arguements.			

feature -- Status setting

	set_is_interactive (a_is_interactive: like is_interactive)
			-- Sets name
		require
			a_is_interactive_attached: a_is_interactive /= Void
		do
			is_interactive := a_is_interactive
		ensure
			is_interactive_set: is_interactive = a_is_interactive
		end

	set_ecf (a_ecf: like ecf)
			-- Sets ecf
		require
			a_ecf_attached: a_ecf /= Void
		do
			ecf := a_ecf
		ensure
			ecf_set: ecf = a_ecf
		end

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
	ecf_attached: ecf /= Void
	taglibs_attached: taglibs /= Void
end

