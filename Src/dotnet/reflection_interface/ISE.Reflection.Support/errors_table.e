indexing
	description: "Possible errors when using ISE reflection interface"
	external_name: "ISE.Reflection.ErrorsTable"
--	attribute: create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACEATTRIBUTE}.make_classinterfaceattribute (2) end

class
	ERRORS_TABLE

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `errors_table'.
		indexing
			external_name: "Make"
		do
			create errors_table.make
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
			valid_code: a_code >= 0 and errors_table.ContainsKey (a_code)
		local
			description_array: ARRAY [STRING]
		do
			description_array ?= errors_table.Item (a_code)	
			if description_array /= Void and then description_array.count = 2 then
				Result := description_array.item (0)
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
			valid_code: a_code >= 0 and errors_table.ContainsKey (a_code)
		local
			description_array: ARRAY [STRING]
		do
			description_array ?= errors_table.Item (a_code)	
			if description_array /= Void and then description_array.count = 2 then
				Result := description_array.item (1)
			end
		ensure
			error_description_found: Result /= Void
			not_empty_error_description: Result.Length > 0
		end

	error_info (a_code: INTEGER): ERROR_INFO is
			-- Error info from `a_code'
		indexing
			external_name: "ErrorInfo"
		require
			valid_code: a_code >= 0 and errors_table.ContainsKey (a_code)
		local
			description_array: ARRAY [STRING]
			a_name: STRING
			a_description: STRING
		do
			description_array ?= errors_table.Item (a_code)	
			if description_array /= Void and then description_array.count = 2 then
				a_name := description_array.item (0)
				a_description := description_array.item (1)
				create Result.make (a_code, a_name, a_description)
			end
		ensure
			error_info_created: Result /= Void
		end

	errors: SYSTEM_COLLECTIONS_ARRAYLIST is
			-- Errors currently in `errors_table'
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [ERROR_INFO]
		indexing
			external_name: "Errors"
		local
			enumerator: SYSTEM_COLLECTIONS_IENUMERATOR
			a_code: INTEGER
			added: INTEGER
			moved: BOOLEAN
		do
			enumerator := errors_table.keys.getenumerator
			from
				create Result.make
			until
				not enumerator.movenext
			loop
				a_code ?= enumerator.current_
				added := Result.add (error_info (a_code))	
				moved := enumerator.movenext
			end
		ensure
			errors_created: Result /= Void
		end
		
feature -- Basic Operations

	add_error (an_error: ERROR_INFO) is
			-- Add `an_error' to `errors_table'.
		indexing
			external_name: "AddError"
		require
			non_void_error: an_error /= Void
			not_in_table: not errors_table.containskey (an_error.code)
		local
			description_array: ARRAY [STRING]
		do
			create description_array.make (2)
			description_array.put (0, an_error.name)
			description_array.put (1, an_error.description)
			errors_table.Add (an_error.code, description_array)
		ensure
			error_added: errors_table.containskey (an_error.code)
			table_updated: errors_table.count = old errors_table.count + 1
		end
	
	replace_error_name (a_code: INTEGER; new_name: STRING) is
			-- Replace error name corresponding to `a_code' with `new_name'.
		indexing
			external_name: "ReplaceErrorName"
		require
			valid_code: a_code >= 0 and errors_table.containskey (a_code)
			non_void_new_name: new_name /= Void
			not_empty_new_name: new_name.Length > 0
		local
			description_array: ARRAY [STRING]
			new_description_array: ARRAY [STRING]
		do
			description_array ?= errors_table.Item (a_code)	
			if description_array /= Void and then description_array.count = 2 then
				create new_description_array.make (2)
				new_description_array.put (0, new_name)
				new_description_array.put (1, description_array.item (1))
				errors_table.Remove (a_code)
				errors_table.Add (a_code, new_description_array)
			end
		ensure
			name_replaced: error_name (a_code).Equals_String (new_name)
		end

	replace_error_description (a_code: INTEGER; new_description: STRING) is
			-- Replace error description corresponding to `a_code' with `new_description'.
		indexing
			external_name: "ReplaceErrorDescription"
		require
			valid_code: a_code >= 0 and errors_table.ContainsKey (a_code)
			non_void_new_description: new_description /= Void
			not_empty_new_description: new_description.Length > 0
		local
			description_array: ARRAY [STRING]
			new_description_array: ARRAY [STRING]
		do
			description_array ?= errors_table.Item (a_code)	
			if description_array /= Void and then description_array.count = 2 then
				create new_description_array.make (2)
				new_description_array.put (0, description_array.item (0))
				new_description_array.put (1, new_description)
				errors_table.Remove (a_code)
				errors_table.Add (a_code, new_description_array)
			end
		ensure
			decription_replaced: error_description (a_code).Equals_String (new_description)
		end
	
	remove_error (a_code: INTEGER) is
			-- Remove error corresponding to `a_code' from `errors_table'.
		indexing
			external_name: "RemoveError"
		require
			valid_code: a_code >= 0 and errors_table.containskey (a_code)
		do
			errors_table.remove (a_code)
		ensure
			error_removed: not errors_table.containskey (a_code)
		end
		
invariant
	non_void_errors_table: errors_table /= Void
	
end -- end class ERRORS_TABLE
