class TEST

create
	make

feature 

	a: A
	t: TEST1

	make is
		do
			t.process_a (a)
		end

end
