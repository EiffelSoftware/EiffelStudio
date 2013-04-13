class
	TEST

inherit
	SERIALIZATION_HELPER

create
	make

feature -- Initialization

	make
			-- Creation procedure.
		local
			l_objects: HASH_TABLE [ANY, STRING]
			worker_thread: WORKER_THREAD
		do
			set_is_safe_retrieval (True)
			l_objects := retrieved_objects_ex ("$CORRUPTED_FILE", False)
			if l_objects.count /= 0 then
				io.put_string ("Something very wrong here%N")
			end
			create worker_thread.make (agent do_nothing)
			worker_thread.launch
			worker_thread.join
		end

end
