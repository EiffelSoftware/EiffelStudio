-- Real body indexes.

class REAL_BODY_INDEX

inherit

	COMPILER_ID

creation

	make

feature -- Access

	generated_id (buffer: GENERATION_BUFFER) is
			-- Generate textual representation of real body index
			-- in generated C code
		do
			buffer.putint (id - 1)
		end

feature {NONE} -- Implementation

	counter: REAL_BODY_INDEX_SUBCOUNTER is
			-- Counter associated with the id
		once
			Result := Real_body_index_counter.item (Normal_compilation)
		end

end -- class REAL_BODY_INDEX
