-- Real body id counter associated with a compilation unit.

class REAL_BODY_ID_SUBCOUNTER

inherit

	COMPILER_SUBCOUNTER
			
creation

	make

feature -- Access

	next_id: REAL_BODY_ID is
			-- Next real body id
		do
			count := count + 1;
			!! Result.make (count)
		end

end -- class REAL_BODY_ID_SUBCOUNTER
