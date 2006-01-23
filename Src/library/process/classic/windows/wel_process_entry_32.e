indexing
	description: "Object that contains information about a process from system snapshot"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_PROCESS_ENTRY_32

create
	make

feature{NONE} -- Initialization

	make (pid, ppid: INTEGER; thr_count: INTEGER; pri_base: INTEGER_64; exe: STRING) is
			-- Use process id `pid', parent process id `ppid', thread count `thr_count',
			-- priority class base in `pribase' and executable file name `exe'
			-- to initialize this object.
		do
			process_id := pid
			parent_process_id := ppid
			thread_count := thr_count
			priority_class_base := pri_base
			executable := exe
		end

feature	-- Access

	process_id: INTEGER
	 		-- Process identifier

	parent_process_id: INTEGER
			-- Process identifier of the process that created this process (its parent process)

	thread_count: INTEGER
			-- Number of execution threads started by the process

	priority_class_base: INTEGER_64
			-- Base priority of any threads created by this process

	executable: STRING
			-- Name of the executable file for the process

invariant
	process_id_non_negative: process_id >= 0
	parent_process_id_non_negative: parent_process_id >= 0
	thread_count_positive: thread_count > 0

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end
