indexing
	description: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST2

feature

	test_0
		do
			e (Current, $target_0)
		end

	target_0
		do
			print ("Hello 2 from target 0%N")
		end

	e (c: like Current; p: POINTER)
		external
			"C inline"
		alias
			"((void (*)(EIF_REFERENCE)) $p) (eif_access($c));"
		end

end
