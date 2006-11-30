indexing
	metadata:
-- Testing .NET custom attributes
		create {ATTRIBUTE_USAGE_ATTRIBUTE}.make ({ATTRIBUTE_TARGETS}.assembly) end,
		create {OBSOLETE_ATTRIBUTE}.make end,
		create {OBSOLETE_ATTRIBUTE}.make ("This is obsolete with one argument.") end,
		create {OBSOLETE_ATTRIBUTE}.make ("This is oboslete with two arguments.", False) end,

-- Testing .NET custom attributes using constructor only
			-- Test overloading on `make' using explicit type.
		create {CA}.make end,
		create {CA}.make ({INTEGER_8} 1) end,
		create {CA}.make ({NATURAL_8} 1) end,
		create {CA}.make ({INTEGER_16} 2) end,
		create {CA}.make ({NATURAL_16} 2) end,
		create {CA}.make ({INTEGER} 4) end,
		create {CA}.make ({NATURAL_32} 4) end,
		create {CA}.make (3) end,
		create {CA}.make ({INTEGER_64} 4) end,
		create {CA}.make ({NATURAL_64} 4) end,
		create {CA}.make (5.0) end,
		create {CA}.make ({REAL} 5.0) end,
		create {CA}.make ({DOUBLE} 6.0) end,
		create {CA}.make ({ENUM_TEST}.tutu) end,
		create {CA}.make ('a') end,
		create {CA}.make_from_t_3 ({ENUM_TEST}) end,
		create {CA}.make_from_s_4 ("String") end,
		create {CA}.make_from_t_4 ({ENUM_TEST}.toto) end,
		create {CA}.make_from_t_4 ({ENUM_TEST}.titi) end,
		create {CA}.make_from_t_4 ({ENUM_TEST}.tutu) end,

			-- Testing explicit conversion
		create {CA}.make_from_b_4 (255) end,
		create {CA}.make_from_b_5 (127) end,
		create {CA}.make_from_s_5 (65535) end,
		create {CA}.make_from_s_6 (32767) end,
		create {CA}.make_from_i_3 (9) end,
		create {CA}.make_from_i_4 (9) end,
		create {CA}.make_from_l_4 (-1234567890123456) end,
		create {CA}.make_from_l_3 (1234567890123456) end,
		create {CA}.make_from_f_2 (10) end,
		create {CA}.make_from_f_2 ({DOUBLE} 10.0) end,
		create {CA}.make_from_d_2 (11) end,
		create {CA}.make_from_d_2 ({REAL} 11.0) end,

			-- Testing boxed values
		create {CA}.make_from_o_2 ({INTEGER_8} 1) end,
		create {CA}.make_from_o_2 ({INTEGER_16} 1) end,
		create {CA}.make_from_o_2 (1) end,
		create {CA}.make_from_o_2 ({INTEGER} 1) end,
		create {CA}.make_from_o_2 ({INTEGER_64} 1) end,
		create {CA}.make_from_o_2 ({NATURAL_8} 1) end,
		create {CA}.make_from_o_2 ({NATURAL_16} 1) end,
		create {CA}.make_from_o_2 ({NATURAL_32} 1) end,
		create {CA}.make_from_o_2 ({NATURAL_64} 1) end,
		create {CA}.make_from_o_2 (1.0) end,
		create {CA}.make_from_o_2 ({REAL} 1.0) end,
		create {CA}.make_from_o_2 ({DOUBLE} 1.0) end,
		create {CA}.make_from_o_2 ("String") end,
		create {CA}.make_from_o_2 ({ENUM_TEST}.toto) end,
		create {CA}.make_from_o_2 ({ENUM_TEST}.titi) end,
		create {CA}.make_from_o_2 ({ENUM_TEST}.tutu) end,
		create {CA}.make_from_o_2 ({ENUM_TEST}) end,


			-- Testing manifest arrays
		create {CA}.make_from_b_3 (Void) end,
		create {CA}.make_from_b_3 (<< True, False, True, False >>) end,

		create {CA}.make_from_c (Void) end,
		create {CA}.make_from_c (<< 'a', 'b', 'c', 'd', 'e' >>) end,

		create {CA}.make_from_d (Void) end,
		create {CA}.make_from_d (<< 1.0, 2.0, 3.0 >>) end,
		create {CA}.make_from_d (<< {REAL} 1.0, {REAL} 2.0, {REAL} 3.0 >>) end,
		create {CA}.make_from_d (<< {DOUBLE} 1.0, {DOUBLE} 2.0, {DOUBLE} 3.0 >>) end,
		create {CA}.make_from_d (<< {REAL} 1.0, {REAL} 2.0, {DOUBLE} 3.0 >>) end,
		create {CA}.make_from_d (<< {DOUBLE} 1.0, {REAL} 2.0, {REAL} 3.0 >>) end,
		create {CA}.make_from_d (<< 1,  2, 3 >>) end,
		create {CA}.make_from_d (<< {INTEGER_8} 1, {INTEGER_16} 2, {INTEGER} 3, {INTEGER_64} 4 >>) end,
		create {CA}.make_from_d (<< {NATURAL_8} 1, {NATURAL_16} 2, {NATURAL_32} 3, {NATURAL_64} 4 >>) end,

		create {CA}.make_from_f (Void) end,
		create {CA}.make_from_f (<< 1.0, 2.0, 3.0 >>) end,
		create {CA}.make_from_f (<< {REAL} 1.0, {REAL} 2.0, {REAL} 3.0 >>) end,
		create {CA}.make_from_f (<< {DOUBLE} 1.0, {DOUBLE} 2.0, {DOUBLE} 3.0 >>) end,
		create {CA}.make_from_f (<< {REAL} 1.0, {REAL} 2.0, {DOUBLE} 3.0 >>) end,
		create {CA}.make_from_f (<< {DOUBLE} 1.0, {REAL} 2.0, {REAL} 3.0 >>) end,
		create {CA}.make_from_f (<< 1,  2, 3 >>) end,
		create {CA}.make_from_f (<< {INTEGER_8} 1, {INTEGER_16} 2, {INTEGER} 3, {INTEGER_64} 4 >>) end,
		create {CA}.make_from_f (<< {NATURAL_8} 1, {NATURAL_16} 2, {NATURAL_32} 3, {NATURAL_64} 4 >>) end,

		create {CA}.make_from_b (Void) end,
		create {CA}.make_from_b (<< 1, 2 , 3 >>) end,
		create {CA}.make_from_b (<< {NATURAL_8} 1, {NATURAL_8} 2, 3 >>) end,

		create {CA}.make_from_b_2 (Void) end,
		create {CA}.make_from_b_2 (<< 1, 2 , 3 >>) end,
		create {CA}.make_from_b_2 (<< {INTEGER_8} 1, {INTEGER_8} 2, 3 >>) end,

		create {CA}.make_from_s_2 (Void) end,
		create {CA}.make_from_s_2 (<< {NATURAL_8} 1, {NATURAL_8} 2, {NATURAL_8} 3 >>) end,
		create {CA}.make_from_s_2 (<< {NATURAL_16} 1, {NATURAL_16} 2, {NATURAL_16} 3 >>) end,
		create {CA}.make_from_s_2 (<< {NATURAL_8} 1, {NATURAL_16} 2,  3 >>) end,
		create {CA}.make_from_s_2 (<< 1, {NATURAL_16} 2, {NATURAL_8} 3 >>) end,

		create {CA}.make_from_s_3 (Void) end,
		create {CA}.make_from_s_3 (<< {INTEGER_8} 1, {INTEGER_8} 2, {INTEGER_8} 3 >>) end,
		create {CA}.make_from_s_3 (<< {INTEGER_16} 1, {INTEGER_16} 2, {INTEGER_16} 3 >>) end,
		create {CA}.make_from_s_3 (<< {INTEGER_8} 1, {INTEGER_16} 2,  3 >>) end,
		create {CA}.make_from_s_3 (<< 1, {INTEGER_16} 2, {INTEGER_8} 3 >>) end,

		create {CA}.make_from_i (Void) end,
		create {CA}.make_from_i (<< 1, 2, 3 >>) end,
		create {CA}.make_from_i (<< {NATURAL_8} 1, {NATURAL_8} 2, {NATURAL_8} 3 >>) end,
		create {CA}.make_from_i (<< {NATURAL_16} 1, {NATURAL_16} 2, {NATURAL_16} 3 >>) end,
		create {CA}.make_from_i (<< {NATURAL_32} 1, {NATURAL_32} 2, {NATURAL_32} 3 >>) end,
		create {CA}.make_from_i (<< {NATURAL_8} 1, {NATURAL_16} 2, {NATURAL_32} 3 >>) end,
		create {CA}.make_from_i (<< {NATURAL_32} 1, {NATURAL_16} 2, {NATURAL_8} 3 >>) end,

		create {CA}.make_from_i_2 (Void) end,
		create {CA}.make_from_i_2 (<< 1, 2, 3 >>) end,
		create {CA}.make_from_i_2 (<< {INTEGER_8} 1, {INTEGER_8} 2, {INTEGER_8} 3 >>) end,
		create {CA}.make_from_i_2 (<< {INTEGER_16} 1, {INTEGER_16} 2, {INTEGER_16} 3 >>) end,
		create {CA}.make_from_i_2 (<< {INTEGER} 1, {INTEGER} 2, {INTEGER} 3 >>) end,
		create {CA}.make_from_i_2 (<< {INTEGER_8} 1, {INTEGER_16} 2, {INTEGER} 3 >>) end,
		create {CA}.make_from_i_2 (<< {INTEGER} 1, {INTEGER_16} 2, {INTEGER_8} 3 >>) end,

		create {CA}.make_from_l (Void) end,
		create {CA}.make_from_l (<< 1, 2, 3, 123456789132456 >>) end,
		create {CA}.make_from_l (<< {NATURAL_8} 1, {NATURAL_8} 2, {NATURAL_8} 3 >>) end,
		create {CA}.make_from_l (<< {NATURAL_16} 1, {NATURAL_16} 2, {NATURAL_16} 3 >>) end,
		create {CA}.make_from_l (<< {NATURAL_32} 1, {NATURAL_32} 2, {NATURAL_32} 3 >>) end,
		create {CA}.make_from_l (<< {NATURAL_64} 1, {NATURAL_64} 2, {NATURAL_64} 3 >>) end,
		create {CA}.make_from_l (<< {NATURAL_8} 1, {NATURAL_16} 2, {NATURAL_32} 3 >>) end,
		create {CA}.make_from_l (<< {NATURAL_32} 1, {NATURAL_16} 2, {NATURAL_8} 3 >>) end,

		create {CA}.make_from_l_2 (Void) end,
		create {CA}.make_from_l_2 (<< 1, 2, 3, 123456789132456 >>) end,
		create {CA}.make_from_l_2 (<< {INTEGER_8} 1, {INTEGER_8} 2, {INTEGER_8} 3 >>) end,
		create {CA}.make_from_l_2 (<< {INTEGER_16} 1, {INTEGER_16} 2, {INTEGER_16} 3 >>) end,
		create {CA}.make_from_l_2 (<< {INTEGER} 1, {INTEGER} 2, {INTEGER} 3 >>) end,
		create {CA}.make_from_l_2 (<< {INTEGER_64} 1, {INTEGER_64} 2, {INTEGER_64} 3 >>) end,
		create {CA}.make_from_l_2 (<< {INTEGER_8} 1, {INTEGER_16} 2, {INTEGER} 3 >>) end,
		create {CA}.make_from_l_2 (<< {INTEGER} 1, {INTEGER_16} 2, {INTEGER_8} 3 >>) end,

		create {CA}.make_from_t (Void) end,
		create {CA}.make_from_t (<< {INTEGER_64}, {NATURAL_64} >>) end,

		create {CA}.make_from_t_2 (Void) end,
		create {CA}.make_from_t_2 (<< {ENUM_TEST}.toto, {ENUM_TEST}.titi, {ENUM_TEST}.tutu >>) end,

		create {CA}.make_from_s (Void) end,
		create {CA}.make_from_s (<< "String", "String" >>) end,

		create {CA}.make_from_o (Void) end,
		create {CA}.make_from_o (<< 1, 2, 3 >>) end,
		create {CA}.make_from_o (<< {INTEGER_8} 1, {INTEGER_16} 2, {INTEGER} 3, {INTEGER_64} 4 >>) end,
		create {CA}.make_from_o (<< "String_1", "String_2", {ENUM_TEST} >>) end,
		create {CA}.make_from_o (<< "String", << 1, 2 >>, {INTEGER_64} >>) end,
		create {CA}.make_from_o (<< "String", << {INTEGER_8} 1, 2>> >>) end,
		create {CA}.make_from_o (<< "String", << "String", << 1, 2 >> >> >>) end,
		create {CA}.make_from_o (<< "String", << "String", << "String", << 1, 2 >> >> >> >>) end,
		create {CA}.make_from_o (<< {INTEGER_8} 1, {INTEGER_16} 2, {INTEGER} 3, {INTEGER_64} 4,
			{NATURAL_8} 1, {NATURAL_16} 2, {NATURAL_32} 3, {NATURAL_64} 4,
			{REAL} 1.0, {DOUBLE} 2.0, "String", << 1, 2, "String", << 1, "String" >> >> >>) end,
		create {CA}.make_from_o (<< 1, {ENUM_TEST}.toto, {ENUM_TEST}.titi, {ENUM_TEST}.tutu >>) end,
		create {CA}.make_from_o (<< 1, {ENUM_TEST}, {INTEGER}, {SYSTEM_STRING} >>) end,

-- Testing .NET custom attributes with default constructor and optional named argument
		create {CA}.make [["my_boolean", True]] end,
		create {CA}.make [["my_byte", 255]] end,
		create {CA}.make [["my_byte", {NATURAL_8} 2]] end,
		create {CA}.make [["my_string", "String "]] end,
		create {CA}.make [["my_enum", {ENUM_TEST}.tutu]] end,
		create {CA}.make [["my_type", {ENUM_TEST}]] end,
		create {CA}.make [["my_char", 'a']] end,

			-- Testing explicit conversion
		create {CA}.make [["my_short", 32767]] end,
		create {CA}.make [["my_int", 9]] end,
		create {CA}.make [["my_float", 10]] end,
		create {CA}.make [["my_float", {DOUBLE} 10.0]] end,
		create {CA}.make [["my_double", 11]] end,
		create {CA}.make [["my_double", {REAL} 11.0]] end,

			-- Testing boxed values
		create {CA}.make [["my_object", {INTEGER_8} 1]] end,
		create {CA}.make [["my_object", {INTEGER_16} 1]] end,
		create {CA}.make [["my_object", 1]] end,
		create {CA}.make [["my_object", {INTEGER} 1]] end,
		create {CA}.make [["my_object", {INTEGER_64} 1]] end,
		create {CA}.make [["my_object", {NATURAL_8} 1]] end,
		create {CA}.make [["my_object", {NATURAL_16} 1]] end,
		create {CA}.make [["my_object", {NATURAL_32} 1]] end,
		create {CA}.make [["my_object", {NATURAL_64} 1]] end,
		create {CA}.make [["my_object", 1.0]] end,
		create {CA}.make [["my_object", {REAL} 1.0]] end,
		create {CA}.make [["my_object", {DOUBLE} 1.0]] end,
		create {CA}.make [["my_object", "String"]] end,
		create {CA}.make [["my_object", {ENUM_TEST}.toto]] end,
		create {CA}.make [["my_object", {ENUM_TEST}.titi]] end,
		create {CA}.make [["my_object", {ENUM_TEST}.tutu]] end,
		create {CA}.make [["my_object", {ENUM_TEST}]] end,

			-- Testing manifest arrays
		create {CA}.make [["my_boolean_array", Void]] end,
		create {CA}.make [["my_boolean_array", << True, False >>]] end,

		create {CA}.make [["my_char_array", Void]] end,
		create {CA}.make [["my_char_array", << 'a', 'b', 'c', 'd', 'e' >>]] end,

		create {CA}.make [["my_double_array", Void]] end,
		create {CA}.make [["my_double_array", << 1.0, 2.0, 3.0 >>]] end,
		create {CA}.make [["my_double_array", << {REAL} 1.0, {REAL} 2.0, {REAL} 3.0 >>]] end,
		create {CA}.make [["my_double_array", << {DOUBLE} 1.0, {DOUBLE} 2.0, {DOUBLE} 3.0 >>]] end,
		create {CA}.make [["my_double_array", << {REAL} 1.0, {REAL} 2.0, {DOUBLE} 3.0 >>]] end,
		create {CA}.make [["my_double_array", << {DOUBLE} 1.0, {REAL} 2.0, {REAL} 3.0 >>]] end,
		create {CA}.make [["my_double_array", << 1,  2, 3 >>]] end,
		create {CA}.make [["my_double_array", << {INTEGER_8} 1, {INTEGER_16} 2, {INTEGER} 3, {INTEGER_64} 4 >>]] end,
		create {CA}.make [["my_double_array", << {NATURAL_8} 1, {NATURAL_16} 2, {NATURAL_32} 3, {NATURAL_64} 4 >>]] end,

		create {CA}.make [["my_float_array", << 1.0, 2.0, 3.0 >>]] end,
		create {CA}.make [["my_float_array", << {REAL} 1.0, {REAL} 2.0, {REAL} 3.0 >>]] end,
		create {CA}.make [["my_float_array", << {DOUBLE} 1.0, {DOUBLE} 2.0, {DOUBLE} 3.0 >>]] end,
		create {CA}.make [["my_float_array", << {REAL} 1.0, {REAL} 2.0, {DOUBLE} 3.0 >>]] end,
		create {CA}.make [["my_float_array", << {DOUBLE} 1.0, {REAL} 2.0, {REAL} 3.0 >>]] end,
		create {CA}.make [["my_float_array", << 1,  2, 3 >>]] end,
		create {CA}.make [["my_float_array", << {INTEGER_8} 1, {INTEGER_16} 2, {INTEGER} 3, {INTEGER_64} 4 >>]] end,
		create {CA}.make [["my_float_array", << {NATURAL_8} 1, {NATURAL_16} 2, {NATURAL_32} 3, {NATURAL_64} 4 >>]] end,

		create {CA}.make [["my_byte_array", Void]] end,
		create {CA}.make [["my_byte_array", << 1, 2, 3 >>]] end,
		create {CA}.make [["my_byte_array", << {NATURAL_8} 1, {NATURAL_8} 2, 3 >>]] end,

		create {CA}.make [["my_sbyte_array", Void]] end,
		create {CA}.make [["my_sbyte_array", << 1, 2, 3 >>]] end,
		create {CA}.make [["my_sbyte_array", << {INTEGER_8} 1, {INTEGER_8} 2, 3 >>]] end,

		create {CA}.make [["my_short_array", Void]] end,
		create {CA}.make [["my_short_array", << {INTEGER_8} 1, {INTEGER_8} 2, {INTEGER_8} 3 >>]] end,
		create {CA}.make [["my_short_array", << {INTEGER_16} 1, {INTEGER_16} 2, {INTEGER_16} 3 >>]] end,
		create {CA}.make [["my_short_array", << {INTEGER_8} 1, {INTEGER_16} 2,  3 >>]] end,
		create {CA}.make [["my_short_array", << 1, {INTEGER_16} 2, {INTEGER_8} 3 >>]] end,

		create {CA}.make [["my_ushort_array", Void]] end,
		create {CA}.make [["my_ushort_array", << {NATURAL_8} 1, {NATURAL_8} 2, {NATURAL_8} 3 >>]] end,
		create {CA}.make [["my_ushort_array", << {NATURAL_16} 1, {NATURAL_16} 2, {NATURAL_16} 3 >>]] end,
		create {CA}.make [["my_ushort_array", << {NATURAL_8} 1, {NATURAL_16} 2,  3 >>]] end,
		create {CA}.make [["my_ushort_array", << 1, {NATURAL_16} 2, {NATURAL_8} 3 >>]] end,

		create {CA}.make [["my_int_array", Void]] end,
		create {CA}.make [["my_int_array", << 1, 2, 3 >>]] end,
		create {CA}.make [["my_int_array", << {INTEGER_8} 1, {INTEGER_8} 2, {INTEGER_8} 3 >>]] end,
		create {CA}.make [["my_int_array", << {INTEGER_16} 1, {INTEGER_16} 2, {INTEGER_16} 3 >>]] end,
		create {CA}.make [["my_int_array", << {INTEGER} 1, {INTEGER} 2, {INTEGER} 3 >>]] end,
		create {CA}.make [["my_int_array", << {INTEGER_8} 1, {INTEGER_16} 2, {INTEGER} 3 >>]] end,
		create {CA}.make [["my_int_array", << {INTEGER} 1, {INTEGER_16} 2, {INTEGER_8} 3 >>]] end,

		create {CA}.make [["my_uint_array", Void]] end,
		create {CA}.make [["my_uint_array", << 1, 2, 3 >>]] end,
		create {CA}.make [["my_uint_array", << {NATURAL_8} 1, {NATURAL_8} 2, {NATURAL_8} 3 >>]] end,
		create {CA}.make [["my_uint_array", << {NATURAL_16} 1, {NATURAL_16} 2, {NATURAL_16} 3 >>]] end,
		create {CA}.make [["my_uint_array", << {NATURAL_32} 1, {NATURAL_32} 2, {NATURAL_32} 3 >>]] end,
		create {CA}.make [["my_uint_array", << {NATURAL_8} 1, {NATURAL_16} 2, {NATURAL_32} 3 >>]] end,
		create {CA}.make [["my_uint_array", << {NATURAL_32} 1, {NATURAL_16} 2, {NATURAL_8} 3 >>]] end,

		create {CA}.make [["my_long_array", Void]] end,
		create {CA}.make [["my_long_array", << 1, 2, 3, 123456789132456 >>]] end,
		create {CA}.make [["my_long_array", << {INTEGER_8} 1, {INTEGER_8} 2, {INTEGER_8} 3 >>]] end,
		create {CA}.make [["my_long_array", << {INTEGER_16} 1, {INTEGER_16} 2, {INTEGER_16} 3 >>]] end,
		create {CA}.make [["my_long_array", << {INTEGER} 1, {INTEGER} 2, {INTEGER} 3 >>]] end,
		create {CA}.make [["my_long_array", << {INTEGER_64} 1, {INTEGER_64} 2, {INTEGER_64} 3 >>]] end,
		create {CA}.make [["my_long_array", << {INTEGER_8} 1, {INTEGER_16} 2, {INTEGER} 3 >>]] end,
		create {CA}.make [["my_long_array", << {INTEGER} 1, {INTEGER_16} 2, {INTEGER_8} 3 >>]] end,

		create {CA}.make [["my_ulong_array", Void]] end,
		create {CA}.make [["my_ulong_array", << 1, 2, 3, 123456789132456 >>]] end,
		create {CA}.make [["my_ulong_array", << {NATURAL_8} 1, {NATURAL_8} 2, {NATURAL_8} 3 >>]] end,
		create {CA}.make [["my_ulong_array", << {NATURAL_16} 1, {NATURAL_16} 2, {NATURAL_16} 3 >>]] end,
		create {CA}.make [["my_ulong_array", << {NATURAL_32} 1, {NATURAL_32} 2, {NATURAL_32} 3 >>]] end,
		create {CA}.make [["my_ulong_array", << {NATURAL_64} 1, {NATURAL_64} 2, {NATURAL_64} 3 >>]] end,
		create {CA}.make [["my_ulong_array", << {NATURAL_8} 1, {NATURAL_16} 2, {NATURAL_32} 3 >>]] end,
		create {CA}.make [["my_ulong_array", << {NATURAL_32} 1, {NATURAL_16} 2, {NATURAL_8} 3 >>]] end,

		create {CA}.make [["my_type_array", Void]] end,
		create {CA}.make [["my_type_array", << {INTEGER_64}, {NATURAL_64}, {ENUM_TEST} >>]] end,

		create {CA}.make [["my_enum_array", Void]] end,
		create {CA}.make [["my_enum_array", << {ENUM_TEST}.toto, {ENUM_TEST}.titi, {ENUM_TEST}.tutu >>]] end,

		create {CA}.make [["my_string_array", Void]] end,
		create {CA}.make [["my_string_array", << "String", "String" >>]] end,

		create {CA}.make [["my_object_array", Void]] end,
		create {CA}.make [["my_object_array", << 1, 2, 3 >>]] end,
		create {CA}.make [["my_object_array", << {INTEGER_8} 1, {INTEGER_16} 2, {INTEGER} 3, {INTEGER_64} 4 >>]] end,
		create {CA}.make [["my_object_array", << {NATURAL_8} 1, {NATURAL_16} 2, {NATURAL_32} 3, {NATURAL_64} 4 >>]] end,
		create {CA}.make [["my_object_array", << "String_1", "String_2", {ENUM_TEST} >>]] end,
		create {CA}.make [["my_object_array", << "String", << 1, 2 >>, {INTEGER_64} >>]] end,
		create {CA}.make [["my_object_array", << "String", << {INTEGER_8} 1, 2>> >>]] end,
		create {CA}.make [["my_object_array", << "String", << "String", << 1, 2 >> >> >>]] end,
		create {CA}.make [["my_object_array", << "String", << "String", << "String", << 1, 2 >> >> >> >>]] end,
		create {CA}.make [["my_object_array", << {INTEGER_8} 1, {INTEGER_16} 2, {INTEGER} 3, {INTEGER_64} 4,
			{NATURAL_8} 1, {NATURAL_16} 2, {NATURAL_32} 3, {NATURAL_64} 4,
			{REAL} 1.0, {DOUBLE} 2.0, "String", << 1, 2, "String", << 1, "String" >> >> >>]] end,
		create {CA}.make [["my_object_array", << 1, {ENUM_TEST}.toto, {ENUM_TEST}.titi, {ENUM_TEST}.tutu >>]] end,
		create {CA}.make [["my_object_array", << 1, {ENUM_TEST}, {INTEGER}, {SYSTEM_STRING} >>]] end,

-- Testing .NET cuystom attributes in mixmode:
		create {CA}.make (1234) [
			["my_boolean", True],
			["my_byte", 1],
			["my_sbyte", 1],
			["my_char", 'a'],
			["my_double", 1.9],
			["my_enum", {ENUM_TEST}.tutu],
			["my_float", 1.0],
			["my_int", 1],
			["my_uint", 1],
			["my_long", 123123123123123],
			["my_ulong", 123123123123123],
			["my_object", "String"],
			["my_short", 123],
			["my_ushort", 123],
			["my_string", "String"],
			["my_type", {INTEGER_64}],
			["my_boolean_array", << True >>],
			["my_byte_array", << 1 >>],
			["my_sbyte_array", << 1 >>],
			["my_char_array", << 'a' >>],
			["my_double_array", << 1.9 >>],
			["my_enum_array", << {ENUM_TEST}.tutu >>],
			["my_float_array", << 1.0 >>],
			["my_int_array", << 1 >>],
			["my_uint_array", << 1 >>],
			["my_long_array", << 123123123123123 >>],
			["my_ulong_array", << 123123123123123 >>],
			["my_object_array", << "String" >>],
			["my_short_array", << 123 >>],
			["my_ushort_array", << 123 >>],
			["my_string_array", << "String" >>],
			["my_type_array", << {INTEGER_64} >>]
			] end

class TEST

create
	make

feature

	make is
		local
			l_attributes: NATIVE_ARRAY [SYSTEM_OBJECT]
			l_object: SYSTEM_OBJECT
		do
			l_object := Current

				-- Check that we can retrieve all custom attributes
			l_attributes := l_object.get_type.get_custom_attributes (True)
			check l_attributes /= Void end

				-- Check the CA's custom attributes
			l_attributes := l_object.get_type.get_custom_attributes ({CA}, True)
			if l_attributes /= Void then
				io.put_boolean (l_attributes.count = 250)
				io.put_new_line
			end
		end

end
