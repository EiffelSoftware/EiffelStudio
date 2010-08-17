
class TEST
inherit
	TEST1
		redefine
			y
		end
create
	make
feature
	make
		do
			create a
			create b
			create c
			print (a.x.generating_type); io.new_line
			print (b.x.generating_type); io.new_line
			print (c.x.generating_type); io.new_line
			print (x.generating_type); io.new_line
		end

	y: SEQ_STRING
	
	a: TEST2 [DOUBLE]

	b: TEST2 [BOOLEAN]

	c: TEST1
end
