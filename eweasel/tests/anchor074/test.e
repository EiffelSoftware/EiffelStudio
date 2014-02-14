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
		do
			create {TEST2 [like g.item]} g.make (3)
		end

	g: detachable TEST1 [detachable STRING]

end
