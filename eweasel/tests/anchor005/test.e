class TEST

create
	make

feature {NONE} -- Creation

	make
		local
			i1: like {COMPARABLE}.is_less.io
			i2: like f.is_less.io
			i3: like {TEST}.f.is_less.io
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
			create {ARRAYED_LIST [like list.item]} list.make (5)
			i3.put_string ("TEST4: OK")
			i3.put_new_line
		end

feature {NONE} -- Test

	f: detachable COMPARABLE

	list: LIST [TUPLE [TEST, NATURAL_8]]

end
