indexing
	description: "Errors that can occur during assembly consumption"
	date: "$Date$"
	revision: "$Revision$"

class
	ASSEMBLY_CONSUMPTION_ERRORS

inherit
	ERROR_MANAGER

feature -- Access

	Error_category: INTEGER_8 is 0x04
			-- Error category

	Serialization_error: INTEGER is 0x04000001
			-- Error occured during serialization

	Assembly_not_found_error: INTEGER is 0x04000002
			-- Assembly not found

	Type_initialization_error: INTEGER is 0x04000003
			-- Type initialization error


feature {NONE} -- Implementation

	error_message_table: HASH_TABLE [STRING, INTEGER] is
			-- Error messages
		once
			create Result.make (3)
			Result.put ("Could not serialize assembly", Serialization_error)
			Result.put ("Could not find assembly", Assembly_not_found_error)
			Result.put ("Could not serialize type.%NThis is usually due to an implementation problem in one of its features, or a missing resource.", Type_initialization_error)
		end
		
end -- class ASSEMBLY_CONSUMPTION_ERRORS
