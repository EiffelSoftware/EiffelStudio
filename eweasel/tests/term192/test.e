
class TEST
inherit
	TEST1 [DOUBLE]
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

	value: DOUBLE
		do
		end

end

