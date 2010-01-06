

class TEST
create
	make
feature
	
	make is
		local
			x: like a
			y: like b
		do
			x := a
			print (a); io.new_line
			y := b
			print (b); io.new_line
		end

	
	a: REAL is 1.01E+2000000000
	b: DOUBLE is 1.01E+2000000000

end
