class TEST

create 
	make

feature {NONE} --Creation

	make is
			-- Run test.
		do
			show ("{ENUM_BOOL}.nul"  , <<{ENUM_BOOL}.nul.my_value  , {ENUM_BOOL}.nul.to_integer  , ({ENUM_BOOL}.nul).my_value  , ({ENUM_BOOL}.nul).to_integer  , enum_bool_nul.my_value  , enum_bool_nul.to_integer  >>)
			show ("{ENUM_BOOL}.one"  , <<{ENUM_BOOL}.one.my_value  , {ENUM_BOOL}.one.to_integer  , ({ENUM_BOOL}.one).my_value  , ({ENUM_BOOL}.one).to_integer  , enum_bool_one.my_value  , enum_bool_one.to_integer  >>)
			show ("{ENUM_BOOL}.min"  , <<{ENUM_BOOL}.min.my_value  , {ENUM_BOOL}.min.to_integer  , ({ENUM_BOOL}.min).my_value  , ({ENUM_BOOL}.min).to_integer  , enum_bool_min.my_value  , enum_bool_min.to_integer  >>)
			show ("{ENUM_BOOL}.max"  , <<{ENUM_BOOL}.max.my_value  , {ENUM_BOOL}.max.to_integer  , ({ENUM_BOOL}.max).my_value  , ({ENUM_BOOL}.max).to_integer  , enum_bool_max.my_value  , enum_bool_max.to_integer  >>)
			show ("{ENUM_CHAR}.nul"  , <<{ENUM_CHAR}.nul.my_value  , {ENUM_CHAR}.nul.to_integer  , ({ENUM_CHAR}.nul).my_value  , ({ENUM_CHAR}.nul).to_integer  , enum_char_nul.my_value  , enum_char_nul.to_integer  >>)
			show ("{ENUM_CHAR}.one"  , <<{ENUM_CHAR}.one.my_value  , {ENUM_CHAR}.one.to_integer  , ({ENUM_CHAR}.one).my_value  , ({ENUM_CHAR}.one).to_integer  , enum_char_one.my_value  , enum_char_one.to_integer  >>)
			show ("{ENUM_CHAR}.min"  , <<{ENUM_CHAR}.min.my_value  , {ENUM_CHAR}.min.to_integer  , ({ENUM_CHAR}.min).my_value  , ({ENUM_CHAR}.min).to_integer  , enum_char_min.my_value  , enum_char_min.to_integer  >>)
			show ("{ENUM_CHAR}.max"  , <<{ENUM_CHAR}.max.my_value  , {ENUM_CHAR}.max.to_integer  , ({ENUM_CHAR}.max).my_value  , ({ENUM_CHAR}.max).to_integer  , enum_char_max.my_value  , enum_char_max.to_integer  >>)
			show ("{ENUM_INT_8}.nul"  , <<{ENUM_INT_8}.nul.my_value  , {ENUM_INT_8}.nul.to_integer  , ({ENUM_INT_8}.nul).my_value  , ({ENUM_INT_8}.nul).to_integer  , enum_int_8_nul.my_value  , enum_int_8_nul.to_integer  >>)
			show ("{ENUM_INT_8}.one"  , <<{ENUM_INT_8}.one.my_value  , {ENUM_INT_8}.one.to_integer  , ({ENUM_INT_8}.one).my_value  , ({ENUM_INT_8}.one).to_integer  , enum_int_8_one.my_value  , enum_int_8_one.to_integer  >>)
			show ("{ENUM_INT_8}.min"  , <<{ENUM_INT_8}.min.my_value  , {ENUM_INT_8}.min.to_integer  , ({ENUM_INT_8}.min).my_value  , ({ENUM_INT_8}.min).to_integer  , enum_int_8_min.my_value  , enum_int_8_min.to_integer  >>)
			show ("{ENUM_INT_8}.max"  , <<{ENUM_INT_8}.max.my_value  , {ENUM_INT_8}.max.to_integer  , ({ENUM_INT_8}.max).my_value  , ({ENUM_INT_8}.max).to_integer  , enum_int_8_max.my_value  , enum_int_8_max.to_integer  >>)
			show ("{ENUM_INT_16}.nul" , <<{ENUM_INT_16}.nul.my_value , {ENUM_INT_16}.nul.to_integer , ({ENUM_INT_16}.nul).my_value , ({ENUM_INT_16}.nul).to_integer , enum_int_16_nul.my_value , enum_int_16_nul.to_integer >>)
			show ("{ENUM_INT_16}.one" , <<{ENUM_INT_16}.one.my_value , {ENUM_INT_16}.one.to_integer , ({ENUM_INT_16}.one).my_value , ({ENUM_INT_16}.one).to_integer , enum_int_16_one.my_value , enum_int_16_one.to_integer >>)
			show ("{ENUM_INT_16}.min" , <<{ENUM_INT_16}.min.my_value , {ENUM_INT_16}.min.to_integer , ({ENUM_INT_16}.min).my_value , ({ENUM_INT_16}.min).to_integer , enum_int_16_min.my_value , enum_int_16_min.to_integer >>)
			show ("{ENUM_INT_16}.max" , <<{ENUM_INT_16}.max.my_value , {ENUM_INT_16}.max.to_integer , ({ENUM_INT_16}.max).my_value , ({ENUM_INT_16}.max).to_integer , enum_int_16_max.my_value , enum_int_16_max.to_integer >>)
			show ("{ENUM_INT_32}.nul" , <<{ENUM_INT_32}.nul.my_value , {ENUM_INT_32}.nul.to_integer , ({ENUM_INT_32}.nul).my_value , ({ENUM_INT_32}.nul).to_integer , enum_int_32_nul.my_value , enum_int_32_nul.to_integer >>)
			show ("{ENUM_INT_32}.one" , <<{ENUM_INT_32}.one.my_value , {ENUM_INT_32}.one.to_integer , ({ENUM_INT_32}.one).my_value , ({ENUM_INT_32}.one).to_integer , enum_int_32_one.my_value , enum_int_32_one.to_integer >>)
			show ("{ENUM_INT_32}.min" , <<{ENUM_INT_32}.min.my_value , {ENUM_INT_32}.min.to_integer , ({ENUM_INT_32}.min).my_value , ({ENUM_INT_32}.min).to_integer , enum_int_32_min.my_value , enum_int_32_min.to_integer >>)
			show ("{ENUM_INT_32}.max" , <<{ENUM_INT_32}.max.my_value , {ENUM_INT_32}.max.to_integer , ({ENUM_INT_32}.max).my_value , ({ENUM_INT_32}.max).to_integer , enum_int_32_max.my_value , enum_int_32_max.to_integer >>)
			show ("{ENUM_INT_64}.nul" , <<{ENUM_INT_64}.nul.my_value , {ENUM_INT_64}.nul.to_integer , ({ENUM_INT_64}.nul).my_value , ({ENUM_INT_64}.nul).to_integer , enum_int_64_nul.my_value , enum_int_64_nul.to_integer >>)
			show ("{ENUM_INT_64}.one" , <<{ENUM_INT_64}.one.my_value , {ENUM_INT_64}.one.to_integer , ({ENUM_INT_64}.one).my_value , ({ENUM_INT_64}.one).to_integer , enum_int_64_one.my_value , enum_int_64_one.to_integer >>)
			show ("{ENUM_INT_64}.min" , <<{ENUM_INT_64}.min.my_value , {ENUM_INT_64}.min.to_integer , ({ENUM_INT_64}.min).my_value , ({ENUM_INT_64}.min).to_integer , enum_int_64_min.my_value , enum_int_64_min.to_integer >>)
			show ("{ENUM_INT_64}.max" , <<{ENUM_INT_64}.max.my_value , {ENUM_INT_64}.max.to_integer , ({ENUM_INT_64}.max).my_value , ({ENUM_INT_64}.max).to_integer , enum_int_64_max.my_value , enum_int_64_max.to_integer >>)
			show ("{ENUM_INT_PTR}.nul", <<{ENUM_INT_PTR}.nul.my_value, {ENUM_INT_PTR}.nul.to_integer, ({ENUM_INT_PTR}.nul).my_value, ({ENUM_INT_PTR}.nul).to_integer, enum_int_ptr_nul.my_value, enum_int_ptr_nul.to_integer>>)
			show ("{ENUM_INT_PTR}.one", <<{ENUM_INT_PTR}.one.my_value, {ENUM_INT_PTR}.one.to_integer, ({ENUM_INT_PTR}.one).my_value, ({ENUM_INT_PTR}.one).to_integer, enum_int_ptr_one.my_value, enum_int_ptr_one.to_integer>>)
			show ("{ENUM_INT_PTR}.min", <<{ENUM_INT_PTR}.min.my_value, {ENUM_INT_PTR}.min.to_integer, ({ENUM_INT_PTR}.min).my_value, ({ENUM_INT_PTR}.min).to_integer, enum_int_ptr_min.my_value, enum_int_ptr_min.to_integer>>)
			show ("{ENUM_INT_PTR}.max", <<{ENUM_INT_PTR}.max.my_value, {ENUM_INT_PTR}.max.to_integer, ({ENUM_INT_PTR}.max).my_value, ({ENUM_INT_PTR}.max).to_integer, enum_int_ptr_max.my_value, enum_int_ptr_max.to_integer>>)
			show ("{ENUM_U_INT_8}.nul"  , <<{ENUM_U_INT_8}.nul.my_value  , {ENUM_U_INT_8}.nul.to_integer  , ({ENUM_U_INT_8}.nul).my_value  , ({ENUM_U_INT_8}.nul).to_integer  , enum_u_int_8_nul.my_value  , enum_u_int_8_nul.to_integer  >>)
			show ("{ENUM_U_INT_8}.one"  , <<{ENUM_U_INT_8}.one.my_value  , {ENUM_U_INT_8}.one.to_integer  , ({ENUM_U_INT_8}.one).my_value  , ({ENUM_U_INT_8}.one).to_integer  , enum_u_int_8_one.my_value  , enum_u_int_8_one.to_integer  >>)
			show ("{ENUM_U_INT_8}.min"  , <<{ENUM_U_INT_8}.min.my_value  , {ENUM_U_INT_8}.min.to_integer  , ({ENUM_U_INT_8}.min).my_value  , ({ENUM_U_INT_8}.min).to_integer  , enum_u_int_8_min.my_value  , enum_u_int_8_min.to_integer  >>)
			show ("{ENUM_U_INT_8}.max"  , <<{ENUM_U_INT_8}.max.my_value  , {ENUM_U_INT_8}.max.to_integer  , ({ENUM_U_INT_8}.max).my_value  , ({ENUM_U_INT_8}.max).to_integer  , enum_u_int_8_max.my_value  , enum_u_int_8_max.to_integer  >>)
			show ("{ENUM_U_INT_16}.nul" , <<{ENUM_U_INT_16}.nul.my_value , {ENUM_U_INT_16}.nul.to_integer , ({ENUM_U_INT_16}.nul).my_value , ({ENUM_U_INT_16}.nul).to_integer , enum_u_int_16_nul.my_value , enum_u_int_16_nul.to_integer >>)
			show ("{ENUM_U_INT_16}.one" , <<{ENUM_U_INT_16}.one.my_value , {ENUM_U_INT_16}.one.to_integer , ({ENUM_U_INT_16}.one).my_value , ({ENUM_U_INT_16}.one).to_integer , enum_u_int_16_one.my_value , enum_u_int_16_one.to_integer >>)
			show ("{ENUM_U_INT_16}.min" , <<{ENUM_U_INT_16}.min.my_value , {ENUM_U_INT_16}.min.to_integer , ({ENUM_U_INT_16}.min).my_value , ({ENUM_U_INT_16}.min).to_integer , enum_u_int_16_min.my_value , enum_u_int_16_min.to_integer >>)
			show ("{ENUM_U_INT_16}.max" , <<{ENUM_U_INT_16}.max.my_value , {ENUM_U_INT_16}.max.to_integer , ({ENUM_U_INT_16}.max).my_value , ({ENUM_U_INT_16}.max).to_integer , enum_u_int_16_max.my_value , enum_u_int_16_max.to_integer >>)
			show ("{ENUM_U_INT_32}.nul" , <<{ENUM_U_INT_32}.nul.my_value , {ENUM_U_INT_32}.nul.to_integer , ({ENUM_U_INT_32}.nul).my_value , ({ENUM_U_INT_32}.nul).to_integer , enum_u_int_32_nul.my_value , enum_u_int_32_nul.to_integer >>)
			show ("{ENUM_U_INT_32}.one" , <<{ENUM_U_INT_32}.one.my_value , {ENUM_U_INT_32}.one.to_integer , ({ENUM_U_INT_32}.one).my_value , ({ENUM_U_INT_32}.one).to_integer , enum_u_int_32_one.my_value , enum_u_int_32_one.to_integer >>)
			show ("{ENUM_U_INT_32}.min" , <<{ENUM_U_INT_32}.min.my_value , {ENUM_U_INT_32}.min.to_integer , ({ENUM_U_INT_32}.min).my_value , ({ENUM_U_INT_32}.min).to_integer , enum_u_int_32_min.my_value , enum_u_int_32_min.to_integer >>)
			show ("{ENUM_U_INT_32}.max" , <<{ENUM_U_INT_32}.max.my_value , {ENUM_U_INT_32}.max.to_integer , ({ENUM_U_INT_32}.max).my_value , ({ENUM_U_INT_32}.max).to_integer , enum_u_int_32_max.my_value , enum_u_int_32_max.to_integer >>)
			show ("{ENUM_U_INT_64}.nul" , <<{ENUM_U_INT_64}.nul.my_value , {ENUM_U_INT_64}.nul.to_integer , ({ENUM_U_INT_64}.nul).my_value , ({ENUM_U_INT_64}.nul).to_integer , enum_u_int_64_nul.my_value , enum_u_int_64_nul.to_integer >>)
			show ("{ENUM_U_INT_64}.one" , <<{ENUM_U_INT_64}.one.my_value , {ENUM_U_INT_64}.one.to_integer , ({ENUM_U_INT_64}.one).my_value , ({ENUM_U_INT_64}.one).to_integer , enum_u_int_64_one.my_value , enum_u_int_64_one.to_integer >>)
			show ("{ENUM_U_INT_64}.min" , <<{ENUM_U_INT_64}.min.my_value , {ENUM_U_INT_64}.min.to_integer , ({ENUM_U_INT_64}.min).my_value , ({ENUM_U_INT_64}.min).to_integer , enum_u_int_64_min.my_value , enum_u_int_64_min.to_integer >>)
			show ("{ENUM_U_INT_64}.max" , <<{ENUM_U_INT_64}.max.my_value , {ENUM_U_INT_64}.max.to_integer , ({ENUM_U_INT_64}.max).my_value , ({ENUM_U_INT_64}.max).to_integer , enum_u_int_64_max.my_value , enum_u_int_64_max.to_integer >>)
			show ("{ENUM_U_INT_PTR}.nul", <<{ENUM_U_INT_PTR}.nul.my_value, {ENUM_U_INT_PTR}.nul.to_integer, ({ENUM_U_INT_PTR}.nul).my_value, ({ENUM_U_INT_PTR}.nul).to_integer, enum_u_int_ptr_nul.my_value, enum_u_int_ptr_nul.to_integer>>)
			show ("{ENUM_U_INT_PTR}.one", <<{ENUM_U_INT_PTR}.one.my_value, {ENUM_U_INT_PTR}.one.to_integer, ({ENUM_U_INT_PTR}.one).my_value, ({ENUM_U_INT_PTR}.one).to_integer, enum_u_int_ptr_one.my_value, enum_u_int_ptr_one.to_integer>>)
			show ("{ENUM_U_INT_PTR}.min", <<{ENUM_U_INT_PTR}.min.my_value, {ENUM_U_INT_PTR}.min.to_integer, ({ENUM_U_INT_PTR}.min).my_value, ({ENUM_U_INT_PTR}.min).to_integer, enum_u_int_ptr_min.my_value, enum_u_int_ptr_min.to_integer>>)
			show ("{ENUM_U_INT_PTR}.max", <<{ENUM_U_INT_PTR}.max.my_value, {ENUM_U_INT_PTR}.max.to_integer, ({ENUM_U_INT_PTR}.max).my_value, ({ENUM_U_INT_PTR}.max).to_integer, enum_u_int_ptr_max.my_value, enum_u_int_ptr_max.to_integer>>)
		end

