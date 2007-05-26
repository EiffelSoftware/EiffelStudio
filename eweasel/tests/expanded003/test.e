indexing
	description	: "System's root class"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST

create
	make

feature -- Initialization

	make is
			-- Creation procedure.
		local
			rounds_to_go: INTEGER
			env: EXECUTION_ENVIRONMENT
		do
			create env
			if
				env.command_line.argument_count = 1 and then
				env.command_line.argument (1).is_integer
			then
				create test_array.make( 0, 1000 )
				from
					rounds_to_go := env.command_line.argument (1).to_integer
				until
					rounds_to_go > 0
				loop
					play
					rounds_to_go := rounds_to_go - 1
				end
				print ("passed%N")
			else
				print ("failed: wrong argument. I need an integer as first argument.%N")
			end
		end

	test_array: ARRAY[ B ]

feature
	f: A
	play is
			--
		local
			f1,f2: A
		do
			f := f1
			f := f2
		end

end -- class ROOT_CLASS
