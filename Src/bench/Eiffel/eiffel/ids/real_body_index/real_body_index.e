-- Real body indexes.

class REAL_BODY_INDEX

inherit

	COMPILER_ID

creation

	make

feature {NONE} -- Implementation

	counter: REAL_BODY_INDEX_SUBCOUNTER is
			-- Counter associated with the id
		do
			Result := System.dispatch_table.counter.item (compilation_id)
		end

end -- class REAL_BODY_INDEX
