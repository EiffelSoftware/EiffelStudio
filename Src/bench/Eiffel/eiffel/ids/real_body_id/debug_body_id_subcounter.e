-- Supermelted real body id counter associated with a compilation unit.

class DEBUG_BODY_ID_SUBCOUNTER

inherit

	REAL_BODY_ID_SUBCOUNTER
		redefine
			next_id
		end
			
creation

	make

feature -- Access

	next_id: DEBUG_BODY_ID is
			-- Next real body id
		do
			count := count + 1;
			!! Result.make (count)
		end

end -- class DEBUG_BODY_ID_SUBCOUNTER
