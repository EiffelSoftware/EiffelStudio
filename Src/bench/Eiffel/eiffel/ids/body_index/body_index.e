-- Body indexes.

class BODY_INDEX

inherit

	COMPILER_ID

creation

	make

feature {NONE} -- Implementation

	counter: BODY_INDEX_SUBCOUNTER is
			-- Counter associated with the id
		once
			Result := Body_index_counter.item (Normal_compilation)
		end

end -- class BODY_INDEX
