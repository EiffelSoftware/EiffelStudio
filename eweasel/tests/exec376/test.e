class TEST

create
	make

feature {NONE} -- Creation

	make
		do
			across <<{A}.b>> is x loop print (x) end
			across <<{A}.c>> is x loop print (x) end
			across <<{A}.d>> is x loop print (x) end
			across <<{A}.e>> is x loop print (x) end
			across <<{A}.f>> is x loop print (x) end
			across <<{A}.g>> is x loop print (x) end
			across <<{A}.h>> is x loop print (x) end
			io.put_new_line

			across <<{B}.b>> is x loop print (x) end
			across <<{B}.c>> is x loop print (x) end
			across <<{B}.d>> is x loop print (x) end
			across <<{B}.e>> is x loop print (x) end
			across <<{B}.f>> is x loop print (x) end
			across <<{B}.g>> is x loop print (x) end
			across <<{B}.h>> is x loop print (x) end
			io.put_new_line
		end

end
