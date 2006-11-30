class
	INT_VAL_B

inherit
	TYPED_INTERVAL_VAL_B [INTEGER]

feature

	type_of_interval: STRING is
		do
			Result := "INTEGER%N"
		end

end

