
class TEST2
inherit
	ANY
		redefine
			default_craete
		end
feature
	default_create
		do
			print ("Weasel%N")
		end
end

