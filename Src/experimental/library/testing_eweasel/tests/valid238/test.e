class
	TEST

inherit
	A
		rename
			a as make,
			b as make
		select
			make
		end

	A
		rename
			b as make
		end

create
	make

feature {NONE} -- Test

	a
		do
		end

end