
class TEST
create
	make
feature
	make
		do
			create x
			print (x.value.generating_type); io.new_line
		end

	x: TEST2
end
