indexing
	description: "Object in which a block of data from another launched process is stored"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_PROCESS_IO_DATA_BLOCK

inherit
	ANY
		export
			{ANY} deep_twin
		end

feature -- State reporting

	data: ANY is
			-- 
		deferred
		end	
		
	string_representation: STRING is
			-- 
		deferred
		end
		
	
	count: INTEGER
		-- Length of stored data in bytes.
				
	is_error: BOOLEAN
		-- Does data stored in `structured_image' come from error stream of process?
	
	is_end: BOOLEAN
		-- Does it the last block of data?
end
