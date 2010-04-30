class TEST

create
	make

feature {NONE} -- Creation

	make
		local
			i1: like {COMPARABLE}.twin.is_less.io
			i2: like f.twin.is_less.io
			i3: like {TEST}.f.twin.is_less.io
			i4: like twin.f.twin.is_less.io
		do
			create i1
			i1.put_string ("TEST1: OK")
			i1.put_new_line
			create i2
			i2.put_string ("TEST2: OK")
			i2.put_new_line
			create i3
			i3.put_string ("TEST3: OK")
			i3.put_new_line
			create i4
			i4.put_string ("TEST4: OK")
			i4.put_new_line
		end

feature {NONE} -- Test

	f: detachable COMPARABLE

end
