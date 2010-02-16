

class TEST
create
	make
feature
	
	make
		local
			x: like a
			y: like b
		do
			x := a
			print (a); io.new_line
			y := b
			print (b); io.new_line
		end

	
	a: REAL = 1.01E+2000000000
	b: DOUBLE = 1.01E+2000000000

end
