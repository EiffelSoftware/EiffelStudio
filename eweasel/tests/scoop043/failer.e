note
	description: "Utility class to throw exceptions and synchronize upon."
	author: "Florian Besser"
	date: "$Date$"
	revision: "$Revision$"

class
	FAILER

feature -- Access

	counter: INTEGER


	my_exception: DEVELOPER_EXCEPTION
		once
			create Result
		end

feature -- Basic operations

	fail
		do
			counter := counter + 1
			my_exception.raise
		end

end
