class
	A [G]

create
	make

feature

	make (v: G) is
		do
			g := v
			create l
		end

feature

	g: G

	l: !B [G]

end
