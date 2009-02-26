
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
		local
			t: TUPLE [like anchor]
		do
			t := [precursor]
		end

	anchor: STRING

end

