
expanded class TEST2
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
			print ("Starting%N")
			if attached {TEST2} Current as x then
				print ("Conforms in TEST2%N")
			end
		end

end
