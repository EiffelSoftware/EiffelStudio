class TEST

create
	make

feature
	
	make
		local
			y: TEST2
		do
			y := 
				if True then
					create {TEST2}
				else
					create {like {TEST2}.xxx}
				end
			y.do_nothing
		end
	
	x: TEST3

end
