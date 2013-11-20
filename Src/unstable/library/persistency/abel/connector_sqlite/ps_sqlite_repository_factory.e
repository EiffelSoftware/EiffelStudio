note
	description: "Summary description for {PS_SQLITE_REPOSITORY_FACTORY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PS_SQLITE_REPOSITORY_FACTORY

inherit
	PS_REPOSITORY_FACTORY

create
	make, make_uninitialized

feature -- Access

	database: detachable STRING
			-- The path to a database file.
		note
			option: stable
		attribute
		end

feature -- Status report

	is_buildable: BOOLEAN
			-- Does `Current' have enough information to build a repository?
		do
			Result := attached database
		end

feature -- Element change

	set_database (value: STRING)
			-- Set `database' to `value'.
		require
			not_empty: not value.is_empty
		do
			database := value
		ensure
			database_set: database ~ value
		end

feature {PS_ABEL_EXPORT} -- Testing Internal

	sqlite_database: detachable PS_SQLITE_DATABASE

feature {NONE}

	new_backend: PS_BACKEND
			-- Create a new backend.
		local
			l_sqlite_database: PS_SQLITE_DATABASE
		do

			check attached database as l_database then
				create l_sqlite_database.make (l_database)
				sqlite_database := l_sqlite_database
				create {PS_GENERIC_LAYOUT_SQL_BACKEND} Result.make (l_sqlite_database, create {PS_SQLITE_STRINGS})
			end

--			Result.add_plug_in (create {PS_ATTRIBUTE_REMOVER_PLUGIN})
		end

end
