indexing
	description: "Assembly ids mapping"
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_ASSEMBLY_MAPPING
	
inherit
	SHARED_TYPE_ID
		export
			{NONE} all
		end

feature -- Access

	assembly_mapping: HASH_TABLE [INTEGER, STRING] is
			-- Assembly id keyed by assembly full name
		do
			Result := assembly_mapping_cell.item
		end

	referenced_type_from_type (t: TYPE): CONSUMED_REFERENCED_TYPE is
			-- Consumed type from `t'
		require
			non_void_type: t /= Void
		local
			name: STRING
			l_name: SYSTEM_STRING
			am: like assembly_mapping
		do
			if t.get_is_by_ref then
				Result := referenced_type_from_type (t.get_element_type)
			else
				create name.make_from_cil (t.get_assembly.to_string)
				am := assembly_mapping
				am.search (name)
				if am.found then
					if t.get_is_array then
						l_name := t.get_full_name
						create {CONSUMED_ARRAY_TYPE} Result.make (
							create {STRING}.make_from_cil (t.get_full_name),
							am.found_item + assembly_id_offset,
							referenced_type_from_type (t.get_element_type))
					else
						create Result.make (create {STRING}.make_from_cil (t.get_full_name),
							am.found_item + assembly_id_offset)
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
