class
	TEST1 [G]

feature

	f
			-- This routine is meant to be called on a target of type TEST2, an expanded descendant of TEST1.
		local
			t: TEST1 [like Current]
			ta: TEST1 [ANY]
			int: INTERNAL
		do
			create int

			create t
			create ta

				-- First we check that they do not have the same type, which is clearly
				-- the case since `t' will be of type {TEST1 [TEST2]} and `ta' of type {TEST1 [ANY]}.
			if int.dynamic_type (t) = int.dynamic_type (ta) then
				io.put_string ("Same dynamic type, Failure%N")
			end

				-- Then we check that at our implementation level, the generic derivation for `t' and `ta'
				-- is not the same as `t' represents a generic derivation of an expanded type and it cannot
				-- be the same as one representing a reference type.
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
