class TEST

create
	make

feature
	
	make is
		local
			x: X
		do
			print (f (1))
			io.put_new_line
			print ({NATURAL_32} #? 1)
			io.put_new_line
			print (g (1) = x)
			io.put_new_line
			print (({X} #? 1) = x)
			io.put_new_line
		end

feature {NONE} -- Test

	f (a: ANY): NATURAL_32 is
		do
			Result ?= a
		end

	g (a: ANY): X is
		do
			Result ?= a
		end

end
