
class TEST
inherit
	TEST1
		redefine
			x
		end

create
	make

feature
	make
		do
			print (x.n); io.new_line

		end

	x: TEST1
		once ("OBJECT")
			create Result
		end
end
