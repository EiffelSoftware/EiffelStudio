

class TEST

create
	make

feature

	make
		do
			create x
			print ((agent x.value0).item ([])); io.new_line
			print ((agent x.value1).item ([])); io.new_line
			print ((agent x.value2).item ([])); io.new_line
			print ((agent x.value3).item ([])); io.new_line
			print ((agent x.value4).item ([])); io.new_line
			print ((agent x.value5).item ([])); io.new_line
			print ((agent x.value6).item ([])); io.new_line
			print ((agent x.value7).item ([])); io.new_line
			print ((agent x.value8).item ([])); io.new_line
		end
	
	x: TEST2

end

