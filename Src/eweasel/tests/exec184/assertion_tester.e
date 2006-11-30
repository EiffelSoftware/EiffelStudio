class ASSERTION_TESTER

feature -- Status report

	failed: BOOLEAN
			-- Has test been failed?

feature -- Testing
	
	test (v: STRING): BOOLEAN is
			-- Test that once manifest string is always the same
			-- and record the result to `failed', then return true
		do
			count := count + 1
			if
				v = Void or else
				(count = 1 and then string /= Void) or else
				(count /= 1 and then string /= v)
			then
				failed := true
			end
			if count = 1 then
					-- Remember first string value
				string := v
			end
			Result := true
		end

feature {NONE} -- Data
	
	count: INTEGER
			-- How many times has `test' been called?

	string: STRING
			-- String passed to `test' for the first time

end