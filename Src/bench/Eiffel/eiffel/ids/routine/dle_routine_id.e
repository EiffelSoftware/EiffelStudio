-- DC-set Routine Ids

class DLE_ROUTINE_ID

inherit

	DLE_COMPILER_ID;
	ROUTINE_ID
		undefine
			is_dynamic, compilation_id
		redefine
			counter, prefix_name
		end

creation

	make

feature {NONE} -- Implementation
 
	counter: ROUTINE_SUBCOUNTER is
			-- Counter associated with the id
		once
			Result := Routine_id_counter.item (Dle_compilation)
		end;
 
	prefix_name: STRING is
			-- Prefix for generated C function and table names
		once
			Result := counter.prefix_name
		end

end -- class DLE_ROUTINE_ID
