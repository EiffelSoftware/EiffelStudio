class TEST

create
	make

feature

	make
		local
			l_any: TEST1 [ANY]
			l_none: TEST2
		do
			create l_none
			l_any := l_none
			l_any.failure
		end



end
