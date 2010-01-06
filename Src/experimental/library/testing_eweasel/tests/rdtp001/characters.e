class
	CHARACTERS

feature

	from_c
		local
			c: CHARACTER
		do
			c := '%/000/'
			c := '%/0xAA/'
			c := '%/0c00/'
			c := '%/0b00/'
		end

feature -- Implementation

	new_string
		do
		end

end
