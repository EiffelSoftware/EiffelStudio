indexing
	description: "Assembly ids mapping"
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_ASSEMBLY_MAPPING

feature -- Access

	assembly_mapping: HASH_TABLE [INTEGER, STRING] is
			-- Assembly id keyed by assembly full name
		do
			Result := assembly_mapping_cell.item
		end

	referenced_type_from_type (t: SYSTEM_TYPE): CONSUMED_REFERENCED_TYPE is
			-- Consumed type from `t'
		require
			non_void_type: t /= Void
		local
			l_name: STRING
			am: like assembly_mapping
		do
			if t.is_by_ref then
				Result := referenced_type_from_type (t.get_element_type)
				Result.set_is_by_ref
			else
				am := assembly_mapping
				am.search (t.assembly.full_name)
				if am.found then
					l_name := t.full_name
					if t.is_array then
						create {CONSUMED_ARRAY_TYPE} Result.make (
							l_name, am.found_item,
							referenced_type_from_type (t.get_element_type))
					else
						create Result.make (l_name,
							am.found_item)
					end
				end
			end
		end
		
feature -- Basic Operations

	reset_assembly_mapping is
			-- Reset assembly mapping
		do
			assembly_mapping_cell.put (create {HASH_TABLE [INTEGER, STRING]}.make (20))
		end

feature {NONE} -- Implementation

	assembly_mapping_cell: CELL [HASH_TABLE [INTEGER, STRING]] is
		once
			create Result.put (create {HASH_TABLE [INTEGER, STRING]}.make (20))
		end
		
end -- class SHARED_ASSEMBLY_MAPPING
