class STORABLE_A55

inherit

	ANY
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create is
		local
			l_gen_s: expanded STORABLE_C55 [STRING]
			l_gen_gen_s: expanded STORABLE_C55 [expanded STORABLE_C55 [STRING]]
		do
			int := 32
			int_8 := 8
			int_16 := 16
			int_64 := 64
			char := 'b'
			bool := True
			real := {REAL_32} 32.5
			double := 64.5
			ref := "toto"
			--none := Void
			int_ref := 132
			int_8_ref := 108
			int_16_ref := 116
			int_64_ref := 164
			char_ref := 'c'
			bool_ref := True
			real_ref := 132.5
			double_ref := 164.5
			pointer_ref := default_pointer
			exp_ref := exp
			create arr_int.make_filled (0, 1, 5)
			arr_int.put (32, 1)
			arr_int.put (33, 2)
			arr_int.put (34, 3)
			arr_int.put (35, 4)
			arr_int.put (36, 5)
			create arr_int_8.make_filled (0, 1, 5)
			arr_int_8.put (8, 1)
			arr_int_8.put (9, 2)
			arr_int_8.put (10, 3)
			arr_int_8.put (11, 4)
			arr_int_8.put (12, 5)
			create arr_int_16.make_filled (0, 1, 5)
			arr_int_16.put (16, 1)
			arr_int_16.put (17, 2)
			arr_int_16.put (18, 3)
			arr_int_16.put (19, 4)
			arr_int_16.put (20, 5)
			create arr_int_64.make_filled (0, 1, 5)
			arr_int_64.put (64, 1)
			arr_int_64.put (65, 2)
			arr_int_64.put (66, 3)
			arr_int_64.put (67, 4)
			arr_int_64.put (68, 5)
			create arr_char.make_filled ('%U', 1, 5)
			arr_char.put ('z', 1)
			arr_char.put ('y', 2)
			arr_char.put ('x', 3)
			arr_char.put ('w', 4)
			arr_char.put ('v', 5)
			create arr_bool.make_filled (False, 1, 5)
			arr_bool.put (True, 1)
			arr_bool.put (False, 2)
			arr_bool.put (True, 3)
			arr_bool.put (False, 4)
			arr_bool.put (True, 5)
			create arr_real.make_filled (0.0, 1, 5)
			arr_real.put ({REAL_32} 32.5, 1)
			arr_real.put ({REAL_32} 33.5, 2)
			arr_real.put ({REAL_32} 34.5, 3)
			arr_real.put ({REAL_32} 35.5, 4)
			arr_real.put ({REAL_32} 36.5, 5)
			create arr_double.make_filled (0.0, 1, 5)
			arr_double.put (132.5, 1)
			arr_double.put (133.5, 2)
			arr_double.put (134.5, 3)
			arr_double.put (135.5, 4)
			arr_double.put (136.5, 5)
			create arr_pointer.make_filled (default_pointer, 1, 5)
			create arr_ref.make_filled (Void, 1, 5)
			arr_ref.put ("foo1", 1)
			arr_ref.put ("foo2", 2)
			arr_ref.put ("foo3", 3)
			arr_ref.put ("foo4", 4)
			arr_ref.put ("foo5", 5)
			create arr_none.make_filled (Void, 1, 5)
			create arr_exp.make_filled (exp, 1, 5)
			create arr_gen.make_filled (l_gen_s, 1, 5)
			create arr_gen_gen.make_filled (l_gen_gen_s, 1, 5)
			create h_gen
			create h_none
			t_int := [int]
			t_int_8 := [int_8]
			t_int_16 := [int_16]
			t_int_64 := [int_64]
			t_char := ['r']
			t_bool := [True]
			t_real := [real]
			t_double := [double]
			t_pointer := [default_pointer]
			t_ref := ["foo"]
			t_none := [Void]
			t_exp := [exp]
			t_gen := [gen]
			t_gen_gen := [gen_gen]
		end

feature -- Access

	int: INTEGER
	int_8: INTEGER_8
	int_16: INTEGER_16
	int_64: INTEGER_64
	char: CHARACTER
	bool: BOOLEAN
	real: REAL
	double: DOUBLE
	pointer: POINTER
	ref: STRING
	none: NONE
	exp: expanded STORABLE_B55
	gen: expanded STORABLE_C55 [INTEGER]
	gen_gen: expanded STORABLE_C55 [expanded STORABLE_C55 [INTEGER]]

	int_ref: ANY
	int_8_ref: ANY
	int_16_ref: ANY
	int_64_ref: ANY
	char_ref: ANY
	bool_ref: ANY
	real_ref: ANY
	double_ref: ANY
	pointer_ref: ANY
	exp_ref: ANY

	arr_int: ARRAY [INTEGER]
	arr_int_8: ARRAY [INTEGER_8]
	arr_int_16: ARRAY [INTEGER_16]
	arr_int_64: ARRAY [INTEGER_64]
	arr_char: ARRAY [CHARACTER]
	arr_bool: ARRAY [BOOLEAN]
	arr_real: ARRAY [REAL]
	arr_double: ARRAY [DOUBLE]
	arr_pointer: ARRAY [POINTER]
	arr_ref: ARRAY [STRING]
	arr_none: ARRAY [NONE]
	arr_exp: ARRAY [expanded STORABLE_B55]
	arr_gen: ARRAY [expanded STORABLE_C55 [STRING]]
	arr_gen_gen: ARRAY [expanded STORABLE_C55 [expanded STORABLE_C55 [STRING]]]

	h_gen: STORABLE_D55 [ANY, expanded STORABLE_C55 [STRING]]
	h_none: STORABLE_D55 [STRING, NONE]

	t_int: TUPLE [INTEGER]
	t_int_8: TUPLE [INTEGER_8]
	t_int_16: TUPLE [INTEGER_16]
	t_int_64: TUPLE [INTEGER_64]
	t_char: TUPLE [CHARACTER]
	t_bool: TUPLE [BOOLEAN]
	t_real: TUPLE [REAL]
	t_double: TUPLE [DOUBLE]
	t_pointer: TUPLE [POINTER]
	t_ref: TUPLE [STRING]
	t_none: TUPLE [NONE]
	t_exp: TUPLE [expanded STORABLE_B55]
	t_gen: TUPLE [expanded STORABLE_C55 [INTEGER]]
	t_gen_gen: TUPLE [expanded STORABLE_C55 [expanded STORABLE_C55 [INTEGER]]]

end
