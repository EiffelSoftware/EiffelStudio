-- Precompiled body indexes.

class P_BODY_INDEX

inherit

	P_COMPILER_ID;
	BODY_INDEX
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

	counter: BODY_INDEX_SUBCOUNTER is
			-- Counter associated with the id
		do
			Result := Body_index_counter.item (compilation_id)
		end

end -- class P_BODY_INDEX
