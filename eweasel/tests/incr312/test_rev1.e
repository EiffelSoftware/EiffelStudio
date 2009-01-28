
class TEST
inherit
	TEST1
		redefine
			value
		end

create
	make

feature

	make
		do
			print (value); io.new_line
		end

	value: POINTER

end
