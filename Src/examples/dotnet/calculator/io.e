indexing
	description: "Manages I/O."
	external_name: "ISE.Examples.Calculator.IO"

class
	IO

feature -- Access

	out: CONSOLE is
		indexing
			description: "Console object"
			external_name: "Out"
		do
			create Result
		ensure
			console_object_created: Result /= Void
		end

end -- class IO
