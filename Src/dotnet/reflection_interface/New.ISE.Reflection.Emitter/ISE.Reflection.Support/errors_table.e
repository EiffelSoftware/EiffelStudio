indexing
	description: "Possible errors when using ISE reflection interface"
--	attribute: create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACEATTRIBUTE}.make_classinterfaceattribute (2) end

class
	ERRORS_TABLE

create
	make

feature {NONE} -- Initialization

	make is
		indexing
			description: "Initialize `errors_table'."
		do
			create errors_table.make (0)
		ensure
			errors_table_created: errors_table /= Void
		end
		
feature -- Access
	
	errors_table: HASH_TABLE [ARRAY [STRING], INTEGER]
			-- | Key: error code
			-- | Value: [error name, error description]
			-- | (ARRAY [STRING])
		indexing
			description: "Errors table"
		end

	error_name (a_code: INTEGER): STRING is
		indexing
			description: "Error name corresponding to `a_code'"
		require
			valid_code: a_code >= 0 and errors_table.has (a_code)
		local
			description_array: ARRAY [STRING]
		do
			description_array ?= errors_table.item (a_code)	
			if description_array /= Void and then description_array.count = 2 then
				Result := description_array.item (0)
			end
		ensure
			error_name_found: Result /= Void
			not_empty_error_name: Result.count > 0
		end

	error_description (a_code: INTEGER): STRING is
		indexing
			description: "Error name corresponding to `a_code'"
		require
			valid_code: a_code >= 0 and errors_table.has (a_code)
		local
			description_array: ARRAY [STRING]
		do
			description_array ?= errors_table.item (a_code)	
			if description_array /= Void and then description_array.count = 2 then
				Result := description_array.item (1)
			end
		ensure
			error_description_found: Result /= Void
			not_empty_error_description: Result.count > 0
		end

	error_info (a_code: INTEGER): ERROR_INFO is
		indexing
			description: "Error info from `a_code'"
		require
			valid_code: a_code >= 0 and errors_table.has (a_code)
		local
			description_array: ARRAY [STRING]
			a_name: STRING
			a_description: STRING
		do
			description_array ?= errors_table.item (a_code)	
			if description_array /= Void and then description_array.count = 2 then
				a_name := description_array.item (0)
				a_description := description_array.item (1)
				create Result.make (a_code, a_name, a_description)
			end
		ensure
			error_info_created: Result /= Void
		end

	errors: LINKED_LIST [ERROR_INFO] is
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [ERROR_INFO]
		indexing
			description: "Errors currently in `errors_table'"
		require
			not_empty_errors_table: errors_table.count > 0
		local
			a_code: INTEGER
			added: INTEGER
		do
			from
				create Result.make
				errors_table.start
			until
				errors_table.after
			loop
				Result.extend (error_info(errors_table.key_for_iteration))	
				errors_table.forth
			end
		ensure
			errors_created: Result /= Void
		end
		
feature -- Basic Operations

	add_error (an_error: ERROR_INFO) is
		indexing
			description: "Add `an_error' to `errors_table'."
		require
			non_void_error: an_error /= Void
			not_in_table: not errors_table.has (an_error.code)
		local
			description_array: ARRAY [STRING]
		do
			create description_array.make (0, 1)
			description_array.put (an_error.name, 0)
			description_array.put (an_error.description, 1)
			errors_table.extend (description_array, an_error.code)
		ensure
			error_added: errors_table.has (an_error.code)
			table_updated: errors_table.count = old errors_table.count + 1
		end
	
	replace_error_name (a_code: INTEGER; new_name: STRING) is
		indexing
			description: "Replace error name corresponding to `a_code' with `new_name'."
		require
			valid_code: a_code >= 0 and errors_table.has (a_code)
			non_void_new_name: new_name /= Void
			not_empty_new_name: new_name.count > 0
		local
			description_array: ARRAY [STRING]
			new_description_array: ARRAY [STRING]
		do
			description_array ?= errors_table.item (a_code)	
			if description_array /= Void and then description_array.count = 2 then
				create new_description_array.make (0, 1)
				new_description_array.put (new_name, 0)
				new_description_array.put (description_array.item (1), 1)
				errors_table.Remove (a_code)
				errors_table.extend ( new_description_array, a_code)
			end
		ensure
			name_replaced: error_name (a_code).is_equal (new_name)
		end

	replace_error_description (a_code: INTEGER; new_description: STRING) is
		indexing
			description: "Replace error description corresponding to `a_code' with `new_description'."
		require
			valid_code: a_code >= 0 and errors_table.has (a_code)
			non_void_new_description: new_description /= Void
			not_empty_new_description: new_description.count > 0
		local
			description_array: ARRAY [STRING]
			new_description_array: ARRAY [STRING]
		do
			description_array ?= errors_table.item (a_code)	
			if description_array /= Void and then description_array.count = 2 then
				create new_description_array.make (0, 1)
				new_description_array.put (description_array.item (0), 0)
				new_description_array.put (new_description, 1)
				errors_table.Remove (a_code)
				errors_table.extend (new_description_array, a_code)
			end
		ensure
			decription_replaced: error_description (a_code).is_equal (new_description)
		end
	
	remove_error (a_code: INTEGER) is
		indexing
			description: "Remove error corresponding to `a_code' from `errors_table'."
		require
			valid_code: a_code >= 0 and errors_table.has (a_code)
		do
			errors_table.remove (a_code)
		ensure
			error_removed: not errors_table.has (a_code)
		end
		
invariant
	non_void_errors_table: errors_table /= Void
	
end -- end class ERRORS_TABLE
