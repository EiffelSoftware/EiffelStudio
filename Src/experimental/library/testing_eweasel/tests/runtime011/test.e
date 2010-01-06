class TEST

inherit
	MEMORY
	INTERNAL

create
	make

feature

	make is
		local
			i: INTEGER
			s: STRING
			t1: TUPLE [x: INTEGER; string: STRING]
			t2: TUPLE [x, y, z: INTEGER]
			arr: ARRAY [STRING]
		do
				-- Fill the scavenge zone
			create arr.make (1, 250000)
			from
				i := 1
			until
				i > 250000
			loop
				arr.put ("12345678901234567890", i)
				i := i + 1
			end

			collection_off

			create array1.make (1, size)
			create array2.make (1, size)
			create array3.make (1, size)


			s := "My beautiful string"
			t1 := [1, s]
			t2 := [1, 2, 3]

				-- Create object of size 4
			from
				i := 1
			until
				i > size
			loop
				array1.put (t2.twin, i)
				i := i + 1
			end

				-- Create half of the size 4 objects
			from
				i := 1
			until
				i > size
			loop
				array1.put (Void, i)
				i := i + 2
			end

			collection_on
				-- By collecting we create a lot of empty size 4 zone.
			full_collect
			collection_off

				-- Create object of size 3, but will actually be of size 4
			from
				i := 1
			until
				i > size
			loop
				array2.put (t1.twin, i)
				check t1.is_equal (array2.item (i)) end
				i := i + 1
			end

			collection_on

				-- Duplicate the object created at the previous iteration,
				-- if everything goes fine no crash.
			from
				i := 1
			until
				i > size
			loop
				array3.put (array2.item (i).twin, i)
				check t1.is_equal (array3.item (i)) end
				i := i + 1
			end

			s := Void
			t1 := Void
			t2 := Void

				-- A full collect can also verify that all our objects are not corrupted.
			full_collect

				-- Verify that the content is exactly what we expect.
			s := "My beautiful string"
			from
				i := 1
			until
				i > size
			loop
				t1 := array2.item (i)
				if t1.count /= 2 or not t1.string.is_equal (s) then
					io.put_string ("Problem%N")
				end
				i := i + 1
			end

			from
				i := 1
			until
				i > size
			loop
				t1 := array3.item (i)
				if t1.count /= 2 or not t1.string.is_equal (s) then
					io.put_string ("Problem%N")
				end
				i := i + 1
			end

		end

	size: INTEGER is 100000

	array1: ARRAY [ANY]
	array2, array3: ARRAY [TUPLE [x: INTEGER; string: STRING]]

end
