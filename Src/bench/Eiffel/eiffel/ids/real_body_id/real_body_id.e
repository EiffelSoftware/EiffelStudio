-- Real body ids.

class REAL_BODY_ID

inherit

	COMPILER_ID

creation

	make

feature -- Access

	generated_id (buffer: GENERATION_BUFFER) is
			-- Generate textual representation of real body id
			-- in generated C code
		do
			buffer.putint (id - 1)
		end

feature {NONE} -- Implementation

	counter: REAL_BODY_ID_SUBCOUNTER is
			-- Counter associated with the id
		once
			Result := Real_body_id_counter.item (Normal_compilation)
		end

end -- class REAL_BODY_ID
