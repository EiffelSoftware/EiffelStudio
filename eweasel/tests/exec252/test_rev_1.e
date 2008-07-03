indexing
	description: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST

create
	make

feature

	make 
		local
			t2: TEST2
		do
			create t2
			test_0
			t2.test_0
		end

	test_0
		do
			e (Current, $target_0)
		end

	target_0
		do
			print ("Hello from target 0%N")
		end

	e (c: like Current; p: POINTER)
		external
			"C inline"
		alias
			"((void (*)(EIF_REFERENCE)) $p) (eif_access($c));"
		end

end
