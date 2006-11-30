class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run test.
		local
			a: ANY
			i: INTEGER
			x: X
			n: NATURAL_8
			gia: A [INTEGER, ANY]
			gxa: A [X, ANY]
			gii: A [INTEGER, INTEGER]
			gxx: A [X, X]
		do
			from
			until
				n >= 10
			loop
				n := n + 1
				io.put_string ("Test #")
				io.put_integer (n // 10)
				io.put_integer (n \\ 10)
				io.put_string (": ")
				inspect n
				when 1 then
					i := 1
					a := i
					i := 2
					i ?= a
					io.put_integer (i)
				when 2 then
					i := 1
					a := i
					x.i := 2
					x ?= a
					io.put_integer (x.i)
				when 3 then
					x.i := 1
					a := x
					x.i := 2
					x ?= a
					io.put_integer (x.i)
				when 4 then
					x.i := 1
					a := x
					i := 2
					i ?= a
					io.put_integer (i)
				when 5 then
					create gia
					gia.put (1)
					io.put_integer (gia.i)
				when 6 then
					create gia
					gia.put (2)
					gia.put ("a")
					io.put_integer (gia.i)
				when 7 then
					create gxa
					x.i := 1
					gxa.put (x)
					io.put_integer (gxa.i.i)
				when 8 then
					create gxa
					x.i := 2
					gxa.put (x)
					gxa.put ("a")
					io.put_integer (gxa.i.i)
				when 9 then
					create gii
					gii.put (1)
					io.put_integer (gii.i)
				when 10 then
					create gxx
					x.i := 2
					gxx.put (x)
					io.put_integer (gxx.i.i)
				end
				io.put_new_line
			end
		rescue
			io.put_string ("exception")
			io.put_new_line
			retry
		end

end
