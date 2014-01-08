note
	description: "Summary description for {PS_MYSQL_RELATIONAL_REPOSITORY_FACTORY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PS_MYSQL_RELATIONAL_REPOSITORY_FACTORY

inherit
	PS_MYSQL_REPOSITORY_FACTORY
		redefine
			new_connector, make_uninitialized
		end

create
	make, make_uninitialized

feature {NONE} -- Initialization

	make_uninitialized
			-- <Precursor>
		do
			Precursor
			create mapping.make
		end

feature -- Access

	mapping: PS_DATABASE_MAPPING
			-- A mapping table to override naming and primary key defaults.

feature {NONE} -- Implementation

	new_connector: PS_RELATIONAL_CONNECTOR
			-- <Precursor>
		local
			l_host: STRING
			l_port: INTEGER
			mysql_database: PS_MYSQL_DATABASE
		do
			if attached host as h then
				l_host := h
			else
				l_host := default_host
			end

			if port > 0 then
				l_port := port
			else
				l_port := default_port
			end

			check
				attached user as l_user
				and attached password as l_password
				and attached database as l_database
			then
				create mysql_database.make (l_user, l_password, l_database, l_host, l_port)
				create Result.make (mysql_database, mapping)
			end
		end

end
