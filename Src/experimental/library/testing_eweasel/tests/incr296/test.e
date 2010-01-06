class
	TEST

create
	make

feature

	make
		local
			t1: TEST1
		do
			create t1
			t1.f (Void)
		end
end
