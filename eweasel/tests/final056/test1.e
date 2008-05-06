class TEST1 [G]
inherit
	TEST2 [G, G]

create
	make

feature

	make_bad is
		do
			special_integer.do_nothing
		end

	special_integer: STRING is
		do
			create Result.make (10)
		end

end
