class TEST

create
	make

feature {NONE} -- Initialization

	make is
		do
			func := agent new_string
			func2 := agent new_integer
			trigger_gc (100)
			func.call (Void)
			trigger_gc (1)
			if is_forwarded (func.last_result) then
				print ("Failure: object is marked with B_FWD.%N")
			end
			func2.call (Void)
			if func2.last_result /= 4 then
				print ("Failure: value is not correct.%N")
			end
		end

	func: FUNCTION [ANY, TUPLE, STRING]
	func2: FUNCTION [ANY, TUPLE, INTEGER]

	new_string: STRING is
		do
			create Result.make (10)
		end

	new_integer: INTEGER is
		do
			Result := 4
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

	trigger_gc (n: INTEGER) is
		local
			mem: MEMORY
			i: INTEGER
		do
			create mem
			from
				i := 0
			until
				i = n
			loop
				mem.collect
				i := i + 1
			end
		end

end
