class CHARACTER_8

feature -- Access

	code: INTEGER
			-- Associated integer value
		do
			Result := Precursor
		end

feature -- Conversion

	to_character_32: CHARACTER_32
			-- Associated character in 32 bit version.
		do
			Result := Precursor
		end

end
