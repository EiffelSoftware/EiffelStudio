indexing

	Status: "See notice at end of class";
	Date: "$Date$"
	Revision: "$Revision$"
	Product: EiffelStore
	Database: All_Bases

class HANDLE

feature -- Status report

	database: DATABASE
			-- Active database accessed through the handle

	process: POINTER_REF
			-- Communication channel with database server
			-- (single or multiple depending on RDBMS)

	status: DB_STATUS
			-- Status of active database
	
	execution_type: DB_EXEC
			-- Immediate or non-immediate execution		

	all_types: DB_ALL_TYPES is
			-- All data types available in active database
		once
			!! Result.make
		ensure
			result_not_void: Result /= Void
		end

feature {GENERAL_APPL} -- Status setting

	set_database (other: DATABASE) is
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


end -- class HANDLE


--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
