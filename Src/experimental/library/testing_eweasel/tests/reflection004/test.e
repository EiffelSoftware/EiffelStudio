class
	TEST

inherit
	INTERNAL

create
	make

feature {NONE} -- Initialization

	make is
		local
			i, nb: INTEGER
		do
			from
				i := 1
				nb := field_count (Current)
			until
				i > nb
			loop
				io.put_string (field (i, Current).generating_type.out)
				io.put_new_line
				i := i + 1
			end
		end

	b: BOOLEAN

	n8: NATURAL_8
	n16: NATURAL_16
	n32: NATURAL_32
	n64: NATURAL_64
	i8: INTEGER_8
	i16: INTEGER_16
	i32: INTEGER_32
	i64: INTEGER_64

	c8: CHARACTER_8
	c32: CHARACTER_32

	r32: REAL_32
	r64: REAL_64

	p: POINTER

end
