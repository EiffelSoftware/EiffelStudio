indexing
	description: "ID associated to a type CONSUMED_..."

class
	TYPE_NAME_ID

feature {NONE} -- Implementation

	types: ARRAY [STRING] is
			-- types to be serialized.
		once
			create Result.make (1, 19)
			Result.put ("CONSUMED_TYPE", 1)
			Result.put ("CONSUMED_PROPERTY", 2)
			Result.put ("CONSUMED_EVENT", 3)
			Result.put ("CONSUMED_PROCEDURE", 4)
			Result.put ("CONSUMED_FUNCTION", 5)
			Result.put ("CONSUMED_ARGUMENT", 6)
			Result.put ("CONSUMED_REFERENCED_TYPE", 7)
			Result.put ("CONSUMED_ASSEMBLY", 8)
			Result.put ("CACHE_INFO", 9)
			Result.put ("CONSUMED_CONSTRUCTOR", 10)
			Result.put ("CONSUMED_ASSEMBLY_INFO", 11)
			Result.put ("CONSUMED_FIELD", 12)
			Result.put ("CONSUMED_ASSEMBLY_TYPES", 13)
			Result.put ("CONSUMED_ASSEMBLY_MAPPING", 14)
			Result.put ("CONSUMED_ARRAY_TYPE", 15)
			Result.put ("STRING", 16)
			Result.put ("NONE", 17)
			Result.put ("CONSUMED_NESTED_TYPE", 18)
			Result.put ("CONSUMED_LITERAL_FIELD", 19)
		ensure
			non_void_types: Result /= Void
		end

	type_from_id (an_id: INTEGER): STRING is
			-- Type associated to `an_id'.
		require
			valid_id: Types.valid_index (an_id)
		do
			Result := types.item (an_id)
		ensure
			non_void_type: Result /= Void
			not_empty_type: not Result.is_empty
		end

	id_from_type (a_type: STRING): INTEGER is
			-- ID associated to `a_type'.
		require
			non_void_type: a_type /= Void
			type_exists: Types.has (a_type)
		do
			Result := Internal_id_type.item (a_type)
		ensure
			positive_id: Result > 0
		end

	internal_id_type: HASH_TABLE [INTEGER, STRING] is
		local
			i: INTEGER
		once
			from
				i := 1
				create Result.make (types.count)
			until
				i > types.count
			loop
				Result.put (i, types.item (i))
				i := i + 1
			end
		ensure
			non_void_internal_id_type: Result /= Void
		end

end -- class TYPE_NAME_ID
