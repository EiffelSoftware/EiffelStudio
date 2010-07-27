
class TEST
create
	make
feature
	make
		do
			print (f1); io.new_line
			print (f2); io.new_line
			print (f3); io.new_line
			print (f4); io.new_line
			print (f5); io.new_line
			print (f6); io.new_line
			r1
		end

	f1: DOUBLE
		once ("OBJECT")
		end

	f2: INTEGER
		once ("OBJECT")
		end

	f3: BOOLEAN
		once ("OBJECT")
		end

	f4: NATURAL_64
		once ("OBJECT")
		end

	f5: POINTER
		once ("OBJECT")
		end

	f6: STRING
		once ("OBJECT")
		end

	r1
		once ("OBJECT")
		end
		
end
