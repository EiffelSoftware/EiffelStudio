class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run test.
		local
			l_native: NATIVE_ARRAY [DECIMAL]
			l_decimal: DECIMAL
			a: ANY
			o: SYSTEM_OBJECT
		do
			create l_native.make (10)
			l_native.put (1, l_decimal)
			a := l_decimal

			a := 1
			o := 1

			a := l_decimal
			o := l_decimal
		end

end
