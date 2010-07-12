
class TEST2 [G -> STRING create make end]
create
	make

feature {NONE}

	make
		do
			x := "Weasel"
			create y.make (0)
			y.append ("Ermine")
		end
feature

	try
		do
		end

	x: STRING

	y: G

invariant
	valid: attached {like {TEST2 [G]}.$(FEATURE)} $(FEATURE)

end

