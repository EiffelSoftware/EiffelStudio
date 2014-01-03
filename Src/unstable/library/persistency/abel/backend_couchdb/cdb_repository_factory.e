note
	description: "[
		A repository that stores data on a CouchDB.	
		Use REPOSITORY_FACTORY to get an instance of this class.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CDB_REPOSITORY_FACTORY

inherit
	PS_REPOSITORY_FACTORY

create
	make, make_uninitialized

feature -- Access

	port: INTEGER
			-- The port number of the database. Default: 5984

	host: detachable STRING
			-- The host name of the database. Default: http://127.0.0.1

feature -- Status report

	is_buildable: BOOLEAN = True
			-- Does `Current' have enough information to build a repository?

feature -- Element change

	set_port (a_port: like port)
			-- Assign `port' with `a_port'.
		do
			port := a_port
		ensure
			port_assigned: port = a_port
		end

	set_host (a_host: STRING)
			-- Assign `host' with `a_host'.
		do
			host := a_host
		ensure
			host_assigned: host = a_host
		end

feature {NONE}

	new_connector: PS_REPOSITORY_CONNECTOR
		local
			l_host: STRING
			backend: CDB_BACKEND
		do
			if port = 0 then
				port := 5984
			end
			if attached host as h then
				l_host := h
			else
				l_host := "http://127.0.0.1"
			end

			create backend.make_with_host_and_port (l_host, port)

			Result := backend
		end

end
