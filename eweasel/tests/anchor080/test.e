class TEST
create
	make
feature
	make
		local
			t: TEST1 [ANY, TEST2]
		do
			create t.make
		end
end
