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
			-- Initialization
		do
			check 
				False
			end
		ensure
			assemblies_not_void: exists implies assemblies /= Void
		end

feature -- Access

	exists: BOOLEAN is
			-- Does interface exist?
		do
			check
				False
			end
		end

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
			-- Move cursor to 'i_th' position
		require
			exists: exists
		do 
			check 
				False
			end
		end

	start is
			-- Move cursor to start of assembly list
		require
			exists: exists
		do
			check 
				False
			end
		end
		
	forth is
			-- Move cursor to next assembly
		require
			exists: exists
		do
			check 
				False
			end
		end
		
feature -- Status Report

	after: BOOLEAN is
			-- Is there no valid position to the right of the cursor
		require
			exists: exists
		do
			check 
				False
			end
		end
		
	signed (a_loc: STRING): BOOLEAN is
			-- Is assembly at 'a_loc' signed?
		require
			location_not_void: a_loc /= Void
			location_not_empty: not a_loc.string.is_empty
			exists: exists
		do
			check 
				False
			end
		end
		
	get_assembly_info_from_assembly (a_loc: STRING) is
			-- Retrieve assembly information structure for assembly at
			-- location 'a_loc' and make 'item' result
		require
			location_not_void: a_loc /= Void
			location_not_empty: not a_loc.string.is_empty
			exists: exists
		do
			check 
				False
			end
		end

end -- class IL_ASSEMBLY_FACADE

