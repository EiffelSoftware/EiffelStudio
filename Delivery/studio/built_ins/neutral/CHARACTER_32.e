class CHARACTER_32

feature -- Access

	code: INTEGER is
			-- Associated integer value
		do
			Result := Precursor
		end

	natural_32_code: NATURAL_32 is
			-- Associated integer value
		do
			Result := Precursor
		end

feature -- Conversion

	to_character_8: CHARACTER_8 is
			-- Convert current to CHARACTER_8
		do
			Result := Precursor
		end

end
