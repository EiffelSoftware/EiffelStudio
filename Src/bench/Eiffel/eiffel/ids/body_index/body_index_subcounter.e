-- Body index counter associated with a compilation unit.

class BODY_INDEX_SUBCOUNTER

inherit

	COMPILER_SUBCOUNTER
			
creation

	make

feature -- Access

	next_id: BODY_INDEX is
			-- Next body index
		do
			count := count + 1;
			!! Result.make (count)
		end

end -- class BODY_INDEX_SUBCOUNTER
