class TEST

create
	make

feature

	make
		local
			mem: MEMORY
			t: STRING
			i: INTEGER
			a: SPECIAL [CHARACTER_8]
			l_any: ANY
			t1: TUPLE [ptr: POINTER]
			tp: POINTER
		do
			create mem
			mem.collection_off

			t := "0123456789"
			i := t.count

			io.put_string ("Printing count via local variable:%N")
			c_put_integer_1 ($i)
			c_put_integer_2 ($i)

			io.put_string ("Printing count via address expression:%N")
			c_put_integer_1 ($(t.count))
			c_put_integer_2 ($(t.count))

			a := t.area
			l_any := t.to_c
			io.put_string ("Printing string via local variable:%N")
			c_put_string ($a)
			c_put_string ($l_any)

			io.put_string ("Printing string via assignment to a tuple entry:%N")
			tp := $a
			t1 := [tp]
			c_put_string (t1.ptr)

			io.put_string ("Printing string via address expression:%N")
			c_put_string ($(t.to_c))
			c_put_string ($(t.area))
		end

	c_put_string (p: POINTER)
		external
			"C inline"
		alias
			"printf (%"%%s\n%", $p);"
		end

	c_put_integer_1 (p: POINTER)
		external
			"C inline"
		alias
			"printf (%"%%d\n%", *(EIF_INTEGER *) $p);"
		end

	c_put_integer_2 (p: TYPED_POINTER [INTEGER])
		external
			"C inline"
		alias
			"printf (%"%%d\n%", *(EIF_INTEGER *) $p);"
		end

end
