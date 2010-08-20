
class TEST
create
	make
feature
	make
		do
			try
		end 
    
	try
		do
			print (value.a); io.new_line
			print (value.b); io.new_line
			print (value.c); io.new_line
			print (value.d); io.new_line
			print (value.e); io.new_line
		end
	
	value: TEST2
		once ("OBJECT")
		end
	
end
