class B
inherit
	A
		rename
			make_a as make_b
		redefine
			make_b
		end
create
	make_b
feature
	make_b
		do
			print ("make_b%N")
		end
end
