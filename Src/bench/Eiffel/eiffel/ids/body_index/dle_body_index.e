-- DC-set body Indexes.

class DLE_BODY_INDEX

inherit

	DLE_COMPILER_ID;
	BODY_INDEX
		undefine
			is_dynamic, compilation_id
		redefine
			counter
		end

creation

	make

feature {NONE} -- Implementation

	counter: BODY_INDEX_SUBCOUNTER is
			-- Counter associated with the id
		once
			Result := Body_index_counter.item (Dle_compilation)
		end

end -- class DLE_BODY_INDEX
