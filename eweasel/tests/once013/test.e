
class TEST

create
	make

feature
	make
		do
			create x
			print (x.a); io.new_line
			print (x.b); io.new_line
			print (x.c); io.new_line
		end

	x: TEST1
end

