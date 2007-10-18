class
	TEST

create
	make

feature -- Initialization

	make is
			-- Creation procedure.
		local
			worker_thread: WORKER_THREAD
		do
			retrieve
			create worker_thread.make (agent do_nothing)
			worker_thread.launch
			worker_thread.join
		end

feature {NONE} -- Implementation

	retrieve is
		local
			a: like Current
			l_file: RAW_FILE
			retried: BOOLEAN
		do
			if not retried then
				create l_file.make_open_read ("$CORRUPTED_FILE")
				a ?= l_file.retrieved
				l_file.close
			end
		rescue
			retried := True
			retry
		end

end
