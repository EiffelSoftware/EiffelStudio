class
	TEST

create
	make

feature {NONE} -- Initialization

	make
		local
			l_a: A
			l_aa: !A

		do
			create l_a
			l_a := l_a.item
			
			create l_aa
			l_aa := l_aa.item
		end

end

