class
	TEST

create
	make

feature {NONE} -- Creation

	make
		do
			create t
			t.f
		end

	t: TEST1 [STRING]

end
