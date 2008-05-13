class TEST
create
	make

feature {NONE}

	make
		do
			create parent
			create child1
			create child2
			try
		end

	try
		do
			print (parent.length); io.new_line
			print (child1.length); io.new_line
			print (child2.length); io.new_line
		end

	parent: PARENT

	child1: CHILD1

	child2: CHILD2

end
