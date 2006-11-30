class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run tests.
		local
			a_i: A [INTEGER_8]
			a_s: A [STRING]
		do
			create a_i
			print ((agent a_i.g).generating_type)
			print ("%N")
			(agent a_i.g).call ([{INTEGER_8} 5])
			print ("%N")
			create a_s
			print ((agent a_s.g).generating_type)
			print ("%N")
			(agent a_s.g).call (["string"])
			print ("%N")
		end

end
