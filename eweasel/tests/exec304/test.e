
class TEST

create
	make

feature

	make
		local
			i8:  TEST2 [INTEGER_8]
			i16: TEST2 [INTEGER_16]
			i32: TEST2 [INTEGER_32]
			i64: TEST2 [INTEGER_64]
			n8:  TEST2 [NATURAL_8]
			n16: TEST2 [NATURAL_16]
			n32: TEST2 [NATURAL_32]
			n64: TEST2 [NATURAL_64]
			r:   TEST2 [REAL]
			d:   TEST2 [DOUBLE]
		do
			create i8
			i8.weasel
			create i16
			i16.weasel
			create i32
			i32.weasel
			create i64
			i64.weasel
			
			create n8
			n8.weasel
			create n16
			n16.weasel
			create n32
			n32.weasel
			create n64
			n64.weasel
			
			create r
			r.weasel
			create d
			d.weasel
		end

end