feature {NONE} -- Implementation

	enum_bool_nul: ENUM_BOOL is do Result := {ENUM_BOOL}.nul end
	enum_bool_one: ENUM_BOOL is do Result := {ENUM_BOOL}.one end
	enum_bool_min: ENUM_BOOL is do Result := {ENUM_BOOL}.min end
	enum_bool_max: ENUM_BOOL is do Result := {ENUM_BOOL}.max end
	enum_char_nul: ENUM_CHAR is do Result := {ENUM_CHAR}.nul end
	enum_char_one: ENUM_CHAR is do Result := {ENUM_CHAR}.one end
	enum_char_min: ENUM_CHAR is do Result := {ENUM_CHAR}.min end
	enum_char_max: ENUM_CHAR is do Result := {ENUM_CHAR}.max end
	enum_int_8_nul: ENUM_INT_8 is do Result := {ENUM_INT_8}.nul end
	enum_int_8_one: ENUM_INT_8 is do Result := {ENUM_INT_8}.one end
	enum_int_8_min: ENUM_INT_8 is do Result := {ENUM_INT_8}.min end
	enum_int_8_max: ENUM_INT_8 is do Result := {ENUM_INT_8}.max end
	enum_int_16_nul: ENUM_INT_16 is do Result := {ENUM_INT_16}.nul end
	enum_int_16_one: ENUM_INT_16 is do Result := {ENUM_INT_16}.one end
	enum_int_16_min: ENUM_INT_16 is do Result := {ENUM_INT_16}.min end
	enum_int_16_max: ENUM_INT_16 is do Result := {ENUM_INT_16}.max end
	enum_int_32_nul: ENUM_INT_32 is do Result := {ENUM_INT_32}.nul end
	enum_int_32_one: ENUM_INT_32 is do Result := {ENUM_INT_32}.one end
	enum_int_32_min: ENUM_INT_32 is do Result := {ENUM_INT_32}.min end
	enum_int_32_max: ENUM_INT_32 is do Result := {ENUM_INT_32}.max end
	enum_int_64_nul: ENUM_INT_64 is do Result := {ENUM_INT_64}.nul end
	enum_int_64_one: ENUM_INT_64 is do Result := {ENUM_INT_64}.one end
	enum_int_64_min: ENUM_INT_64 is do Result := {ENUM_INT_64}.min end
	enum_int_64_max: ENUM_INT_64 is do Result := {ENUM_INT_64}.max end
	enum_int_ptr_nul: ENUM_INT_PTR is do Result := {ENUM_INT_PTR}.nul end
	enum_int_ptr_one: ENUM_INT_PTR is do Result := {ENUM_INT_PTR}.one end
	enum_int_ptr_min: ENUM_INT_PTR is do Result := {ENUM_INT_PTR}.min end
	enum_int_ptr_max: ENUM_INT_PTR is do Result := {ENUM_INT_PTR}.max end
	enum_u_int_8_nul: ENUM_U_INT_8 is do Result := {ENUM_U_INT_8}.nul end
	enum_u_int_8_one: ENUM_U_INT_8 is do Result := {ENUM_U_INT_8}.one end
	enum_u_int_8_min: ENUM_U_INT_8 is do Result := {ENUM_U_INT_8}.min end
	enum_u_int_8_max: ENUM_U_INT_8 is do Result := {ENUM_U_INT_8}.max end
	enum_u_int_16_nul: ENUM_U_INT_16 is do Result := {ENUM_U_INT_16}.nul end
	enum_u_int_16_one: ENUM_U_INT_16 is do Result := {ENUM_U_INT_16}.one end
	enum_u_int_16_min: ENUM_U_INT_16 is do Result := {ENUM_U_INT_16}.min end
	enum_u_int_16_max: ENUM_U_INT_16 is do Result := {ENUM_U_INT_16}.max end
	enum_u_int_32_nul: ENUM_U_INT_32 is do Result := {ENUM_U_INT_32}.nul end
	enum_u_int_32_one: ENUM_U_INT_32 is do Result := {ENUM_U_INT_32}.one end
	enum_u_int_32_min: ENUM_U_INT_32 is do Result := {ENUM_U_INT_32}.min end
	enum_u_int_32_max: ENUM_U_INT_32 is do Result := {ENUM_U_INT_32}.max end
	enum_u_int_64_nul: ENUM_U_INT_64 is do Result := {ENUM_U_INT_64}.nul end
	enum_u_int_64_one: ENUM_U_INT_64 is do Result := {ENUM_U_INT_64}.one end
	enum_u_int_64_min: ENUM_U_INT_64 is do Result := {ENUM_U_INT_64}.min end
	enum_u_int_64_max: ENUM_U_INT_64 is do Result := {ENUM_U_INT_64}.max end
	enum_u_int_ptr_nul: ENUM_U_INT_PTR is do Result := {ENUM_U_INT_PTR}.nul end
	enum_u_int_ptr_one: ENUM_U_INT_PTR is do Result := {ENUM_U_INT_PTR}.one end
	enum_u_int_ptr_min: ENUM_U_INT_PTR is do Result := {ENUM_U_INT_PTR}.min end
	enum_u_int_ptr_max: ENUM_U_INT_PTR is do Result := {ENUM_U_INT_PTR}.max end

feature {NONE} -- Output

	show (name: STRING; actual: ARRAY [ANY]) is
			-- Show result of a call to feature `name' with the expected
			-- result `expected' and actual results `actual'.
		require
			name_not_void: name /= Void
			actual_not_void: actual /= Void
			actual_not_empty: not actual.is_empty
		local
			s: STRING
			i: INTEGER
		do
			from
				s := (actual [1]).out
				i := 2
			until
				i > actual.count or else not s.is_equal ((actual [i]).out)
			loop
				i := i + 1
			end
			io.put_string (name)
			io.put_string (" = ")
			io.put_string (s)
			if i <= actual.count then
					-- Some strings differ.
					-- Print them all.
				from
					i := 2
				until
					i > actual.count
				loop
					io.put_string (", ")
					io.put_string ((actual [i]).out)
					i := i + 1
				end
			end
			io.put_new_line
		end

end
