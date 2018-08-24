note
	description: "Result of verifying an individual procedure in a Boogie program."
	date: "$Date$"
	revision: "$Revision$"

class
	E2B_BOOGIE_PROCEDURE_RESULT

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_context: E2B_BOOGIE_RESULT)
			-- Initialize procedure result
		do
			name := a_name.twin
			context := a_context
			create errors.make
		end

feature -- Access

	name: STRING
			-- Name of verified procedure.

	time: REAL
			-- Time of verification in seconds.

	errors: LINKED_LIST [E2B_BOOGIE_PROCEDURE_ERROR]
			-- List of verification errors.

	context: E2B_BOOGIE_RESULT
			-- Context of this result.

feature -- Status report

	is_successful: BOOLEAN
			-- Is this procedure verified successfuly?

	is_error: BOOLEAN
			-- Is verification of this procedure failed?

	is_inconclusive: BOOLEAN
			-- Is verification of this procedure inconclusive?

feature -- Status setting

	set_successful
			-- Set `is_successful' to true.
		do
			is_successful := True
		end

	set_error
			-- Set `is_error' to true.
		do
			is_error := True
		end

	set_inconclusive
			-- Set `is_inconclusive' to true.
		do
			is_inconclusive := True
		end

feature -- Element change

	set_time (a_value: REAL)
			-- Set `time' to `a_value'.
		do
			time := a_value
		end

invariant
	no_errors_when_successful: is_successful implies errors.is_empty
	no_errors_when_inconclusive: is_inconclusive implies errors.is_empty

end
