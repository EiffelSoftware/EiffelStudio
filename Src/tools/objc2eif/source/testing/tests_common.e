note
	description: "Summary description for {TESTS_COMMON}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TESTS_COMMON

feature -- Running

	run
			-- Run the tests
		do
			print ("%NRunning " + generating_type.name + " test...%N")
		end

feature -- Clean up

	collect_garbage
			-- Start a full garbage collector cycle
		local
			memory: MEMORY
		do
			create memory
			memory.full_collect
		end

feature {NONE} -- Implementation

	assert (expression: BOOLEAN)
			-- Raise an exception if expression is `False'.
		do
			check expression end
		end

end
