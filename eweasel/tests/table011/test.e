class
	TEST

create
	make

feature

	make
		local
			t1, t2: HASH_TABLE [INTEGER, INTEGER]
		do
			create t1.make (0)
			create t2.make (0)

			assert ("empty sets disjoint",  t1.disjoint (t2))

			t1.put (1, 1)
			t1.put (1, 2)
			t1.put (1, 3)
			t1.put (1, 4)
			t1.put (1, 5)

			assert ("one empty set disjoint", t1.disjoint (t2))
			assert ("one empty set disjoint", t2.disjoint (t1))

			t2.put (1, -1)
			t2.put (1, -2)
			t2.put (1, -3)
			t2.put (1, -4)
			t2.put (1, -5)

			assert ("disjoint sets", t1.disjoint (t2))
			assert ("disjoint sets", t2.disjoint (t1))

			t2.put (1, 1)
			assert ("non-disjoint sets", not t1.disjoint (t2))
			assert ("non-disjoint sets", not t2.disjoint (t1))
		end

	assert (tag: STRING; v: BOOLEAN)
		do
			if not v then
				io.put_string (tag)
				io.put_new_line
			end
		end

end
