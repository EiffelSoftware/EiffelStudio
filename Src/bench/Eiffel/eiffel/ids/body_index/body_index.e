-- Body indexes.

class BODY_INDEX

inherit

	COMPILER_ID

creation

	make

feature {NONE} -- Implementation

	counter: BODY_INDEX_SUBCOUNTER is
			-- Counter associated with the id
		do
			Result := System.body_index_counter.item (compilation_id)
		end

end -- class BODY_INDEX
