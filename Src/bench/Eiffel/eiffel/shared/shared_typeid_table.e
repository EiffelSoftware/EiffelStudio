-- Access to a correpondance table of new type id and old type id: it is
-- useful since the generation of routine table for the final executable
-- re-process the type ids in order to be sure to take the minimum
-- space in the memory of the executable

class SHARED_TYPEID_TABLE
	
feature {NONE}

	Type_id_table: ARRAY [INTEGER] is
			-- Correpondance of type id: index the old one, output
			-- the new one.
		once
			create Result.make (1, 1);
		end;

end
