
class TEST1 [G]

feature

	test_standard_twin (v: G)
		do
			value := v.standard_twin
		end

	test_twin (v: G)
		do
			value := v.twin
		end

	value: G

end
