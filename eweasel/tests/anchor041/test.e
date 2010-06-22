
class TEST

create
	make
feature
	
	make
		do
			create a
			print (a.generating_type); io.new_line
		end

	a: like {TEST1 [TEST2]}.x.default

end
