
class TEST [G -> STRING create make end]
create
	make
feature
	make
		do
			create s.make (5)
			s.append ("Weasel")
		end

	s: G

end

