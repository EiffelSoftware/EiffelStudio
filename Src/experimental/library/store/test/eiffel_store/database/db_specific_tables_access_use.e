note
	description: "Access to the class DB_SPECIFIC_TABLES_ACCESS"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DB_SPECIFIC_TABLES_ACCESS_USE

feature -- Status report

	is_valid_code (code: INTEGER): BOOLEAN
			-- Does `code' represents a database table?
		do
			Result := tables.is_valid (code)
		end

feature {NONE} -- Access

	tables: DB_SPECIFIC_TABLES_ACCESS
			-- Description of database tables
			-- handled by the project.
		once
			create Result.make
		ensure
			result_not_void: Result /= Void
		end

end -- class DB_SPECIFIC_TABLES_ACCESS_USE
