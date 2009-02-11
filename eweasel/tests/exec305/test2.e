
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
			if {x: TEST2} Current then
				print ("Conforms in TEST2%N")
			end
		end

end
