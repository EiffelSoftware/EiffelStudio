class
	A

feature {TEST} -- Execution

	f
			-- The routine triggers an exception.
		do
		ensure
			false
		end

end