-- Real body ids.

class REAL_BODY_ID

inherit

	COMPILER_ID

creation

	make

feature -- Access

	generated_id: STRING is
			-- Textual representation of real body id
			-- used in generated C code
		do
			!! Result.make (5);
			Result.append_integer (id - 1)
		ensure
			generated_id_not_void: Result /= Void
		end

feature {NONE} -- Implementation

	counter: REAL_BODY_ID_SUBCOUNTER is
			-- Counter associated with the id
		once
			Result := Real_body_id_counter.item (Normal_compilation)
		end

end -- class REAL_BODY_ID
