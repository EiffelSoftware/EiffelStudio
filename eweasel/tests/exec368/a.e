class A

inherit
	C

convert
	to_b: {B}

feature {NONE} -- Conversion

	to_b: B
			-- Convert to {B}.
		do
			create Result
		end

end
