class TEST_HELPER

feature -- Access

	exceptions: EXCEPTIONS is
			-- An instance of a class EXCEPTIONS
		once
			create Result
		ensure
			Result /= Void
		end

	raised (s: STRING): BOOLEAN is
			-- A function that raises a developer exception
			-- with a given message `s'; it cannot be implemented
			-- in `TEST_...' because it can misbehave
			-- when `default_rescue' is redefined
		do
			exceptions.raise (s)
		end

end