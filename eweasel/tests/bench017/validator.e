note
	description: "A validator processor that checks the correctness of a computed result."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	VALIDATOR

feature -- Basic operations

	validate (a_task: separate TASK)
			-- Validate the correctness of `a_task'.
			-- Since the argument should be passive, the actual work is done by this processor.
		do
			a_task.validate
		end

end

