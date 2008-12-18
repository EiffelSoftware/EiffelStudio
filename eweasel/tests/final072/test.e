
class TEST

create
	make

feature

	make is
		do
			print (x.generating_type); io.new_line
		end

	x: TEST1
		attribute
			create Result
		end
end
