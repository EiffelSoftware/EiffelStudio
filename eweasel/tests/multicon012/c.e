expanded class C
inherit
	B
		rename
			make_b as make_c,
			f_b as f_c
		redefine
			make_c, f_c
		end
	B
		select
			f_b, make_b
		end
	A
create
	default_create, make_b
feature
	make_c
		do
			print (generating_type + ":make_c%N")
		end

	f_c
		do
			print (generating_type + ":f_c%N")
		end

end
