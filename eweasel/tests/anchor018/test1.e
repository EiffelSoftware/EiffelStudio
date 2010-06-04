class TEST1 [G -> BAR create default_create end]
feature

	g: G

	test
		local
			t: like g.foo
		do
			create t$(CREATION_PROCEDURE)
			io.put_string (t.generating_type)
			io.put_new_line
		end

end
