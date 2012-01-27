class CHARACTER_32

feature -- Access

	code: INTEGER
			-- Associated integer value
		do
			Result := Precursor
		end

	natural_32_code: NATURAL_32
			-- Associated integer value
		do
			Result := Precursor
		end

feature -- Conversion

	to_character_8: CHARACTER_8
			-- Convert current to CHARACTER_8
		do
			Result := Precursor
		end

end
