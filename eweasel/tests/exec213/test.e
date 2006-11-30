class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run tests.
		local
			a: A
			b: B
			c: C
			d: D
			e: E
			f: F
			x: X
		do
			create a
			create b
			create c
			create d
			a.a := 1
			output ("a.a", a.a)
			a := b
			b.a := 2
			output ("a.a", a.a)
			a.a := 3
			output ("b.a", b.a)
			b.b := 4
			output ("b.b", b.b)
			b.e := 5
			output ("b.e", b.e)
			a := c
			x := c
			c.a := 6
			output ("a.a", a.a)
			a.a := 7
			output ("c.a", c.a)
			c.set_x (8)
			output ("x.x", x.x)
			a := d
			b := d
			c := d
			x := d
			d.a := 9
			output ("a.a", a.a)
			a.a := 10
			output ("d.a", d.a)
			b.a := 11
			output ("c.a", c.a)
			c.a := 12
			output ("b.a", b.a)
			d.b := 13
			output ("b.b", b.b)
			b.b := 14
			output ("d.b", d.b)
			d.c := 15
			output ("c.c", c.c)
			c.c := 16
			output ("d.c", d.c)
			x.set_x (17)
			output ("d.x", d.x)
			e.a := 18
			output ("e.a", e.a)
			e.e := 19
			output ("e.e", e.e)
			f.a := 20
			output ("f.a", f.a)
			f.e := 21
			output ("f.e", f.e)
			f.f := 22
			output ("f.f", f.f)
		end

feature {NONE} -- Output

	output (name: STRING; value: INTEGER) is
			-- Output `value' of an attribute `name'.
		require
			name_not_void: name /= Void
		do
			io.put_string ("Get ")
			io.put_string (name)
			io.put_character ('=')
			io.put_integer (value)
			io.put_new_line
		end

end