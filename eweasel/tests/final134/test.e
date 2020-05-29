class TEST

inherit
	A
		redefine
			make_with
		end

	MEMORY

create
	make,
	make_with

feature {NONE} -- Creation

	make_with (value: INTEGER_32)
		do
			i1 := value * 3
			i2 := value * 4
			i3 := value * 5
			i4 := value * 6
			i5 := value * 7
			i6 := value * 8
		end

	make
		local
			a: A
			t: TEST
		do
			set_memory_threshold (1)
			across
				1 |..| 100_000 as i
			loop
				collection_off
				create a.make_with (i.item + 1)
				create t.make_with (i.item + 2)
				collection_on
				f (a)
				f (t)
			end
		end

feature -- Access

	i3, i4, i5, i6, i7, i8, i9: INTEGER_32

feature

	f (a: A)
		do
			{TEST}.g (a)
		end

	g (a: A)
		local
			v: INTEGER_32
		do
			collection_off
			v := a.i1
			if attached {TEST} a as t then
				v := v // 3
				test (t.i1, v * 3)
				test (t.i2, v * 4)
				test (t.i3, v * 5)
				test (t.i4, v * 6)
				test (t.i5, v * 7)
				test (t.i6, v * 8)
			else
				test (a.i1, v * 1)
				test (a.i2, v * 2)
			end
			collection_on
		ensure
			class
		end

	test (x, y: INTEGER_32)
		do
			if x /= y then
				io.put_string ("Error: ")
				io.put_integer_32 (x)
				io.put_string (" = ")
				io.put_integer_32 (y)
				io.put_new_line
			end
		ensure
			class
		end

end
