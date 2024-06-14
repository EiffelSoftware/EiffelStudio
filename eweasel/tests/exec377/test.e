note
	description: "Summary description for {TEST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST

create
	make

feature

	make
		local
			a: A
			b: B
			c: C
			d: D
		do
			create a.make ("A")
			output (a.name)
			output (a.code)
			output (a.to_string)
			io.put_new_line

			create b.make ("B")
			output (b.name)
			output (b.code)
			output (b.to_string)
			io.put_new_line

			create c.make ("C")
			output (c.name)
			output (c.code)
			output (c.to_string)
			io.put_new_line

			create d.make ("B", "C")
			output (d.name_b)
			output (d.name_c)
			output (d.code)
			output (d.to_string)
			io.put_new_line

			a := d
			output (a.name)
			output (a.code)
			output (a.to_string)
			io.put_new_line

			b := d
			output (b.name)
			output (b.code)
			output (b.to_string)
			io.put_new_line

			c := d
			output (c.name)
			output (c.code)
			output (c.to_string)
			io.put_new_line
		end

	output (s: detachable STRING)
		do
			if s = Void then
				io.put_string ("Void")
			else
				io.put_string (s)
			end
			io.put_new_line
		end

end
