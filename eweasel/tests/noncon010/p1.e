class
	P1

inherit
	P2
		rename
			from_p2 as conforming_from_p2
		redefine
			conforming_from_p2
		end

inherit {NONE}
	P2
		rename
			from_p2 as non_conforming_from_p2
		redefine
			non_conforming_from_p2
		end

feature

	conforming_from_p2 is
		do
			print ("Conforming path%N")
		end

	non_conforming_from_p2 is
		do
			print ("Non-nonforming path%N")
		end

end
