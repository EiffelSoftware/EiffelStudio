indexing
	description: "Task which reports progress"
	date: "$date"
	revision: "$revision"

deferred class
	WIZARD_PROGRESS_REPORTING_TASK

inherit
	WIZARD_SHARED_DATA
		export
			{NONE} all
		end

	WIZARD_ERRORS
		export
			{NONE} all
		end

feature -- Access

	title: STRING is
			-- Task title, to be displayed to user
		deferred
		end

	steps_count: INTEGER is
			-- Number of steps involved in task
		deferred
		ensure
			valid_count: Result > 0
		end

feature -- Basic Operation

	execute is
			-- Execute task
		local
			l_retried: BOOLEAN
		do
			if not l_retried then
				internal_execute
			else
				environment.set_abort (Exception_raised)
			end
		rescue
			l_retried := True
			retry
		end

feature {NONE} -- Implementation

	internal_execute is
			-- Implementation of `execute'.
		deferred
		end

invariant
	valid_steps_count: steps_count > 0

end -- class WIZARD_PROGRESS_REPORTING_TASK
