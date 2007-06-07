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
			t3: TEST3
			t4: TEST4
			ta: TEST1 [ANY]
		do
			create t
			s := t
			print (s.x)
			io.put_new_line
			create t3
			create t4
			ta := t3
			print (ta.x)
			io.put_new_line
			ta := t4
			print (ta.x)
			io.put_new_line
		end


	x: STRING is "TEST"

end
