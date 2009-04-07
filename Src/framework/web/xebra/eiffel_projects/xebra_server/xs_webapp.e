note
	description: "[
		Represents a Xebra Web Application that is registered within Xebra Server
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XS_WEBAPP

create
	make

feature {NONE} -- Initialization

	make (a_name, a_host: STRING; a_port: INTEGER)
			-- Initialization for `Current'.
		require
			a_name_not_empty: not a_name.is_empty		
			a_host_not_empty: not a_host.is_empty
		do
			name := a_name
			port := a_port
			host := a_host
		ensure
			name_set: name = a_name
			host_set: host = a_host
			port_set: port = a_port
		end

feature -- Access

	name: STRING
		-- The name of the webapp

	port: INTEGER
		-- The port of the webapp

	host: STRING
		-- The hostname of the webapp

end
