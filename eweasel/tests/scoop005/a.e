class A

inherit
	EXECUTION_ENVIRONMENT

feature

	f (i: INTEGER; a: separate like Current)
		do
				-- When `a' resides on the root processor, we have
				-- a separate callback and thus synchronization.
			a.nested_call (i)
			print (i.out)
			print ("%N")
		end

	nested_call (i: INTEGER)
		do
			sleep (5_000_000_000)
			print ((i + 1).out)
			print ("%N")
		end

end
