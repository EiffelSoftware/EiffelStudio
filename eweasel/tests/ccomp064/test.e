class TEST
inherit
	TEST1 [STRING]
		
create
	make

feature {NONE}

	make is
		local
			t: TEST2
			s: TEST1 [STRING]
		do
			create t
			s := t
			print (s.x)
			print ("%N")
		end


	x: STRING is "TEST"

end
