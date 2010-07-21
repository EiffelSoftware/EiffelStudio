class
	TEST

create
	make

feature

	make
		local
			d: REAL_64
			r: REAL_32
			P: MANAGED_POINTER
			n64: NATURAL_64
			n32: NATURAL_32
		do
			create p.make (100)

			d := {REAL_64}.min_value
			p.put_real_64 (d, 0)
			n64 := p.read_natural_64 (0)
			check_equality (n64 = 0xFFEFFFFFFFFFFFFF, "{REAL_64}.min_value")
			d := {REAL_64}.max_value
			p.put_real_64 (d, 0)
			n64 := p.read_natural_64 (0)
			check_equality (n64 = 0x7FEFFFFFFFFFFFFF, "{REAL_64}.max_value")

			r := {REAL_32}.min_value
			p.put_real_32 (r, 0)
			n32 := p.read_natural_32 (0)
			check_equality (n32 = 0xFF7FFFFF, "{REAL_32}.min_value")
			r := {REAL_32}.max_value
			p.put_real_32 (r, 0)
			n32 := p.read_natural_32 (0)
			check_equality (n32 = 0x7F7FFFFF, "{REAL_32}.max_value")
		end

	check_equality (b: BOOLEAN s: STRING)
		do
			if not b then
				io.put_string ("Wrong value for " + s)
				io.put_new_line
			end
		end

end
