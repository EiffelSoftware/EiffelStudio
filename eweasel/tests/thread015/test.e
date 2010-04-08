class TEST

inherit
	THREAD

create
	make

feature

	make (args: ARRAY [STRING]) is
		local
			thread: WORKER_THREAD
		do
			create thread.make (agent execute)
			thread.launch
			if join_with_timeout (10) then
				io.put_string ("No way!%N")
			end
		end

	execute
		do
			from
			until
				False
			loop
				(create {EXECUTION_ENVIRONMENT}).sleep (5_000_000_000)
			end
		end

end

