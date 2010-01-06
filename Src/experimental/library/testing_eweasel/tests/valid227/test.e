
class TEST

create
	make

feature

	make is
		do
			create x
			print (x.y.generating_type); io.new_line
		end

	x: TEST1 [STRING]

end
