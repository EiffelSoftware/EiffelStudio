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
		do
			check 
				False
			end
		end
		
	initialize is
			-- 
		do
			check 
				False
			end
		end

feature -- Access

	assembly_name: STRING is
			-- Name of assembly at 'item'
		do
			check
				False
			end
		end
	
	assembly_version: STRING is
			-- Version number of assembly at 'item'
		do
			check
				False
			end
		end
	
	assembly_culture: STRING is
			-- Culture/locale of assembly at 'item'
		do
			check
				False
			end
		end
	
	assembly_public_key_token: STRING is
			-- Public key of assembly at 'item'
		do
			check
				False
			end
		end

feature -- Cursor Movement

	go_i_th (i_th: INTEGER) is
		do 
			check 
				False
			end
		end

	start is
			-- Move cursor to start of assembly list
		do
			check 
				False
			end
		end
		
	forth is
			-- Move cursor to next assembly
		do
			check 
				False
			end
		end
		
feature -- Status Report

	after: BOOLEAN is
			-- Is there no valid position to the right of the cursor
		do
			check 
				False
			end
		end
		
	signed (a_loc: STRING): BOOLEAN is
			-- Is assembly at 'a_loc' signed?
		do
			check 
				False
			end
		end
		
	get_assembly_info_from_assembly (a_loc: STRING) is
			-- Retrieve assembly information structure for assembly at
			-- location 'a_loc' and make 'item' result
		do
			check 
				False
			end
		end

end -- class IL_ASSEMBLY_FACADE

