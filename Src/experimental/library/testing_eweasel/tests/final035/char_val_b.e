class
	CHAR_VAL_B

inherit
	TYPED_INTERVAL_VAL_B [CHARACTER]

feature

	type_of_interval: STRING is
		do
			Result := "CHARACTER%N"
		end

end

