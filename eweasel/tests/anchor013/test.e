
class TEST
create
	make
feature
	
	make
		do
			create b
			print (b.generating_type); io.new_line
		end

	b: like {TEST1 [TEST2]}.y

end
