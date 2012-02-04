class
	TEST
inherit
	THREAD_CONTROL

create
	make

feature

	io_mutex: MUTEX

	make
		local
			n, thread_count, nb_loop: INTEGER
			r: WORKER_THREAD
			pid: INTEGER
		do
			pid := eif_thread_fork
			if pid = 0 then
				pid := eif_thread_fork
				if pid = 0 then
					create r.make (agent execute)
					r.launch
					r.join
				else
					waitpid (pid)
					io.put_string ("Second child exited")	
					io.put_new_line
				end
			else
				waitpid (pid);
				io.put_string ("First child exited")
				io.put_new_line
			end
		end

	execute
		do
			io.put_string ("Thread executing")
			io.put_new_line
		end

	eif_thread_fork: INTEGER is
			-- Create a process.
		external
			"C inline"
		alias
			"[
				return eif_thread_fork();
			]"
		end

	waitpid (a_pid: INTEGER)
		external
			"C inline use <sys/types.h>,<sys/wait.h>"
		alias
			"[
				int status;
				do {
					waitpid($a_pid, &status, 0);
				} while (!WIFEXITED(status) && !WIFSIGNALED(status))
			]"
		end

end
