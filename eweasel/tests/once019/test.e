
class TEST
inherit
	TEST1
		redefine
			value
		end
	TEST2
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

	value: STRING 
		once ("OBJECT")
			Result := precursor {TEST1}
		end
end
