
class TEST

create
        make

feature

        make
                do
			create c.make_from_parent (p)
			create p
			try (p)
                end

	try (a: CHILD)
		do
			print (a.turkey); io.new_line
		end
		     
	p: PARENT
	
	c: CHILD
	
end
