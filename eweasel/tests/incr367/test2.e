
class TEST2
inherit
	ANY
		redefine
			default_create
		end
feature
	default_create
		do
			print ("Weasel%N")
		end
end
