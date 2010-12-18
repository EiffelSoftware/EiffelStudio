class TEST

create
	make

feature

	make
		local
			ti64: TEST1 [INTEGER_64]
			tr64: TEST1 [REAL_64]
			r64: REAL_64
			i64: INTEGER_64
		do
			create ti64
			create tr64

			r64 := 5.0
			i64 := 5

			ti64.test_standard_twin (i64)
			tr64.test_standard_twin (r64)

			if ti64.value /= i64 then
				io.put_string ("Not OK!%N")
			end
			
			if tr64.value /= r64 then
				io.put_string ("Not OK!%N")
			end

			r64 := 8.0
			i64 := 8

			ti64.test_twin (i64)
			tr64.test_twin (r64)

			if ti64.value /= i64 then
				io.put_string ("Not OK!%N")
			end
			
			if tr64.value /= r64 then
				io.put_string ("Not OK!%N")
			end
		end

end
