class
	TEST1 [G]

feature

	f
		local
			t: TEST1 [like Current]
			ta: TEST1 [ANY]
			int: INTERNAL
		do
			create int

			create t
			create ta

			if c_dtype(int.dynamic_type (t)) = c_dtype(int.dynamic_type (ta)) then
				io.put_string ("Failure%N")
			end
		end

	c_dtype (dftype: INTEGER): INTEGER
		external
			"C inline use %"eif_eiffel.h%""
		alias
			"return To_dtype($dftype);"
		end

end
