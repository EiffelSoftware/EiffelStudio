class TEST
create
	make

feature {NONE} -- Creation

	make
		local
			t8: TEST8
			t7: TEST7
			t6: TEST6
			t5: TEST5
			t4: TEST4
			t2: TEST2 [REAL_64]
			t3: TEST3 [INTEGER]
			t1: TEST1
		do
			create t8
			create t7
			create t5
			create t4

				-- Checking polymorphism on `t8'
			print (t8.query (6))
			io.put_new_line

			t1 := t8
			print (t1.query (6))
			io.put_new_line

			t6 := t8
			print (t6.query (6))
			io.put_new_line

				-- Checking polymorphism on `t7'
			print (t7.query (6))
			io.put_new_line

			t1 := t7
			print (t1.query (6))
			io.put_new_line

			t6 := t7
			print (t6.query (6))
			io.put_new_line

				-- Checking polymorphism on `t5'
			print (t5.query (6))
			io.put_new_line

			t1 := t5
			print (t1.query (6))
			io.put_new_line

			t3 := t5
			print (t3.query (6))
			io.put_new_line

				-- Checking polymorphism on `t4'
			print (t4.query (6))
			io.put_new_line

			t1 := t4
			print (t1.query (6))
			io.put_new_line

			t2 := t4
			print (t2.query (6))
			io.put_new_line
		end

end
