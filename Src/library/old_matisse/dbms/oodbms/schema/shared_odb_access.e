indexing
	description: "Shared object database schema."
	version:     "%%I%%"
	date:        "%%D%%"
	source:      "%%P%%"
	status:      "Not yet determined; NOT FOR GENERAL DISTRIBUTION"
	author:      "Thomas Beale, Deep Thought Informatics Pty Ltd"
	keywords:    "odb, schema"

class SHARED_ODB_ACCESS

feature -- Shared Access
	odb_schema:ODB_SCHEMA is
		do
			Result := odb_schemas.item(current_db_name)
		end

	current_db_name:STRING is
		do
			Result := shared_current_db_name.item
		end

	is_valid_db_name(a_name:STRING):BOOLEAN is
		require
			Valid_name: a_name /= Void
		do
			Result := db_sessions.has(a_name)
		end

	db_name_for_class(a_name:STRING):STRING is
			-- returns Void if a_name not in any schema
		require
			Valid_name: a_name /= Void and then not a_name.empty
		do
			from odb_schemas.start until odb_schemas.off or else odb_schemas.item_for_iteration.has_type(a_name) loop
				odb_schemas.forth
			end
			if not odb_schemas.off then 
				Result := odb_schemas.key_for_iteration
			end
		end

feature -- Modification
	set_current_db_name(a_name:STRING) is
		require
			Valid_name: a_name /= Void and then is_valid_db_name(a_name)
		do
			shared_current_db_name.put(a_name)
		end

feature {NONE} -- shared storage area
	db_servers:HASH_TABLE[MATISSE_APPL, STRING] is once !!Result.make(0) end
			-- servers keyed by logical name

	db_sessions:HASH_TABLE[DB_CONTROL, STRING] is once !!Result.make(0) end
			-- sessions keyed by logical name

	odb_schemas:HASH_TABLE[ODB_SCHEMA, STRING] is once !!Result.make(0) end
			-- schemas keyed by logical name

	shared_current_db_name:CELL[STRING] is
			-- logical name of database (repository) currently being accessed
		once
			!!Result.put(Void)
		end

end

--         +--------------------------------------------------+
--         |                                                  |
--         |               Copyright (c) 1998                 |
--         |          Deep Thought Informatics Pty Ltd        |
--         |       Australian Company Number 076 645 291      |
--         |                                                  |
--         |          support: info@deepthought.com.au        |
--         |                                                  |
--         +--------------------------------------------------+

