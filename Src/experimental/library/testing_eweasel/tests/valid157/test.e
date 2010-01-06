class TEST

inherit
	TEST1
		redefine
			f
		end

create
    make
 
feature
 
    make is
		local
			b: BOOLEAN
			a: ANY
        do
			a := False
			b := equal (a, False)
			check
				b
			end
        end

	f (i: INTEGER) is
		local
			i16: INTEGER_16
		do
			Precursor (i16)
		end
end
