-- Class counter associated with a precompilation.

class P_CLASS_SUBCOUNTER

inherit

	P_COMPILER_SUBCOUNTER
	CLASS_SUBCOUNTER
		rename
			make as csc_make
		redefine
			next_id, next_protected_id
		end

creation

	make

feature -- Access

	next_id: P_CLASS_ID is
			-- Next class id
		do
			count := count + 1;
			!! Result.make (count, compilation_id)
		end

	 next_protected_id: P_CLASS_ID is
			-- Next protected class id
		do
			count := count + 1;
			!P_PROTECTED_CLASS_ID! Result.make (count, compilation_id)
		end

end -- class P_CLASS_SUBCOUNTER
