indexing
	description: "Offset the "
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_TYPE_ID
	
feature -- Access

	assembly_id_offset: INTEGER is
			-- the assembly type id offset
		do
			Result := assembly_id_offset_cell.item
		end
		
	local_offset: INTEGER is 500000
		-- default offset value for local assemblies
		
	default_offset: INTEGER is 0
		-- default offset value for EAC assemblies
		
feature -- Status Setting

	set_assembly_id_offset (aoffset_value: INTEGER) is
			-- set assembly_id_offset to 'aoffset_value'
		do
			assembly_id_offset_cell.put (aoffset_value)
		end
		
feature {NONE} -- Implementation

	assembly_id_offset_cell: CELL[INTEGER] is
			-- 	the assembly type id offser
		once
			create Result.put (0)
		end

end -- class SHARED_TYPE_ID
