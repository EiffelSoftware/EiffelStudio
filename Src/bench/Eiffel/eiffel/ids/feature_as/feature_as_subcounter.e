-- FEATURE_AS id counter associated with a compilation unit.

class FEATURE_AS_SUBCOUNTER

inherit

	COMPILER_SUBCOUNTER
			
creation

	make

feature -- Access

	next_id: FEATURE_AS_ID is
			-- Next FEATURE_AS id
		do
			count := count + 1;
			!! Result.make (count)
		end

end -- class FEATURE_AS_SUBCOUNTER
