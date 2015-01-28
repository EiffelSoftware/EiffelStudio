note
	description: "Test that an agent created on a controlled object is also controlled."
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
			create_and_call (sep)
		end

feature -- Basic operations

	create_and_call (a_app: separate APPLICATION)
			-- Create a new agent and call it in the same expression.
		do
			(agent a_app.do_print).call (Void)
		end

	do_print
			-- Print a number.
		do
			io.put_integer (42)
			io.put_new_line
		end

end
