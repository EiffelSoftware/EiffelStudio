indexing
	description: "Provides access to IL assembly information, i.e the GAC and local assemblies"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IL_ASSEMBLY_FACADE
	
create
	make

feature	-- Initialization

	make is
			-- Initialize the assembly interface information
		check 
			False
		end
		
	initialize is
			-- 
		check 
			False
		end

feature -- Access

	assembly_name: STRING is
			-- Name of assembly at 'item'
		check
			False
		end
	
	assembly_version: STRING is
			-- Version number of assembly at 'item'
		check
			False
		end
	
	assembly_culture: STRING is
			-- Culture/locale of assembly at 'item'
		check
			False
		end
	
	assembly_public_key_token: STRING is
			-- Public key of assembly at 'item'
		check
			False
		end

feature -- Cursor Movement

	start is
			-- Move cursor to start of assembly list
		check 
			False
		end
		
	forth is
			-- Move cursor to next assembly
		check 
			False
		end
		
feature -- Status Report

	after: BOOLEAN is
			-- Is there no valid position to the right of the cursor
		check 
			False
		end
		
	signed (a_loc: STRING): BOOLEAN is
			-- Is assembly at 'a_loc' signed?
		check 
			False
		end
		
	get_assembly_info_from_assembly (a_loc: STRING) is
			-- Retrieve assembly information structure for assembly at
			-- location 'a_loc' and make 'item' result
		check 
			False
		end

end -- class IL_ASSEMBLY_FACADE

