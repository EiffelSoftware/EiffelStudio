class
	TEST

create
	make

feature -- Initialization

	make
			-- Creation procedure.
		do
			create ht1.make (10)
			ht1.put ("1", "1")
			ht1.put ("2", "2")
			ht1.put ("3", "3")
			ht1.put ("0", Void)
			ht1.remove ("1")
			ht1.put ("4", "4")

			create ht2.make (10)
			ht2.put (1, 1)
			ht2.put (2, 2)
			ht2.put (3, 3)
			ht2.put (0, 0)
			ht2.remove (1)
			ht2.put (4, 4)
--			store
			retrieve
		end

feature -- Implementation

	store
		local
			l_file: RAW_FILE
		do
			create l_file.make_open_write ("data")
			l_file.independent_store (Current)
			l_file.close
		end

	retrieve
		local
			a: like Current
			l_file: RAW_FILE
			comp1: HASH_TABLE_COMPARATOR [STRING, detachable STRING]
			comp2: HASH_TABLE_COMPARATOR [INTEGER, INTEGER]
		do
			create l_file.make_open_read ("data")
			a ?= l_file.retrieved
			l_file.close

			create comp1
			if not comp1.same_table (ht1, a.ht1) then
				io.put_string ("Not OK!%N")
			end

			create comp2
			if not comp2.same_table (ht2, a.ht2) then
				io.put_string ("Not OK!%N")
			end

			create l_file.make_open_read ("data")
			a ?= l_file.retrieved
			l_file.close

			a.ht1.put ("5", "5")
			a.ht2.put (5, 5)
			a.ht1.remove ("3")
			a.ht2.remove (3)
		end

	ht1: HASH_TABLE [STRING, detachable STRING]
	ht2: HASH_TABLE [INTEGER, INTEGER]

end
