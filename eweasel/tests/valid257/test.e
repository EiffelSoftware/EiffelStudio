class
	TEST

create
	make

feature

	make
		local
			a: FINITE [ANY]
			s: STRING
			i: INTEGER
		do
			s := ""
			a := << s, i >>
		end

end
