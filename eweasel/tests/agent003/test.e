class TEST

create
	make

feature {NONE}

	make is
		do
			(agent set_value (True)).call ([])
		end
	 
	set_value (a_boolean: ANY)
		do
			print (a_boolean)
		end

end
