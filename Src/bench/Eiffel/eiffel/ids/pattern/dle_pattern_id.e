-- DC-set pattern ids.

class DLE_PATTERN_ID

inherit

	DLE_COMPILER_ID;
	PATTERN_ID
		undefine
			is_dynamic, compilation_id
		redefine
			counter
		end

creation

	make

feature {NONE} -- Implementation
 
	counter: PATTERN_ID_SUBCOUNTER is
			-- Counter associated with the id
		once
			Result := Pattern_id_counter.item (Dle_compilation)
		end

end -- class DLE_PATTERN_ID
