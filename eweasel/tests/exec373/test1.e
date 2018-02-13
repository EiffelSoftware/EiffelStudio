class
	TEST1 [G]

feature

	test (arg: G)
		local
			array: ARRAY [G]
			simple: TEST2 [G]
			anchored: TEST2 [like x]
			argument_anchored: TEST2 [like arg]
		do
			create array.make_empty
			create simple
			create anchored
			create argument_anchored

			io.put_string (array.generating_type.name)
			io.new_line
			io.put_string (simple.generating_type.name)
			io.new_line
			io.put_string (anchored.generating_type.name)
			io.new_line
			io.put_string (argument_anchored.generating_type.name)
			io.new_line
		end

	x: G
		do
			check False then
			end
		end

end
