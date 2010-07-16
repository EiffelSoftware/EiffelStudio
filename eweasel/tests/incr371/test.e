
class TEST
create
	make

feature

	make
		do
			print (agent $NAME)
			print ("%N")
		end 
    
    
	$NAME (a: INTEGER_32)
		do
			io.put_string ($EXPRESSION)
		end

end
