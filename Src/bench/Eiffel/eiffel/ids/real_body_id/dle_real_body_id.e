-- DC-set real body ids

class DLE_REAL_BODY_ID

inherit

	DLE_COMPILER_ID;
	REAL_BODY_ID
		undefine
			is_dynamic, compilation_id
		redefine
			counter
		end

creation

	make

feature {NONE} -- Implementation
 
	counter: REAL_BODY_ID_SUBCOUNTER is
			-- Counter associated with the id
		once
			Result := Real_body_id_counter.item (Dle_compilation)
		end

end -- class DLE_REAL_BODY_ID
