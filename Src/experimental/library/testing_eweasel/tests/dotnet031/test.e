class
	TEST

create
	make

feature

	make is
		local
			t: TEST1
		do
			create {TEST2} t
			t.f
		end

end
