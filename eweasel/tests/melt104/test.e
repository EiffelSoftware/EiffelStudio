class TEST

create
	make

feature

	make
		local
			t: STRING
		do
			create t.make_empty
			c_test ($(t.to_c))
		end

	c_test (p: POINTER)
		external
			"C inline"
		alias
			"return;"
		end

end
