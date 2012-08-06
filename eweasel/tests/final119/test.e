class TEST
create
	make
feature
	make
		local
			t: TEST1
		do
			create {TEST2} t.make
		end

end
