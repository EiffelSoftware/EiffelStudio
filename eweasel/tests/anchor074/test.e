class
	TEST

create
	make

feature

	make
		do
		end

feature

	f
		local
			l: like h.item
		do
			create {TEST2 [like g.item]} g.make (3)
			create l.make (3)
		end

	g: detachable TEST1 [detachable STRING]

	h: detachable TEST1 [TEST2 [STRING]]

end
