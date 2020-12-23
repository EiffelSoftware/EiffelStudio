class B

convert

	as_a: {A}

feature -- Conversion

	as_a: A
			-- Convert `Current` to {A}.
		do
			create Result
		end

end