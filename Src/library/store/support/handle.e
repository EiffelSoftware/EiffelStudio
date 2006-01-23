indexing

	status: "See notice at end of class.";
	Date: "$Date$"
	Revision: "$Revision$"
	Product: EiffelStore
	Database: All_Bases

class HANDLE

feature -- Status report

	database: DB [DATABASE]
			-- Active database accessed through the handle

	process: POINTER_REF
			-- Communication channel with database server
			-- (single or multiple depending on RDBMS)

	status: DB_STATUS
			-- Status of active database
	
	execution_type: DB_EXEC
			-- Immediate or non-immediate execution		

	login: LOGIN [DATABASE]
		-- Session login

	all_types: DB_ALL_TYPES is
			-- All data types available in active database
		once
			create Result.make
		ensure
			result_not_void: Result /= Void
		end

feature {GENERAL_APPL} -- Status setting

	set_database (other: DB [DATABASE]) is
			-- Set current database with `other'.
  		require
			database_exists: other /= Void
		do
			database := other
		ensure
			database = other
		end

	set_process (other: POINTER_REF) is
			-- Set current process with `other'.
		do
			process := other
		ensure
			process = other
		end

	set_status (other: DB_STATUS) is
			-- Set current status with `other'.
		require
			db_status_exists: other /= Void
		do
			status := other
		ensure
			status = other
		end

	set_execution_type (other: DB_EXEC) is
			-- Set current execution_type with `other'.
		require
			db_status_exists: other /= Void
		do
			execution_type := other
		ensure
			execution_type = other
		end

	set_login (other: LOGIN [DATABASE]) is
		-- Get `other' login for handle
		require
			login_not_void: other /= Void
		do
			login := other
		ensure
			login = other
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class HANDLE



