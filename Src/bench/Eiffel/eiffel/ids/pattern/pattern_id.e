-- Pattern ids

class PATTERN_ID

inherit

	COMPILER_ID

creation

	make

feature {NONE} -- Implementation

	counter: PATTERN_ID_SUBCOUNTER is
			-- Counter associated with the id
		once
			Result := Pattern_id_counter.item (Normal_compilation)
		end

end -- class PATTERN_ID
