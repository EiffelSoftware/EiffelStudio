-- Precompiled pattern ids

class P_PATTERN_ID

inherit

	P_COMPILER_ID;
	PATTERN_ID
		rename
			make as make_id
		undefine
			compilation_id, is_precompiled
		redefine
			counter
		end

creation

	make

feature {NONE} -- Implementation
 
	counter: PATTERN_ID_SUBCOUNTER is
			-- Counter associated with the id
		do
			Result := Pattern_id_counter.item (compilation_id)
		end

end -- class P_PATTERN_ID
