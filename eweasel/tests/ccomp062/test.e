class TEST

create
	make

feature
	
	make is
		local
			l_str: STRING
		do
			l_str := once "ME"
		end

	ext is
		external
			"C++ inline"
		alias
			"return;"
		end

end
