indexing
	description: "Objects that provide common access to global history"
	date: "$Date$"
	revision: "$Revision$"

class
	GB_SHARED_DIGIT_CHECKER


feature -- Access

	digit_checker: GB_DIGIT_CHECKER is
			-- Result is once access to a digit checker,
			-- used for determining if a digit key is currently held down.
		once
			create Result
		end

end -- class GB_SHARED_DIGIT_CHECKER
