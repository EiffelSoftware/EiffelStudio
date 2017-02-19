class B
inherit
	A
		rename
			make_a as make_b,
			f_a as f_b
		redefine
			make_b, f_b
		end
create
	make_b
feature
	make_b
		do
			print (generating_type.name + ":make_b%N")
		end
	f_b
		do
			print (generating_type.name + ":f_b%N")
		end

end
