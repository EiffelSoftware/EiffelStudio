note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XC_WEBAPP_CONFIG

inherit
	XI_CONFIG
		redefine
			make_empty
		end

create
	make_empty

feature {NONE} -- Initialization

	make_empty
			-- Initialization for `Current'.
		do
			create name.make_empty
			create port.make_empty
			create host.make_empty
			create is_interactive.make_empty
			create arg_config.make_empty
		ensure then
			arg_config_attached: arg_config /= Void
			name_attached: name /= Void
			host_attached: host /= Void
			port_attached: port /= Void
			is_interactive_attached: is_interactive /= Void
		end

feature -- Access

	name: SETTABLE_STRING assign set_name
		-- The name of the application.

	host: SETTABLE_STRING assign set_host
		-- The host of the application.	

	port: SETTABLE_INTEGER assign set_port
		-- The port on which the application listens.

	is_interactive: SETTABLE_BOOLEAN assign set_is_interactive
		-- Specifies whether the application should be run in interactive mode.
		-- In interactive mode it can be close via console
		-- This can be overridden by an arg parameter

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

	set_is_interactive (a_is_interactive: like is_interactive)
			-- Sets is_interactive
		require
			a_is_interactive_attached: a_is_interactive /= Void
		do
			is_interactive  := a_is_interactive
		ensure
			is_interactive_set: is_interactive  = a_is_interactive
		end

invariant
	arg_config_attached: arg_config /= Void
	name_attached: name /= Void
	host_attached: host /= Void
	port_attached: port /= Void
	is_interactive_attached: is_interactive /= Void
end

