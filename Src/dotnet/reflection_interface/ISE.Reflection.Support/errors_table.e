indexing
	description: "Possible errors when using ISE reflection interface"
	external_name: "ISE.Reflection.ErrorsTable"
class
	ERRORS_TABLE

inherit
	ERROR_MESSAGES
		export 
			{NONE} all
		end
	
create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `errors_table'.
		indexing
			external_name: "Make"
		do
			create errors_table.make
			fill_errors_table
		ensure
			errors_table_created: errors_table /= Void
		end
		
feature -- Access
	
	errors_table: SYSTEM_COLLECTIONS_HASHTABLE
			-- Key: error code
			-- Value: [error name, error description]
			-- | ARRAY [STRING]
		indexing
			external_name: "ErrorsTable"
		end

	error_name (a_code: INTEGER): STRING is
			-- Error name corresponding to `a_code'
		indexing
			external_name: "ErrorName"
		require
			valid_code: a_code > 0 and errors_table.ContainsKey (a_code)
		local
			description_array: ARRAY [STRING]
		do
			description_array ?= errors_table.Item (a_code)	
			if description_array /= Void then
				if description_array.count = 2 then
					Result := description_array.item (0)
				end
			end
		ensure
			error_name_found: Result /= Void
			not_empty_error_name: Result.Length > 0
		end

	error_description (a_code: INTEGER): STRING is
			-- Error name corresponding to `a_code'
		indexing
			external_name: "ErrorDescription"
		require
			valid_code: a_code > 0 and errors_table.ContainsKey (a_code)
		local
			description_array: ARRAY [STRING]
		do
			description_array ?= errors_table.Item (a_code)	
			if description_array /= Void then
				if description_array.count = 2 then
					Result := description_array.item (1)
				end
			end
		ensure
			error_description_found: Result /= Void
			not_empty_error_description: Result.Length > 0
		end
			
feature -- Basic Operations

	add_error (a_code: INTEGER; a_name, a_description: STRING) is
			-- Add error with code `a_code' in `errors_table' 
			-- with corresponding error name `a_name' and description `a_description'.
		indexing
			external_name: "AddError"
		require
			valid_code: a_code > 0 and not errors_table.ContainsKey (a_code)
			non_void_name: a_name /= Void
			not_empty_name: a_name.Length > 0
			non_void_description: a_description /= Void
			not_empty_description: a_description.Length > 0
		local
			description_array: ARRAY [STRING]
		do
			create description_array.make (2)
			description_array.put (0, a_name)
			description_array.put (1, a_description)
			errors_table.Add (a_code, description_array)
		ensure
			error_added: errors_table.ContainsKey (a_code)
			table_updated: errors_table.Count = old errors_table.Count + 1
		end
	
	replace_error_name (a_code: INTEGER; new_name: STRING) is
			-- Replace error name corresponding to `a_code' with `new_name'.
		indexing
			external_name: "ReplaceErrorName"
		require
			valid_code: a_code > 0 and errors_table.ContainsKey (a_code)
			non_void_new_name: new_name /= Void
			not_empty_new_name: new_name.Length > 0
		local
			description_array: ARRAY [STRING]
			new_description_array: ARRAY [STRING]
		do
			description_array ?= errors_table.Item (a_code)	
			if description_array /= Void then
				if description_array.count = 2 then
					create new_description_array.make (2)
					new_description_array.put (0, new_name)
					new_description_array.put (1, description_array.item (1))
					errors_table.Remove (a_code)
					errors_table.Add (a_code, new_description_array)
				end
			end
		ensure
			name_replaced: error_name (a_code).Equals_String (new_name)
		end

	replace_error_description (a_code: INTEGER; new_description: STRING) is
			-- Replace error description corresponding to `a_code' with `new_description'.
		indexing
			external_name: "ReplaceErrorDescription"
		require
			valid_code: a_code > 0 and errors_table.ContainsKey (a_code)
			non_void_new_description: new_description /= Void
			not_empty_new_description: new_description.Length > 0
		local
			description_array: ARRAY [STRING]
			new_description_array: ARRAY [STRING]
		do
			description_array ?= errors_table.Item (a_code)	
			if description_array /= Void then
				if description_array.count = 2 then
					create new_description_array.make (2)
					new_description_array.put (0, description_array.item (0))
					new_description_array.put (1, new_description)
					errors_table.Remove (a_code)
					errors_table.Add (a_code, new_description_array)
				end
			end
		ensure
			decription_replaced: error_description (a_code).Equals_String (new_description)
		end

feature {NONE} -- Implementation

	fill_errors_table is
			-- Fill error table with codes, names and messages defined in `ERROR_MESSAGES'.
		indexing
			external_name: "FillErrorsTable"
		require
			non_void_errors_table: errors_table /= Void
		do
			add_error (1, Write_lock_found_during_storage_name, Write_lock_found_during_storage_description)
			add_error (2, Read_lock_found_during_storage_name, Read_lock_found_during_storage_description)
			add_error (3, Write_lock_creation_failed_name, Write_lock_creation_failed_description)
			add_error (4, Assembly_directory_creation_failed_name, Assembly_directory_creation_failed_description)
			add_error (5, Xml_file_creation_failed_name, Xml_file_creation_failed_description)
			add_error (6, Xml_file_opening_failed_name, Xml_file_opening_failed_description)
			add_error (7, Empty_XML_file_name, Empty_XML_file_description)
			add_error (8, Write_lock_found_during_retrieval_name, Write_lock_found_during_retrieval_description)
			add_error (9, Read_lock_found_during_retrieval_name, Read_lock_found_during_retrieval_description)
			add_error (10, Read_lock_creation_failed_name, Read_lock_creation_failed_description)
			add_error (11, Write_lock_found_during_removal_name, Write_lock_found_during_removal_description)
			add_error (12, Read_lock_found_during_removal_name, Read_lock_found_during_removal_description)
			add_error (13, Invalid_assembly_qualified_name, Invalid_assembly_qualified_name_description)	
			add_error (14, Types_retrieval_failed_name, Types_retrieval_failed_description)	
		ensure
			errors_table_filled: errors_table.Count > 0
		end
		
invariant
	non_void_errors_table: errors_table /= Void
	
end -- end class ERRORS_TABLE
