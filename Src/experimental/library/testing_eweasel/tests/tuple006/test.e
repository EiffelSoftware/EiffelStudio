class TEST

create
    make

feature

	make is
		local
			t1, t2: TUPLE [a:STRING_8; b: ANY; c:HASH_TABLE [STRING, STRING]]
			l_table: HASH_TABLE [STRING, STRING]
			l_obj: SPECIAL [detachable ANY]
			i, j: INTEGER
		do
			create l_table.make (10)
			l_table.put ("ISE_EIFFEL", "/home/Eiffel60")

			from
				i := 1
				create l_obj.make_filled (Void, 1000)
			until
				i = 1000
			loop
				l_obj.put (create {SPECIAL [INTEGER]}.make_filled (0, 128), i)
				i := i + 1
			end

			t1 := ["TEST", l_obj, l_table]

				-- Twin test
			from
				i := 1
			until
				i = 10000
			loop
				t2 := t1.twin
				if
					t2 = Void or
					t2.a = Void or
					t2.b = Void or
					t2.c = Void or
					not equal (t1.a, t2.a) or
					not equal (t1.b, t2.b) or
					not equal (t1.c, t2.c) or
					t2.a.count /= t1.a.count
				then
					j := j + 1
					print ("Failure twin at " + i.out + "%N")
				end
				i := i + 1
			end
			if j > 0 then
				print (j.out + " failures with twin.%N")
			end

				-- Deep_twin test
			from
				i := 1
				j := 0
			until
				i = 10000
			loop
				t2 := t1.deep_twin
				if
					t2 = Void or
					t2.a = Void or
					t2.b = Void or
					t2.c = Void or
					not equal (t1.a, t2.a) or
					not deep_equal (t1.b, t2.b) or
					not deep_equal (t1.c, t2.c) or
					t2.a.count /= t1.a.count
				then
					j := j + 1
					print ("Failure deep_twin at " + i.out + "%N")
				end
				i := i + 1
			end
			if j > 0 then
				print (j.out + " failures with deep_twin.%N")
			end

		end

end
