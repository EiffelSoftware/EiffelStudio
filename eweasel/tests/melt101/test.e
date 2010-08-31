
class TEST
inherit
	TEST1 [DOUBLE]

create
	make

feature
	make
		do
			print (value /= Void); io.new_line
			print (value /= Void); io.new_line
		end

end
