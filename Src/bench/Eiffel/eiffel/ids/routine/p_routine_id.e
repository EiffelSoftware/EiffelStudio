-- Precompiled Routine Ids

class P_ROUTINE_ID

inherit

	P_COMPILER_ID;
	ROUTINE_ID
		rename
			make as make_id
		undefine
			compilation_id, is_precompiled
		redefine
			counter, prefix_name
		end

creation

	make

feature {NONE} -- Implementation
 
	counter: ROUTINE_SUBCOUNTER is
			-- Counter associated with the id
		do
			Result := Routine_id_counter.item (compilation_id)
		end;
 
	prefix_name: STRING is
			-- Prefix for generated C function and table names
		do
			Result := counter.prefix_name
		end

end -- class P_ROUTINE_ID
