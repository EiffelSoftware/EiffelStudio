class TEST
create
	make

feature

	make is
		local
			t: TEST2 [$ACTUAL]
		do
			create t
			t.make
		end

end
