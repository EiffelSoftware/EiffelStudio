note
	description: "Summary description for {PROCESS_OUTPUT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PROCESS_OUTPUT

inherit
	ANY

	EXCEPTIONS
		export
			{NONE} all
		end

	DISPOSABLE
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_process: like process)
		require
			a_process_attached: a_process /= Void
			a_process_not_launched: not a_process.launched
		do
			create buffer.make (100)
			create mutex.make
			create condition_variable.make
			create {STRING} last_received.make_empty
			process := a_process
			
			a_process.redirect_output_to_agent (agent on_output)
			a_process.redirect_error_to_same_as_output
			a_process.set_on_exit_handler (agent on_exit)
			a_process.set_on_terminate_handler (agent on_exit)
		end

feature -- Access

	process: PROCESS
			-- Actual process instance

	last_received: READABLE_STRING_8
			-- Output last received from `process'

feature {NONE} -- Access

	buffer: STRING
			-- Buffer containing partial output received from `process' not processed by `receive' yet

	mutex: MUTEX
			-- Mutex for synchronizing access to `buffer'

	condition_variable: CONDITION_VARIABLE
			-- Condition variable synchronizing access to `buffer'

	timeout: INTEGER
			-- Number of milliseconds we wait for `process' to respond
		do
			Result := default_timeout
		end

feature -- Status report

	has_timed_out: BOOLEAN
			-- Has process not responded withing `timeout'?

	has_exited: BOOLEAN
			-- Has `process' exited yet?
		do
			Result := is_exit_handler_called or
				(process.launched and then process.has_exited)
		end

feature {NONE} -- Status report

	is_exit_handler_called: BOOLEAN
			-- Has `on_exit' been called yet?

feature {NONE} -- Status setting

	dispose
			-- <Precursor>
		do
			mutex.destroy
			condition_variable.destroy
		end

feature -- Basic operations

	receive (a_count: INTEGER; a_from_errors: BOOLEAN)
			-- Try to recevie a number of characters from `process' output and store it in `last_received'.
			--
			-- `a_count': Number of character expected.
			-- `a_from_errors': If True, characters will be received from error output of `process'.
		require
			process_launched: process.launched
			a_count_not_negative: a_count >= 0
		local
			l_done: BOOLEAN
			l_buffer: like buffer
			l_received: STRING
			l_count: INTEGER
		do
			mutex.lock
			l_buffer := buffer
			from
				has_timed_out := False
			until
				l_buffer.count >= a_count or l_done
			loop
				has_timed_out := not condition_variable.wait_with_timeout (mutex, timeout)
				l_done := has_timed_out or has_exited
			end
			l_count := a_count.min (l_buffer.count)
			create l_received.make (l_count)
			if l_count > 0 then
				l_received.fill_blank
				l_received.subcopy (l_buffer, 1, l_count, 1)
				l_buffer.remove_head (l_count)
			end
			last_received := l_received
			mutex.unlock
		ensure
			last_received_reset: last_received /= old last_received
			last_received_valid: last_received.count <= a_count
			last_received_complete_or_failed: last_received.count < a_count implies
				(has_exited or has_timed_out)
		end

feature {NONE} -- Events

	on_output (a_output: STRING)
			-- Called when output is received from `process'.
			--
			-- `a_output': Output last retireved from `process'.
		do
			mutex.lock
			buffer.append (a_output)
			condition_variable.broadcast
			mutex.unlock
		end

	on_exit
			-- Called when `process' terminates or exits.
		do
			mutex.lock
			is_exit_handler_called := True
			condition_variable.broadcast
			mutex.unlock
		end

feature {NONE} -- Constants

	default_timeout: INTEGER = 2000
			-- Time in milliseconds we wait for process to send new output

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
