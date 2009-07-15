deferred class
	B1

inherit
	A

feature

	frozen foo
		do
			print ("B1%N")
			bar
		end

	bar
		deferred
		end

end
