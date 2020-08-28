class
	A [G]

create
	make

feature

	make (v: G)
		do
			g := v
			create l
		end

feature

	g: G

	l: attached B [G]

end
