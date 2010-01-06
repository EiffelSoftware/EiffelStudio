class
	TEST
create
	make

feature
	make
		do
			create multi
			multi.foo (0)
		end

	multi: MULTI [INTEGER_REF]

end
