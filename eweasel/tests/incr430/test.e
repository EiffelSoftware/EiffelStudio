
class TEST
create
	make
feature
	
	make
		do
			print (if True then create {TEST2} else create {like {TEST2}.xxx} end); io.new_line
		end
	
	x: TEST3
	
end
