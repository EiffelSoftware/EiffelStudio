
expanded class TEST2
inherit
	ANY
		redefine
			default_create
		end
feature
	default_create
		do
			
			print ("In TEST2 default_create%N")
		end

end
