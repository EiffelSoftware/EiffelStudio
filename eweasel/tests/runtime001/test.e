class TEST

create
	make

feature {NONE} -- Initialization

	make is
		do
			create s.make (10)
			resize
		end

	resize is
		local
			i: INTEGER
		do
			i := s.count
			if 5 >= i then
				if s = trigger_gc then
					s := "TEST"
				else
					if is_forwarded (s) then
						print ("Failure: object is marked with B_FWD.%N")
					end
				end
			end
		end

	is_forwarded (a_string: STRING): BOOLEAN is
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

	s: STRING

	trigger_gc: STRING is
		local
			mem: MEMORY
		do
			create mem
			mem.collect
		end

end
