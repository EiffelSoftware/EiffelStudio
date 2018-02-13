class TEST

create
	make

feature {NONE} -- Creation

	make
		local
			simple_type: TEST1 [STRING]
			anchored_type: TEST1 [like x]
			none_type: TEST1 [detachable NONE]
		do
			create simple_type
			create anchored_type
			create none_type

			simple_type.test ("s")
			anchored_type.test ("x")
			none_type.test (Void)

			io.put_string ((<< >>).generating_type.name)
			io.new_line
		end

feature {NONE} -- Access

	x: STRING
		do
			check False then
			end
		end

end
