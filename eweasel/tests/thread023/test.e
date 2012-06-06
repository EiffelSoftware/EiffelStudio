class
	TEST
inherit
	THREAD
		redefine
			make
		end

create
	make

feature

	make
		do
			Precursor
				-- Set `thread_id' to satisfy the precondition of `exit'.
			thread_id := current_thread_id
			io.put_string ("I'm here%N")
			exit
			io.put_string ("I should not be printed%N")
		end

	execute
		do
		end

end
