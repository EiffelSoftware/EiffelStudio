expanded class EXP7
inherit
	ANY
		redefine
			copy
		end

feature

	copy (other: like Current)
		do
			print ("Being called {EXP7}.copy.%N")
		end

end
