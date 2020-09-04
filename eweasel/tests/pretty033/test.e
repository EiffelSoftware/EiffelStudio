class
	TEST

create
	make

feature

	make
		do
			print ("Hello")
			(agent print (" world")).call
		end

end
