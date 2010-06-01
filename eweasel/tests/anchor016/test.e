
class TEST
create
	make
feature
	
	make
		do
			create a.make (0)
			print (a.generating_type); io.new_line
		end

	a: like b.x

	b: TEST1

end
