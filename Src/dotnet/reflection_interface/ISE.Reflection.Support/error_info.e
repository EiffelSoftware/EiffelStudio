indexing
	description: "Error occurred during storage or data retrieval"
	external_name: "ISE.Reflection.ErrorInfo"
	
class
	ERROR_INFO
	
create
	make
	
feature {NONE} -- Initialization

	make (a_code: like code) is
			-- Set `code' with `a_code'.
		indexing
			external_name: "Make"
		require
			valid_code: a_code > 0
		do
			code := a_code
		ensure
			code_set: code = a_code
		end

feature -- Access

	code: INTEGER
			-- Error code
		indexing
			external_name: "Code"
		end

	name: STRING is
			-- Error name
		indexing
			external_name: "Name"
		require
			code_exists: errors_table.errors_table.ContainsKey (code)
		do
			Result := errors_table.error_name (code)
		ensure
			name_found: Result /= Void
			not_empty_name: Result.Length > 0
		end			
			
	description: STRING is
			-- Error description
		indexing
			external_name: "Description"
		require
			code_exists: errors_table.errors_table.ContainsKey (code)		
		do
			Result := errors_table.error_description (code)
		ensure
			description_found: Result /= Void
			not_empty_description: Result.Length > 0
		end	

	errors_table: ERRORS_TABLE is
			-- Errors table
		indexing
			external_name: "ErrorsTable"
		once
			create Result.make
		ensure
			table_created: Result /= Void
		end
		
invariant
	valid_code: code > 0
			
end -- class ERROR_INFO
