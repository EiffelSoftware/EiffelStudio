
class TEST
create
	make
feature
	make
		do
			create {TEST2} x
			print (x.value); io.new_line
			create {TEST3} x
			print (x.value); io.new_line
			create {TEST4} x
			print (x.value); io.new_line
			create {TEST5} x
			print (x.value); io.new_line
		end

	x: PARENT

end
