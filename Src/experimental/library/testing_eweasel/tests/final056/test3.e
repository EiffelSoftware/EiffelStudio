class
	TEST3

inherit
	TEST1 [STRING]

create
	make

feature

	cache: CACHE [STRING] is
		once
			create Result
		end

end
