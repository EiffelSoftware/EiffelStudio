
class TEST
inherit	
	TEST1
		redefine
			value, anchor
		end

create
	make

feature

	make
		do
			print (value)
		end

	value: like anchor
		do
			print (attached precursor as y); io.new_line
		end

	anchor: STRING

end
