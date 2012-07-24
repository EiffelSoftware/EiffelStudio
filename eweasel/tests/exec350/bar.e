class BAR
inherit
	FOO
		redefine
			attr
		end

create
	make

feature

	attr: Y

	g
		do
			io.put_string (([attr]).generating_type.out)
			io.put_new_line
			io.put_string (([attr.val]).generating_type.out)
			io.put_new_line
		end

end
