class
	TEST

create
	make

feature {NONE} -- Initialization

	make
		local
			l_a: A
		do
			create l_a
			test (l_a)
			test (l_a.to_b)
		end

feature -- Test

	test (a_obj: ?B)
		require
			a_obj_attached: a_obj /= Void
		do
			print (a_obj.generating_type + "%N")
		end

end