-- Real body index counter associated with a compilation unit.

class REAL_BODY_INDEX_SUBCOUNTER

inherit

	COMPILER_SUBCOUNTER
			
creation

	make

feature -- Access

	next_id: REAL_BODY_INDEX is
			-- Next real body index
		do
			count := count + 1;
			!! Result.make (count)
		end

end -- class REAL_BODY_INDEX_SUBCOUNTER
