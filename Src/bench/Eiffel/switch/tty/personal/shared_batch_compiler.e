class SHARED_BATCH_COMPILER

feature

	start_batch_compiler is
			-- Start the compilation in batch mode from the bench executable
		local
			compiler: BASIC_ES
		do
			!!compiler.make_unlicensed
		end

end

