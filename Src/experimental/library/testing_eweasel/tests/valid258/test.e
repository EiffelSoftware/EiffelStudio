class
	TEST

inherit
	TEST1
		redefine
			a
		select
			a
		end

	TEST1
		rename
			a as b
		end

create
	make

feature

	make
		do
		end

	a: detachable STRING note option: stable attribute end

end
