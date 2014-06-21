class TEST

create
	make

feature {NONE}

	make
		do
			create child
			io.put_string (child.new_creation_objects.generating_type.name)
			io.put_new_line
		end

	child: TEST1 [CHILD]

end
