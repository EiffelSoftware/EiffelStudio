class TEST

creation

	make

feature

	make is
		local
			x: X
			y: Y
		do
			!!y
			x := y
			print (y.b) print (' ') print (x.b) print ('%N')
			y.set_1
			print (y.b) print (' ') print (x.b) print ('%N')
			x.set_2
			print (y.b) print (' ') print (x.b) print ('%N')
			y.set_1
			print (y.b) print (' ') print (x.b) print ('%N')
		end

end
