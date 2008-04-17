class TEST
create
	make

feature {NONE} -- Creation

	make
		local
			t9: TEST9
			t8: TEST8
			t7: TEST7
			t6: TEST6
			t5: TEST5
			t4: TEST4
			t3_bis: TEST3_BIS
			t2_bis: TEST2_BIS
			t3: TEST3 [INTEGER]
			t3_any: TEST3 [ANY]
			t2: TEST2 [REAL_64]
			t2_any: TEST2 [ANY]
			t1: TEST1
		do
			create t9
			create t8
			create t7
			create t5
			create t4
			create t3_bis
			create t2_bis

				-- Checking polymorphism on `t9'
			print (t9.query (6))
			io.put_new_line

			t6 := t9
			print (t6.query (6))
			io.put_new_line

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

			t3_any := t5
			print (t3_any.query (6))
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

			t2_any := t4
			print (t2_any.query (6))
			io.put_new_line

				-- Checking polymorphism on `t3_bis'
			print (t3_bis.query (6))
			io.put_new_line

			t3 := t3_bis
			print (t3.query (6))
			io.put_new_line

			t3_any := t3_bis
			print (t3_any.query (6))
			io.put_new_line


				-- Checking polymorphism on `t2_bis'
			print (t2_bis.query (6))
			io.put_new_line

			t2 := t2_bis
			print (t2.query (6))
			io.put_new_line

			t2_any := t2_bis
			print (t2_any.query (6))
			io.put_new_line
		end

end
