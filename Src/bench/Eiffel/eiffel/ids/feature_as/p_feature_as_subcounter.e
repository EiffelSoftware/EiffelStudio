-- FEATURE_AS counter associated with a precompilation.

class P_FEATURE_AS_SUBCOUNTER

inherit

	P_COMPILER_SUBCOUNTER
	FEATURE_AS_SUBCOUNTER
		rename
			make as csc_make
		redefine
			next_id
		end

creation

	make

feature -- Access

	next_id: P_FEATURE_AS_ID is
			-- Next FEATURE_AS id
		do
			count := count + 1;
			!! Result.make (count, compilation_id)
		end

end -- class P_FEATURE_AS_SUBCOUNTER
