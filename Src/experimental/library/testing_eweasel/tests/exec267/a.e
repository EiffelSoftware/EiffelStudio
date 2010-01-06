class A [G -> NUMERIC]

feature

	test (a_g: G) is
		do
			n ?= a_g
			print (n)
		end

	n: NUMERIC

end
