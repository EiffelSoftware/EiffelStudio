
class 
	TEST
inherit
	MEMORY
create
	make
feature
	
	make is
		do
			(agent : STRING_32
				do 
					collect
					print ("m")
				end).call ([])
		end
end
