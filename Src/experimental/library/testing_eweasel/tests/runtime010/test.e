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
		t1, t2: TIME
	do
		create array1.make(1, size)
		create array2.make(1, size)
		create array3.make(1, size)

		from
			i := 1
		until
			i>size
		loop
			array1.put(create {THREE_REFS}.make, i)
			i := i + 1
		end

		from
			i := 1
		until
			i>size
		loop
			array2.put(array1.item(i).twin, i)
			i := i + 1
		end

		array1 := Void
		full_collect

		from
			i := 1
		until
			i>size
		loop
			array3.put(create {TWO_INTS}, i)
			i := i + 1
		end

		from
			i := 1
		until
			i>(size/2).truncated_to_integer
		loop
			array3.put(Void, i)
			i := i + 1
		end

		create t1.make_now
		full_collect
		create t2.make_now

		if (t2.relative_duration (t1).fine_second > 5) then
			io.put_string ("We have a problem%N")
		end
	end

	size: INTEGER is 1000000

	array1: ARRAY[ANY]

	array2: ARRAY[ANY]

	array3: ARRAY[ANY]

end
