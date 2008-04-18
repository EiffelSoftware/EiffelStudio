class TEST
inherit
	MEM_CONST
	ARGUMENTS

create
	make

feature

	make is
		local
			k, count: INTEGER
			fname1: STRING
			fname2: MY_STRING
			b: B [INTEGER]
			d: D [INTEGER]
			c: C [ANY]
		do
			create mem.make (Eiffel_memory)
			(create {MEMORY}).collection_off
			create b
			create d
			c := d
			create fname2.make_from_string ("abc")
			fname1 := fname2

			from
				k := 1;
				count := argument (1).to_integer
			until
				k > count
			loop
				try (fname1, b, d, k)
				mem.update (Eiffel_memory);
				check_memory (mem);
				k := k + 1;
			end
		end;

	try (fname: STRING; a: A [INTEGER]; c: C [INTEGER]; v: INTEGER)
		require
			a_not_void: a /= Void
			c_not_void: c /= Void
			fname_not_void: fname /= Void
		local
			i: INTEGER
		do
			if not fname.has (Version_separator) then
				fname.extend (Version_separator)
			end
			if c.attr = v then
			end
			if c.has (v) then
			end
			i := c.item (v)
			if i /= v + v then
				io.put_string ("Bug for C%N")
			end

			if a.attr = v then
			end
			if a.has (v) then
			end
			i := a.item (v)
			if i /= v + v then
				io.put_string ("Bug for A%N")
			end
		end

	version_separator: CHARACTER = ';'

	mem: MEM_INFO;
	already_displayed: BOOLEAN

	check_memory (m: MEM_INFO) is
		do
			if m.used > 100_000 and not already_displayed then
				already_displayed := True
				display_memory (m);
			end
		end

	display_memory (m: MEM_INFO) is
		do
			io.putint (m.type);
			io.putchar ('%T');
			io.putint (m.used);
			io.putchar ('%T');
			io.putint (m.free);
			io.putchar ('%T');
			io.putint (m.overhead);
			io.putchar ('%T');
			io.putint (m.total);
			io.new_line;
		end
end

