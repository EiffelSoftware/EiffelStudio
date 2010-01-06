class
	TEST

create
	make

feature

	make
		local
			b: BOOLEAN_REF
		do
			create b
			io.put_boolean (b.item)
			io.put_new_line
		end

end
