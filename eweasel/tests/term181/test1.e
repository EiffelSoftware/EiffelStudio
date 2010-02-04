
class TEST1 [G]
inherit
	ANY
		redefine
			default_create
		end
	
create
	default_create

feature
	default_create
		do
			print ("Weasel%N")
		end

end
