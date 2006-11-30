class TEST
inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	nb: INTEGER

	make is
		do
			nb := argument (1).to_integer_32
			set_call (1)
		end

	set_call (a: ANY) is
		local
			i: INTEGER
			x: X
		do
			from
				i := 0
			until
				i >= nb
			loop
				test_ref_ref_argument (a)
				test_exp_ref_argument (x)
				test_exp_exp_argument (x)
				test_bas_ref_argument
				test_ref_ref_attribute (a); check_object (ref_attribute)
				test_exp_ref_attribute (x); check_object (ref_attribute)
				test_exp_exp_attribute (x); check_object (exp_attribute)
				test_bas_ref_attribute; check_object (ref_attribute)
				test_ref_ref_equality (a, a)
				test_exp_ref_equality (x, a)
				test_exp_exp_equality (x, x)
				test_bas_ref_equality (a)
				i := i + 1
			end
		end

	ref_attribute: ANY

	exp_attribute: X

	test_ref_ref_argument (a: ANY) is
		do
			set_other_field (a, Current)
		end

	test_exp_ref_argument (a: X) is
		do
			set_other_field (a, Current)
		end

	test_exp_exp_argument (a: X) is
		do
			set_x (a, Current)
		end

	test_bas_ref_argument is
		do
			set_other_field (5, Current)
		end

	test_ref_ref_attribute (a: ANY) is
		do
			ref_attribute := a
		end

	test_exp_ref_attribute (a: X) is
		do
			ref_attribute := a
		end

	test_exp_exp_attribute (a: X) is
		do
			exp_attribute := a
		end

	test_bas_ref_attribute is
		do
			ref_attribute := 5
		end

	test_ref_ref_equality (a: ANY; b: ANY) is
		do
			check_object_eq (a = b, Current)
		end
	
	test_exp_ref_equality (a: X; b: ANY) is
		do
			check_object_eq (a = b, Current)
		end
	
	test_exp_exp_equality (a: X; b: X) is
		do
			check_object_eq (a = b, Current)
		end
	
	test_bas_ref_equality (a: ANY) is
		do
			check_object_eq (a = 5, Current)
		end

	set_other_field (a, b: ANY) is
		do
			check_object (b)
		end

	set_x (a: X; b: ANY) is
		do
			check_object (b)
		end

	check_object_eq (a: BOOLEAN; b: ANY) is
		do
			check_object (b)
		end

	check_object (a: ANY) is
		do
			if is_forwarded (a) then
				print ("ERROR%N")
			end
		end

	is_forwarded (a_string: ANY): BOOLEAN is
		do
			forwarded ($a_string, $Result)
		end

	forwarded (p: POINTER; b: TYPED_POINTER [BOOLEAN]) is
			--
		external
			"C inline use %"eif_eiffel.h%""
		alias
			"[
#ifdef EIF_IL_DLL
				*(EIF_BOOLEAN *) $b = EIF_FALSE;
#else
				*(EIF_BOOLEAN *) $b = EIF_TEST(((union overhead *) $p -1)->ov_size & B_FWD);
#endif
			]"
		end

end
