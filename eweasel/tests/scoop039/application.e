note
	description: "Test that an agent created in an expression is uncontrolled."
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

create
	make, default_create

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			sep: separate APPLICATION
		do
			create sep
			(agent sep.do_print).call (void)

			(agent (create {separate APPLICATION}).do_print).call (void)
		end

feature -- Basic operations

	do_print
			-- Print a number.
		do
			io.put_integer (42)
			io.put_new_line
		end

end
