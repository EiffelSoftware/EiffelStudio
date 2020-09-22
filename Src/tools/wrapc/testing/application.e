note
	description: "wrapc_testing application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION


create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			i: INTEGER
			l: INTEGER_64
			f: REAL
			d: REAL_64
			c: CHARACTER_8
		do
			{WRAPC_TESTING_FUNCTIONS_API}.get_int_value ($i)
			print ("INTEGER:" + i.out)
			io.put_new_line
			{WRAPC_TESTING_FUNCTIONS_API}.get_long_value ($l)
			print ("INTEGER_64:" + l.out)
			io.put_new_line
			{WRAPC_TESTING_FUNCTIONS_API}.get_float_value ($f)
			print ("REAL:" + f.out)
			io.put_new_line
			{WRAPC_TESTING_FUNCTIONS_API}.get_double_value ($d)
			print ("REAL_64:" + d.out)
			io.put_new_line
			{WRAPC_TESTING_FUNCTIONS_API}.get_char_value ($c)
			print ("Character:" + c.out)
			io.put_new_line
			{WRAPC_TESTING_FUNCTIONS_API}.get_unsinged_char_value ($c)
			print ("Unsinged Character:" + c.out)
			io.put_new_line
		end


end
