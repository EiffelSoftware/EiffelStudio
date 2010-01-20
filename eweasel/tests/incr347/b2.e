class B

feature -- Access

	value: D
 		do
			create Result
		ensure
			is_valid (value)
		end

feature -- Status Report

	is_valid (v: like value): BOOLEAN
		do
		end

end
