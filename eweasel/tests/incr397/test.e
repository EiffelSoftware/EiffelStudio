
class TEST
create
	make
feature
	make
		do
			print (x.a); io.new_line
		end

	x: TEST2
		once ("OBJECT")
			create Result
		end

end
