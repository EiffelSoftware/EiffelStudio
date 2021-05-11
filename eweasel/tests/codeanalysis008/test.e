note
	description: "project2 application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST

inherit

	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization
		local
			l_int: INTEGER
			l_real: DOUBLE
		do
			l_int := + -2
			l_real := - +4.1 -- Double violation by design
			l_real := - -4.2
			l_int := +(4)
			l_int := -(-7)
			l_real := -(-7.0)
			l_int := -(0)
			
			l_int := +(-(-2 - 1)) -- No violation, complex expression in parentheses
			l_int := +l_int -- No violation, this rule only applies to literals
			
			l_int := +3
			l_int := -0
			
			l_real := +3.7
			l_real := +0.0
			l_real := -0.0 -- No violation, -0.0 is not the same number as +0.0.
			
			io.put_string ("Hello world!")
			
		end

end
