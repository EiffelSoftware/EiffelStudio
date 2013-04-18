note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	IRON_REPO_CONTROLLER_SERVER_TASK

inherit
	IRON_REPO_CONTROLLER_TASK

create
	default_create,
	make_with_connector

feature {NONE} -- Initialization

	make_with_connector (a_conn: READABLE_STRING_8)
		do
			connector := a_conn
		end

feature -- Access

	name: STRING = "server"

	connector: detachable READABLE_STRING_8

feature -- Execution

	is_available (iron: IRON_REPO): BOOLEAN
		do
			Result := iron.is_available
		end

	execute (iron: IRON_REPO)
		local
			server: detachable IRON_REPO_SERVER
		do
			if attached connector as conn then
				if conn.is_case_insensitive_equal ("cgi") then
					create server.make_and_launch_cgi (iron)
				elseif conn.is_case_insensitive_equal ("libfcgi") then
					create server.make_and_launch_libfcgi (iron)
				end
			end
			if server = Void then
				create server.make_and_launch (iron)
			end

		end

end
