indexing
	description: "Eiffel Assembly Cache access errors"
	date: "$Date$"
	revision: "$Revision$"

class
	CACHE_ERRORS

inherit
	ERROR_MANAGER

feature -- Access

	Error_category: INTEGER_8 is 0x02
	
	Assembly_not_found_error: INTEGER is 0x02000001

	Consume_error: INTEGER is 0x02000002
	
	Remove_error: INTEGER is 0x02000003
	
	Not_in_eac_error: INTEGER is 0x02000004
	
	Update_error: INTEGER is 0x02000005
	
	Assembly_dependancies_not_found_error: INTEGER is 0x02000006

feature {NONE} -- Implementation

	error_message_table: HASH_TABLE [STRING, INTEGER] is
			-- Error messages
		once
			create Result.make (2)
			Result.put ("Could not find assembly", Assembly_not_found_error)
			Result.put ("Could not fully import assembly", Consume_error)
			Result.put ("Could not remove assembly from Eiffel Assembly Cache", Remove_error)
			Result.put ("Could not find assembly in Eiffel Assembly Cache", Not_in_eac_error)
			Result.put ("Could not update assembly", Update_error)
			Result.put ("Could not load one or more of assemblies dependancies", Assembly_dependancies_not_found_error)
		end
		
end -- class CACHE_ERRORS
