note
	description: "[
		Contains server side configuration info about a webapp
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XS_WEBAPP_CONFIG

inherit
	XI_CONFIG
		redefine
			make_empty
		end

create
	 make_empty

feature {NONE} -- Initialization

	make_empty
			--
		do
			create name.make_empty
			create port.make_empty
			create host.make_empty
		end

feature -- Access

	name:  SETTABLE_STRING assign set_name
		-- The name of the webapp

	port:  SETTABLE_INTEGER assign set_port
		-- The port of the webapp where the server can connect to

	host:  SETTABLE_STRING assign set_host
		-- The host of the webapp

feature -- Setters

	set_name (a_name: like name)
			-- Sets name
		do
			name := a_name
		ensure
			name_set: name = a_name
		end

	set_port  (a_port: like port)
			-- Sets port
		do
			port  := a_port
		ensure
			port_set: port  = port
		end

	set_host (a_host: like host)
			-- Sets translator
		do
			host  := a_host
		ensure
			host_set: host  = a_host
		end
invariant
	name_attached: name /= Void
	port_attached: port /= Void
	host_attached: host /= Void
end

