
class TEST
inherit
	ANY
		redefine
			default_create
		end
create
	make, default_create
feature
	
	make
		do
			create x
			create y
			try1 (x)
			try2 (y)
		end

	default_create
		do
			create x
			create y
		end

	try1 (a: separate TEST1)
		do
			a.try (y, create {separate TEST})
		end

	try2 (b: separate TEST2)
		do
			b.try (x, create {separate TEST})
		end

	try3 (a: separate TEST1 b: separate TEST2)
		do
		end

	x: separate TEST1

	y: separate TEST2

end

