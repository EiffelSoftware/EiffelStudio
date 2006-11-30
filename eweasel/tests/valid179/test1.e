class
	TEST1 [G -> PROCEDURE[ANY,TUPLE]]

create
	make

feature

	bar: G

	make (a: G) is
		do
			bar := a
		end

	call_it is
		do
			bar.call([])
		end

end
