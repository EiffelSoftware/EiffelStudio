class TEST
create
	make

feature
	make is
		local
			t: TEST1 [INTEGER]
		do
			create t.make (5)
		end

end
