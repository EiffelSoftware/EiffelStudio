-- Pattern ids

class PATTERN_ID

inherit

	COMPILER_ID;
	SHARED_PATTERN_TABLE

creation

	make

feature {NONE} -- Implementation

	counter: PATTERN_ID_SUBCOUNTER is
			-- Counter associated with the id
		do
			Result := Pattern_table.pattern_id_counter.item (compilation_id)
		end

end -- class PATTERN_ID
