-- Pattern id counter associated with a compilation unit.

class PATTERN_ID_SUBCOUNTER

inherit

	COMPILER_SUBCOUNTER
			
creation

	make

feature -- Access

	next_id: PATTERN_ID is
			-- Next pattern id
		do
			count := count + 1;
			!! Result.make (count)
		end

end -- class PATTERN_ID_SUBCOUNTER
