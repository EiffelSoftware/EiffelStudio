
class TEST
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
			print ("In default_create%N")
		end

end
