
class TEST
create
        make
feature
        make
                do
			create b
			create {TEST3} c
			print (c.weasel); io.new_line
                end

	b: TEST3
	
	c: TEST2
	
end

