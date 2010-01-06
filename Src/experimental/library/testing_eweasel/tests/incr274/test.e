
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
				end).call ([])
		end
end
