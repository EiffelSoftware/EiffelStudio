class TEST1

create
	make

feature

	foo: ANY

	make (a_foo: like foo)
		local
			t3: TEST3 [like foo]
		do
			foo := a_foo
			create t3.make (a_foo)
			io.put_string (([t3.item]).generating_type.name)
			io.put_new_line
		end


end
