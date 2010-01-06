class TEST

create
	make

feature {NONE} -- Creation

	make is
		local
			a: A
			i: I
			o: SYSTEM_OBJECT
			h: INTEGER
		do
			create a
			h := a.get_hash_code
			i := a
			io.put_boolean (i.get_hash_code = h)
			io.put_new_line
			o := a
			io.put_boolean (o.get_hash_code = h)
			io.put_new_line
		end

end
