class TEST
create
	make

feature {NONE}

	make
		do
			n16 := {NATURAL_16} 2
			n32 := {NATURAL_32} 1
			g
			io.put_string ("$STRING_OUTPUT")
			io.put_new_line
		end

	n16: NATURAL_16
	n32: NATURAL_32

	g
		require
			n16 > n32
		external
			"C inline"
		alias
			""
		end

end
