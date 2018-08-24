note
	description: "Task to execute Boogie."
	date: "$Date$"
	revision: "$Revision$"

class
	E2B_EXECUTE_BOOGIE_TASK

inherit

	ROTA_TASK_I

	E2B_SHARED_CONTEXT

create
	make

feature {NONE} -- Initialization

	make (a_verifier: attached like verifier)
			-- Initialize task.
		do
			verifier := a_verifier
			has_next_step := True
			last_reported_time := -1000
		end

feature -- Status report

	has_next_step: BOOLEAN
			-- <Precursor>

	is_interface_usable: BOOLEAN = True
			-- <Precursor>

feature {ROTA_S, ROTA_TASK_I} -- Basic operations

	step
			-- <Precursor>
		local
			l_time: INTEGER
		do
			if not is_started then
				start_timer
				is_started := True
				verifier.verify_asynchronous
			end
			has_next_step := verifier.is_running

			l_time := current_timer
			if has_next_step then
				if l_time > last_reported_time + 1000 then
					last_reported_time := l_time
				end
				set_status (messages.status_boogie_running (l_time))
			else
				set_status (messages.status_boogie_finished (l_time))
				stop_timer
			end
		end

	cancel
			-- <Precursor>
		do
			verifier.cancel
			has_next_step := False
		end

feature {NONE} -- Implementation

	is_started: BOOLEAN
			-- Is verifier already started?

	verifier: attached E2B_VERIFIER
			-- Boogie verifier.

	last_reported_time: INTEGER
			-- Last reported time.

end
