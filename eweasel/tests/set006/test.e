class
	TEST

create
	make

feature {NONE} -- Initialization

	make is
		local
			i: INTEGER
		do
			from
				i := type_lower
			until
				i > type_upper
			loop
				print_type_set (i)
				test_disjoint (i)
				test_has (i)
				test_intersect (i)
				test_is_subset (i)
				test_is_superset (i)
				test_put (i)
				test_prune (i)
				test_subtract (i)
				test_symdif (i)
				io.put_new_line
				i := i + 1
			end
			test_various
		end

feature -- Access

	part_type: INTEGER = 1
	arrayed_type: INTEGER = 2
	two_way_type: INTEGER = 3
	linked_type: INTEGER = 4
	binary_type: INTEGER = 5
			-- Various kind of sets.

	type_lower: INTEGER = 1
	type_upper: INTEGER = 5
			-- Lower and upper bounds of type of sets.

feature -- Test suite

	test_disjoint (a_type: INTEGER)
		local
			set_a, set_b: TRAVERSABLE_SUBSET [STRING]
		do
			set_a := new_set (a_type)
			set_b := new_set (a_type)

			fill_set (set_a)
			set_b.put ("Z")

			if not set_a.disjoint (set_b) then
				io.put_string ("disjoint failure #1%N")
			end

			set_b.wipe_out
			partial_fill_set (set_b)

			if set_a.disjoint (set_b) then
				io.put_string ("disjoint failure #2%N")
			end
		end

	test_has (a_type: INTEGER)
		local
			set: TRAVERSABLE_SUBSET [STRING]
			i, nb: INTEGER
		do
			set := new_set (a_type)
			fill_set (set)
			from
				i := file_name_array.lower
				nb := file_name_array.upper
			until
				i > nb
			loop
				if not set.has (file_name_array [i]) then
					io.put_string ("has failure%N")
				end
				i := i + 1
			end
		end

	test_intersect (a_type: INTEGER)
		local
			set_a, set_b, set_c: TRAVERSABLE_SUBSET [STRING]
		do
			set_a := new_set (a_type)
			set_b := new_set (a_type)
			set_c := new_set (a_type)

			fill_set (set_a)
			partial_fill_set (set_b)
			partial_fill_set (set_c)

			set_b.intersect (set_a)
			display_set ("intersect #1", set_b)

			set_a.intersect (set_c)
			display_set ("intersect #2", set_a)
		end

	test_is_subset (a_type: INTEGER)
		local
			set_a, set_b: TRAVERSABLE_SUBSET [STRING]
		do
			set_a := new_set (a_type)
			set_b := new_set (a_type)

			fill_set (set_a)
			partial_fill_set (set_b)

			if set_a.is_subset (set_b) then
				io.put_string ("is_subset failure%N")
			end

			if not set_b.is_subset (set_a) then
				io.put_string ("is_subset failure%N")
			end
		end

	test_is_superset (a_type: INTEGER)
		local
			set_a, set_b: TRAVERSABLE_SUBSET [STRING]
		do
			set_a := new_set (a_type)
			set_b := new_set (a_type)

			fill_set (set_a)
			partial_fill_set (set_b)

			if not set_a.is_superset (set_b) then
				io.put_string ("is_superset failure%N")
			end

			if set_b.is_superset (set_a) then
				io.put_string ("is_superset failure%N")
			end
		end

	test_put (a_type: INTEGER)
		local
			set: TRAVERSABLE_SUBSET [STRING]
		do
			set := new_set (a_type)
			fill_set (set)
		end

	test_prune (a_type: INTEGER)
		local
			set: TRAVERSABLE_SUBSET [STRING]
		do
			set := new_set (a_type)
			set.extend ("B")
			set.extend ("A")
			set.prune ("B")

			display_set ("prune", set)

			set.prune ("A")
			if not set.is_empty then
				io.put_string ("prune failure%N")
			end
		end

	test_subtract (a_type: INTEGER)
		local
			set_a, set_b, set_c: TRAVERSABLE_SUBSET [STRING]
		do
			set_a := new_set (a_type)
			set_b := new_set (a_type)
			set_c := new_set (a_type)

			fill_set (set_a)
			partial_fill_set (set_b)
			partial_fill_set (set_c)

			set_b.subtract (set_a)
			display_set ("subtract #1", set_b)

			set_a.subtract (set_c)
			display_set ("subtract #2", set_a)
		end

	test_symdif (a_type: INTEGER)
		local
			set_a, set_b, set_c: TRAVERSABLE_SUBSET [STRING]
		do
			set_a := new_set (a_type)
			set_b := new_set (a_type)
			set_c := new_set (a_type)

			fill_set (set_a)
			partial_fill_set (set_b)
			partial_fill_set (set_c)

			set_b.symdif (set_a)
			display_set ("symdif #1", set_b)

			set_a.symdif (set_c)
			display_set ("symdif #2", set_a)
		end

	test_various
		local
			set: TRAVERSABLE_SUBSET [STRING]
		do
			set := new_set (binary_type)
			set.extend ("B")
			set.extend ("A")
			set.extend ("D")
			set.extend ("C")
			set.extend ("E")

			set.start
			check_equal ("various", set.item, "A")
			set.forth
			check_equal ("various", set.item, "B")
			set.remove
			check_equal ("various", set.item, "C")
			set.forth
			check_equal ("various", set.item, "D")
			set.forth
			check_equal ("various", set.item, "E")
		end

