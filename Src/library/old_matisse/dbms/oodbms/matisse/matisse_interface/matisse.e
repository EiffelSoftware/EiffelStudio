indexing

	Product: EiffelStore
	Database: Matisse

class MATISSE

inherit

	DATABASE
		redefine 
			dispose
		end

	DB_CONSTANT
		export
			{NONE} all
		end
    
feature -- Status report

	db_control_i: DB_CONTROL_MAT is
 		-- DB_CONTROL handle implemented in Matisse
		do
			!! Result
		end -- db_control_i

	db_status_i: DB_STATUS_MAT is
		-- DB_STATUS handle implemented in Matisse
		do
			!! Result
		end -- db_status_i

	db_selection_i: DB_SELECTION_MAT is
 		-- DB_SELECTION handle implemented in Matisse
		do
			!! Result.make (parsed_string_size)
		end -- db_selection_i

	db_change_i: DB_CHANGE_MAT is
		-- DB_CHANGE handle implemented in Matisse
		do
			!! Result.make (parsed_string_size)
		end -- db_change_i

	db_repository_i: DB_REPOSITORY_MAT is
		-- DB_REPOSITORY handle implemented in Matisse
		do
 			!! Result.make
		end -- db_repository_i

	db_result_i: DB_RESULT_MAT is
 		-- DB_RESULT handle implemented in Matisse
		do
			!! Result
		end -- db_result_i

	db_store_i: DB_STORE_MAT is
		-- DB_STORE handle implemented in Matisse
		do
			!! Result.make (parsed_string_size)
		end -- db_store_i

	db_format_i: DB_FORMAT_MAT is
		-- DB_FORMAT handle implemented in Matisse
		do
			!! Result
		end -- db_format_i

	db_proc_i: DB_PROC_MAT is
		-- DB_PROC handle implemented in Matisse
		do
			!!Result
		end -- db_proc_i

	db_all_types_i: DB_ALL_TYPES_MAT is
		-- Unused
		do
		end -- db-all_types_i

feature {NONE} -- Status report

	sql_struct: DB_DATA_MAT is
		-- DB_DATA implementation in Matisse
		do
			!! Result
		end -- sql_struct

feature -- Implementation

	dispose is
		-- Do nothing
		do
		end -- dispose

end -- class MATISSE

