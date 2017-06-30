class B

inherit
	C

convert
	to_a: {A}

feature {NONE} -- Conversion

	to_a: A
			-- Convert to {A}.
		do
			create Result
		end

end
