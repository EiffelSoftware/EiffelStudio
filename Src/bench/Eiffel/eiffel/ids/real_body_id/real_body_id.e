-- Real body ids.

class REAL_BODY_ID

inherit

	COMPILER_ID

creation

	make

feature {NONE} -- Implementation

	counter: REAL_BODY_ID_SUBCOUNTER is
			-- Counter associated with the id
		do
			Result := System.execution_table.counter.item (compilation_id)
		end

end -- class REAL_BODY_ID
