class TEST

create
	make

feature {NONE}

	make
		do
			g (2, 1)
			io.put_string ("$STRING_OUTPUT")
			io.put_new_line
		end

	g (n16: NATURAL_16; n32: NATURAL_32)
		require
			n16 > n32
		external
			"C inline"
		alias
			""
		end

end
