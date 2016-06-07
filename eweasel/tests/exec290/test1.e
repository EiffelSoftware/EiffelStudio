class
	TEST1 [G -> ANY]

create
	make

feature

	make (v: G) is
		do
			item := v
			io.put_string (out_item (item))
			io.put_new_line
		end

	item: G

feature {NONE} -- Helper

	out_item (i: G): STRING
		require
			i_attached: i /= Void
		do
			Result := i.out
		ensure
			result_attached: Result /= Void
		end

end
