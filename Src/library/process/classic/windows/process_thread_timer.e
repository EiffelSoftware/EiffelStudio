indexing
	description: "Process status listening timer implemented with thread."
	date: "$Date$"
	revision: "$Revision$"

class
	PROCESS_THREAD_TIMER

inherit
	PROCESS_TIMER

	THREAD

	WEL_PROCESS_LAUNCHER
		rename
			launch as process_launch
		end

create
	make

feature {NONE} -- Implementation

	make (a_sleep_time: INTEGER) is
			-- Set time interval which this timer will be triggered with `a_sleep_time'.
			-- Unit of `a_sleep_time' is milliseconds.
		require
			thread_capable: {PLATFORM}.is_thread_capable
			interval_positive: a_sleep_time > 0
		do
			sleep_time := a_sleep_time
			create mutex.make
			has_started := False
		ensure
			slee_time_set: sleep_time = a_sleep_time
			destroyed_set: destroyed = True
		end

feature -- Control

	start is
		do
			mutex.lock
			should_destroy := False
			terminated := False
			launch
			has_started := True
			mutex.unlock
		end

	destroy is
		do
			mutex.lock
			should_destroy := True
			mutex.unlock
		end

	wait (a_timeout: INTEGER): BOOLEAN is
		local
			l_timeout: INTEGER
		do
			if a_timeout = 0 then
				l_timeout := cwin_wait_for_single_object (handle_from_thread_id (thread_id), cwin_infinite)
			else
				l_timeout := cwin_wait_for_single_object (handle_from_thread_id (thread_id), a_timeout)
			end
			Result := l_timeout = cwin_wait_object_0
		end

	destroyed: BOOLEAN is
		do
			mutex.lock
			Result := (not has_started) or (has_started and then terminated)
			mutex.unlock
		end

feature {NONE} -- Implementation

	execute is
		local
			prc_imp: PROCESS_IMP
			l_sleep_time: INTEGER_64
		do
			prc_imp ?= process_launcher
			from
				l_sleep_time := sleep_time.to_integer_64 * 1_000_000
			until
				should_destroy
			loop
				prc_imp.check_exit
				if not should_destroy then
					sleep (l_sleep_time)
				end
			end
		end

	handle_from_thread_id (a_thread_id: POINTER): POINTER is
			-- Thread handle from `a_thread_id'.
		require
			a_thread_id_not_void: a_thread_id /= default_pointer
		external
			"C inline"
		alias
			"[
			#ifdef EIF_THREADS
			return (EIF_POINTER) (*(EIF_THR_TYPE *) $a_thread_id);
			#else
			return NULL;
			#endif
			]"
		end

feature{NONE} -- Implementation

	should_destroy: BOOLEAN
			-- Should this timer be destroyed?

	mutex: MUTEX
			-- Internal mutex

invariant

	mutex_not_void: mutex /= Void

end
