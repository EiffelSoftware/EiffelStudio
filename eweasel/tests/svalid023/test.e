class
	TEST

inherit
	TEST1
		redefine
			a
		end

create
	make

feature

	make
		do
		end

	a: detachable B

end
