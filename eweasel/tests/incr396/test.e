
class TEST
inherit
	TEST1

create
	make

feature
	make
		do
			print (x.n); io.new_line
		end

end
