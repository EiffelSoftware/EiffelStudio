class TEST1 [G]

create
	make

feature

	make is
		local
			g: like anchor
		do
			f (g)
		end

	f (a: separate ANY) is
		do
		end

	anchor: G

end
