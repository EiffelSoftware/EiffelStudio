
class TEST

create
	default_create, make, make_from_test2

feature

	make_from_test2 (t: TEST2 [STRING])
		do
		end

	make
		local
			t: TEST2 [DOUBLE]
			v: TEST
		do
			create t
			create v
			t := v
			v := t
		end

end

