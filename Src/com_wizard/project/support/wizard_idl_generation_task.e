indexing
	description: "Task used for generating IDL file from Eiffel class"
	date: "$date"
	revision: "$revision"

class
	WIZARD_IDL_GENERATION_TASK

inherit
	WIZARD_PROGRESS_REPORTING_TASK

feature -- Access

	title: STRING is "Processing Eiffel facade class"
			-- Task title

	steps_count: INTEGER is
			-- Number of steps involved in task
		do
			Result := 1
		end

	internal_execute is
			-- Implementation of `execute'.
			-- Use `step' `steps_count' times unless `stop' is called.
		do
			(create {WIZARD_IDL_GENERATOR}).generate
			progress_report.step
		end

end -- class WIZARD_IDL_GENERATION_TASK
