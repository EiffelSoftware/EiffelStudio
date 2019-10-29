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
		end

end
