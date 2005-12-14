indexing
	description: "[
					Objects that encapsulates a boolean variable and controls access to it
					through thread-safe methods. Multiple threads can safely interact
					with it.
				  ]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BOOLEAN_LOCK

create
	make

feature{NONE} -- Initialization

	make (b: BOOLEAN) is
			-- Set this boolean lock with state `b'.
		do
			value := b
		end

feature -- Status reporting

	is_true: BOOLEAN is
			-- Is `value' True?
		do
			mutex.lock
			Result := (value = True)
			mutex.unlock
		end

	is_false: BOOLEAN is
			-- Is `value' False?
		do
			mutex.lock
			Result := (not value)
			mutex.unlock
		end

feature -- Settings

	set_value (b: BOOLEAN) is
			-- Set `value' with `b'.
		do
			mutex.lock
			value := b
			condition_variable.broadcast
			mutex.unlock
		end

	wait_to_set_value (b: BOOLEAN; timeout: INTEGER): BOOLEAN is
			-- Try to set `value' with `b'.
			-- Wait at most `timeout' (infinitely if `timeout' is 0) nanosecond if `value' is locked.
			-- Return True if `value' is set with `b' successfully in time.
		require
			timeout_not_negative: timeout >= 0
		local
			l_time: TIME
			l_starttime: TIME
			done: BOOLEAN
			l_timeleft: INTEGER
			td: TIME_DURATION
			is_timeout: BOOLEAN
			oppo_state: BOOLEAN
		do
			create l_starttime.make_now
			mutex.lock
			if value /= b then
				create l_time.make_now
				td := l_time.relative_duration (l_starttime)
				l_timeleft := timeout - (td.fine_seconds_count * 1000).truncated_to_integer
				if l_timeleft >=0 then
					value := b
					condition_variable.broadcast
					Result := True
				else
					Result := False
				end
			else
				condition_variable.broadcast
			end
			mutex.unlock
		end

	wait_to_do (b: BOOLEAN; timeout: INTEGER; handler: PROCEDURE [ANY, TUPLE]): BOOLEAN is
			-- Wait at most `timeout' millisecond (infinitely if `timeout' is 0) until `value' equals `b' and then
			-- call `handler'.
			-- Return True if `handler' is called successfully in time.
		require
			timeout_not_negative: timeout >= 0
			handler_not_void: handler /= Void
		local
			l_time: TIME
			l_starttime: TIME
			done: BOOLEAN
			l_timeleft: INTEGER
			td: TIME_DURATION
			is_timeout: BOOLEAN
		do
			mutex.lock
			if value = b then
				handler.call ([])
				Result := True
			else
				create l_starttime.make_now
				if timeout = 0 then
					from
					until
						value = b
					loop
						condition_variable.wait (mutex)
					end
				else
					from
						create l_time.make_now
						td := l_time.relative_duration (l_starttime)
						l_timeleft := timeout - (td.fine_seconds_count * 1000).truncated_to_integer
						done := l_timeleft <= 0
					until
						done
					loop
						is_timeout := not condition_variable.wait_with_timeout (mutex, l_timeleft)
						if is_timeout then
							done := True
						else
							if value = b then
								done := True
							else
								create l_time.make_now
								td := l_time.relative_duration (l_starttime)
								l_timeleft := timeout - (td.fine_seconds_count * 1000).truncated_to_integer
								done := l_timeleft <=0
							end
						end
					end
				end
				Result := (value = b)
				if Result then
					handler.call ([])
				end
			end
			mutex.unlock
		end

	wait_until (b: BOOLEAN; timeout: INTEGER): BOOLEAN is
			-- Wait at most `timeout' millisecond (infinitely if `timeout' is 0)
			-- until `value' being set with `b'.
			-- Return True if value is set with `b' in `timeout', otherwise False.
		require
			timeout_not_negative: timeout >= 0
		local
			l_time: TIME
			l_starttime: TIME
			done: BOOLEAN
			l_timeleft: INTEGER
			td: TIME_DURATION
			is_timeout: BOOLEAN
		do
			create l_starttime.make_now
			mutex.lock
			if value = b then
				Result := True
			else
				if timeout = 0 then
					from
					until
						value = b
					loop
						condition_variable.wait (mutex)
					end
				else
					from
						create l_time.make_now
						td := l_time.relative_duration (l_starttime)
						l_timeleft := timeout - (td.fine_seconds_count * 1000).truncated_to_integer
						done := l_timeleft <= 0
					until
						done
					loop
						is_timeout := not condition_variable.wait_with_timeout (mutex, l_timeleft)
						if is_timeout then
							done := True
						else
							if value = b then
								done := True
							else
								create l_time.make_now
								td := l_time.relative_duration (l_starttime)
								l_timeleft := timeout - (td.fine_seconds_count * 1000).truncated_to_integer
								done := l_timeleft <=0
							end
						end
					end
				end
				Result := (value = b)
			end
			mutex.unlock
		end

feature{NONE} -- Implementation

	value: BOOLEAN
			-- Internal boolean value

	mutex: MUTEX is
			-- Mutex used as a class-level lock
		indexing
			once_status: global
		once
			create Result.default_create
		end

	condition_variable: CONDITION_VARIABLE is
			-- Internal condition variable
		indexing
			once_status: global
		once
			create Result.make
		end

invariant
	mutex_not_void: mutex /= Void
	condition_variable_not_void: condition_variable /= Void
end
