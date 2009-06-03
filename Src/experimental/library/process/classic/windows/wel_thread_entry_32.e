note
	description: "Object that describes an entry from a list that enumerates the threads executing in the system when a snapshot was taken"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_THREAD_ENTRY_32

create
	make

feature{NONE} -- Initialization
	make (owner_id: INTEGER; t_id: INTEGER; base_pri: INTEGER)
			--
		do
			owner_process_id := owner_id
			thread_id := t_id
			base_priority := base_pri
		ensure
			owner_process_id_set: owner_process_id = owner_id
			thread_id_set: thread_id = t_id
			base_priority_set: base_priority = base_pri
		end

feature -- Access

	owner_process_id: INTEGER
			-- Identifier of the process that created the thread

	thread_id: INTEGER
			-- Thread identifier

	base_priority: INTEGER
			-- Initial priority level assigned to a thread
			-- Possible values can be `cwin_thread_priority_idle', `cwin_thread_priority_lowest',
			-- `cwin_thread_priority_below_normal', `cwin_thread_priority_normal', `cwin_thread_priority_above_normal',
			-- `cwin_thread_priority_highest' and `cwin_thread_priority_time_critical'.

feature -- Thread priority level

	cwin_thread_priority_idle: INTEGER
			--
		external
			"C inline use <Tlhelp32.h>"
		alias
			"THREAD_PRIORITY_IDLE"
		end

	cwin_thread_priority_lowest: INTEGER
			--
		external
			"C inline use <Tlhelp32.h>"
		alias
			"THREAD_PRIORITY_LOWEST"
		end

	cwin_thread_priority_below_normal: INTEGER
			--
		external
			"C inline use <Tlhelp32.h>"
		alias
			"THREAD_PRIORITY_BELOW_NORMAL"
		end

	cwin_thread_priority_normal: INTEGER
			--
		external
			"C inline use <Tlhelp32.h>"
		alias
			"THREAD_PRIORITY_NORMAL"
		end

	cwin_thread_priority_above_normal: INTEGER
			--
		external
			"C inline use <Tlhelp32.h>"
		alias
			"THREAD_PRIORITY_ABOVE_NORMAL"
		end

	cwin_thread_priority_highest: INTEGER
			--
		external
			"C inline use <Tlhelp32.h>"
		alias
			"THREAD_PRIORITY_HIGHEST"
		end

	cwin_thread_priority_time_critical: INTEGER
			--
		external
			"C inline use <Tlhelp32.h>"
		alias
			"THREAD_PRIORITY_TIME_CRITICAL"
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 5949 Hollister Ave., Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end