feature {NONE} -- Helpers

	print_type_set (a_type: INTEGER)
		do
			io.put_string ("Testing " + new_set (a_type).generating_type.out)
			io.put_new_line
		end

	new_set (a_type: INTEGER): TRAVERSABLE_SUBSET [STRING]
		do
			inspect a_type
			when part_type then
				create {PART_SORTED_SET [STRING]} Result.make
			when arrayed_type then
				create {ARRAYED_SET [STRING]} Result.make (file_name_array.count)
			when binary_type then
				create {BINARY_SEARCH_TREE_SET [STRING]} Result.make
			when two_way_type then
				create {TWO_WAY_SORTED_SET [STRING]} Result.make
			when linked_type then
				create {LINKED_SET [STRING]} Result.make
			end
			Result.compare_objects
		ensure
			set_created: Result /= Void
			set_empty: Result.is_empty
			set_object_comparison: Result.object_comparison
		end

	fill_set (a_set: TRAVERSABLE_SUBSET [STRING])
		require
			a_set_not_void: a_set /= Void
			a_set_empty: a_set.is_empty
		local
			i, nb: INTEGER
		do
			from
				i := 1
				nb := file_name_array.count
			until
				i > nb
			loop
				a_set.put (file_name_array [i])
				i := i + 1
			end
		ensure
			a_set_filled: a_set.count = file_name_array.count
		end

	partial_fill_set (a_set: TRAVERSABLE_SUBSET [STRING])
		require
			a_set_not_void: a_set /= Void
			a_set_empty: a_set.is_empty
		local
			i, nb: INTEGER
		do
			from
				i := 1
				nb := 2
			until
				i > nb
			loop
				a_set.put (file_name_array [i])
				i := i + 1
			end
		ensure
			a_set_filled: a_set.count = 2
		end

	display_set (a_title: STRING; a_set: TRAVERSABLE_SUBSET [STRING])
		require
			a_title_not_void: a_title /= Void
			a_set_not_void: a_set /= Void
		do
			io.put_string (a_title)
			io.put_character (':')
			io.put_character (' ')
			from
				a_set.start
			until
				a_set.after
			loop
				io.put_string (a_set.item)
				a_set.forth
				if not a_set.after then
					io.put_character (',')
				end
			end
			io.put_new_line
		end

	check_equal (a_title: STRING; a, b: ANY)
		require
			a_title_not_void: a_title /= Void
		do
			if a /~ b then
				io.put_string ("Failure in " + a_title + "%N")
			end
		end

	file_name_array: ARRAY [STRING] is
			--
		once
			Result := << "B", "C", "D", "A" >>
		end

end

