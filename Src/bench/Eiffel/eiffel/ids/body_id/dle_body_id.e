-- DC-set body Ids

class DLE_BODY_ID

inherit

	DLE_COMPILER_ID;
	BODY_ID
		undefine
			is_dynamic, compilation_id
		redefine
			counter
		end

creation

	make

feature {NONE} -- Implementation

	counter: BODY_ID_SUBCOUNTER is
			-- Counter associated with the id
		once
			Result := Body_id_counter.item (Dle_compilation)
		end

end -- class DLE_BODY_ID
