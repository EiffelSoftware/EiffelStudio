expanded class EXP7
inherit
	ANY
		redefine
			copy
		end

feature

	copy (other: like Current) is
		do
			print ("Being called {EXP7}.copy.%N")
		end

end
