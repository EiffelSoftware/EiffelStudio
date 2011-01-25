class TEST1 [G -> STRING]

feature

	f
		do
			if attached primary as l_primary and then not l_primary.is_empty then
				print (l_primary)
				print ("%N")
			else
				print ("Nothing%N")
			end
		end

	primary: detachable G

end
