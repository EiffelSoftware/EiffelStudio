indexing
	description: "Provide support for code generation and reflection."
	external_name: "ISE.Reflection.Support"
--	attribute: create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACEATTRIBUTE}.make_classinterfaceattribute (2) end

deferred class
	SUPPORT

feature -- Access

	last_error: ERROR_INFO
			-- Last error
		indexing
			external_name: "LastError"
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

feature -- Basic Operations

	create_error (a_name, a_description: STRING) is
			-- Create `last_error_info' and add it to `errors_table'.
		indexing
			external_name: "CreateError"
		require
			non_void_name: a_name /= Void
			not_empty_name: a_name.length > 0
			non_void_description: a_description /= Void
			not_empty_description: a_description.length > 0
		local
			a_code: INTEGER
		do
			a_code := errors_table.errors_table.count
			create last_error.make (a_code, a_name, a_description)
			errors_table.add_error (last_error)
		ensure
			non_void_error: last_error /= Void
			error_added: errors_table.errors_table.count = old errors_table.errors_table.count + 1
		end

	create_error_from_info (a_code: INTEGER; a_name, a_description: STRING) is
			-- Create error info from `a_code', `a_name' and `a_description'.
		indexing
			external_name: "CreateErrorFromInfo"
		require
			non_void_name: a_name /= Void
			non_void_description: a_description /= Void
			valid_code: a_code >= 0
			not_empty_name: a_name.length > 0
			not_empty_description: a_description.length > 0
		do
			create last_error.make (a_code, a_name, a_description)
			if not errors_table.errors_table.containskey (a_code) then 
				errors_table.add_error (last_error)
			end
		end
		
end -- class SUPPORT
