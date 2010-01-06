
class TEST

create
	make

feature

	make
		do
			create x
			n := x
			print (n); io.new_line
		end

	x: TEST2

	n: INTEGER

end
