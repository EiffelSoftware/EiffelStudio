note
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SVN_ENGINE_PROVIDER

inherit
	THREAD_CONTROL

	EXECUTION_ENVIRONMENT

create
	make

feature {NONE} -- Initialization

	make
			--
		do
			create results.make (3)
			create active_tasks.make (3)
			create mutex.make
		end

	mutex: MUTEX

feature -- Access

	last_request_id: INTEGER

	computed_info (a_data: TUPLE [p: STRING; is_verbose_mode: BOOLEAN; is_recursive_mode: BOOLEAN; is_remote_mode: BOOLEAN]): like info
		local
			l_id: like last_request_id
		do
			request_info (a_data)
			l_id := last_request_id
			wait_until_has_info (l_id, Void)
			if has_info (l_id) then
				Result := info (l_id, True)
			end
		end

	request_info (a_data: TUPLE [p: STRING; is_verbose_mode: BOOLEAN; is_recursive_mode: BOOLEAN; is_remote_mode: BOOLEAN])
			--
		local
			th: SVN_ENGINE_PROVIDER_THREAD
		do
			mutex.lock
			if active_tasks.count = 0 then
				last_request_id_counter := 0
			end
			last_request_id_counter := last_request_id_counter + 1
			last_request_id := last_request_id_counter

			create th.make (mutex, Current, a_data, last_request_id)
			active_tasks.force (th, last_request_id)
			mutex.unlock

			th.launch
		end

	has_info (id: INTEGER): BOOLEAN
			--
		do
			mutex.lock
			Result := results.has (id)
			mutex.unlock
		end

	info (id: INTEGER; a_remove: BOOLEAN): LIST [SVN_STATUS_INFO]
			--
		require
			has_info: has_info (id)
		do
			mutex.lock
			Result := results.item (id)
			if a_remove then
				results.remove (id)
			end
			mutex.unlock
			if Result /= Void then
				Result.compare_objects
--				Result.set_equality_tester (svn_equality_tester)
			end
		end

	wait_until_has_info (i: INTEGER; a_agent: PROCEDURE)
		do
			from
			until
				has_info (i) or else not task_running (i)
			loop
				sleep (1000)
				if a_agent /= Void then
					a_agent.call (Void)
				end
			end
		end

feature {NONE} -- Implementation

--	svn_equality_tester: KL_EQUALITY_TESTER	[SVN_STATUS_INFO]
--		once
--			create Result
--		end

	last_request_id_counter: INTEGER

	results: HASH_TABLE [like info, INTEGER]

	active_tasks: HASH_TABLE [SVN_ENGINE_PROVIDER_THREAD, INTEGER]

	task_running (a_id: INTEGER): BOOLEAN
			--
		do
			mutex.lock
			Result := active_tasks.has (a_id)
			mutex.unlock
		end



feature {SVN_ENGINE_PROVIDER_THREAD} -- Thread access, mutex should be acquired !!!

	post_result (a_id: like last_request_id; a_info: like info)

		do
			results.force (a_info, a_id)
			active_tasks.remove (a_id)
		end

end
