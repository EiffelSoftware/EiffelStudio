class TEST
		
create
	make

feature {NONE}

	make is
		local
			t1: TEST1 [ANY]
			t2: TEST1 [DOUBLE]
			ha: HASH_TABLE [ANY, INTEGER]
			hi: HASH_TABLE [INTEGER, INTEGER]
			haa: HASH_TABLE [ANY, HASHABLE]
		do
			create {HASH_TABLE [STRING, INTEGER]} ha.make (10)
			create hi.make (1)
			hi.compare_objects
			hi.extend (1, 1)
			hi.extend (2, 2)
			hi.remove (1)
			hi.search (2)
			hi.start
			hi.forth
			ha := hi
			print (hi.count) print (" should be 1%N")
			print (ha.count) print (" should be 1%N")

			create hi.make (1)
			ha := hi
			ha.compare_objects
			ha.extend (1, 1)
			ha.extend (2, 2)
			ha.remove (1)
			ha.search (2)
			ha.start
			ha.forth
			print (hi.count) print (" should be 1%N")
			print (ha.count) print (" should be 1%N")

			create hi.make (1)
			haa := hi
			haa.put (2, 2)
			print (hi.item (2)) print (" should be 2%N")
			haa.accommodate (100)
			print (hi.item (2)) print (" should be 2%N")

			create t2.make (4.0, "foo", "bar")
			t1 := t2
			print (t1.a) print ("%N")
			print (t1.b) print ("%N")
			print (t1.c) print ("%N")

			print (t1.a.generating_type) print ("%N")
			print (t1.b.generating_type) print ("%N")
			print (t1.c.generating_type) print ("%N")
		end


end
