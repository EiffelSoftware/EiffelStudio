indexing
	description: "COM Interface errors"
	date: "$Date$"
	revision: "$Revision$"

class
	CACHE_MANAGER_ERRORS

inherit
	ERROR_MANAGER

feature -- Access

	Error_category: INTEGER_8 is 0x05
	
	Cannot_load_assembly: INTEGER is 0x02000003

feature {NONE} -- Implementation

	error_message_table: HASH_TABLE [STRING, INTEGER] is
			-- Error messages
		once
			create Result.make (2)
			Result.put ("Cannot load assembly. Check the assembly is present at the specified path, and check assembly all dependancies.", Cannot_load_assembly)
		end
		
end -- class CACHE_MANAGER_ERRORS
