class SHARED_ID_TABLES

inherit
	SHARED_WORKBENCH
	
feature {NONE}

	Body_index_table: ARRAY [INTEGER] is
			-- Table of correspondance of between generic body indexes
			-- and generic body ids
		once
			Result := System.body_index_table
		end;

	Original_body_index_table: ARRAY [INTEGER] is
			-- Table of original coresspondances
			-- | The principle is to copy a duplication of `Body_index_table'
			-- | each time a recompilation is done if not in error. Then
			-- | the second pass can use it for comparing old feature
			-- | versions and new ones.
		once
			Result := System.original_body_index_table;
		end;

end
