class TEST
inherit
	TEST1
create
	make
feature
	make is
		local
			t: TEST1
		do
			create t
			print (agent f (True))
		end

	te: TEST1

end
