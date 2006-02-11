indexing
	description: "Object to get snapshot of running processes on system"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PROCESS_TOOLHELP

feature

	direct_subprocess_list (parent_id: INTEGER): LIST [INTEGER] is
			-- List of direct subprocess ids of process indicated by id `parent_id'.
		local
			l_pc: SYSTEM_DLL_PERFORMANCE_COUNTER
			l_prc_snapshot: like numbered_process_snapshot
			l_parent_id: INTEGER_64
		do
			io.put_string ("Parent id:"+parent_id.out+":")
			create {LINKED_LIST [INTEGER]}Result.make
			l_prc_snapshot := numbered_process_snapshot
			if l_prc_snapshot /= Void and then not l_prc_snapshot.is_empty then
				create l_pc.make_from_category_name_and_counter_name ("Process", "Creating Process Id")
				from
					l_prc_snapshot.start
				until
					l_prc_snapshot.after
				loop
					l_pc.set_instance_name (l_prc_snapshot.item_for_iteration)
					retrieve_raw_value (l_pc)
					if raw_value_retrieved_successful then
						l_parent_id := last_raw_value.to_integer
						if l_parent_id = parent_id then
							io.put_string (l_prc_snapshot.key_for_iteration.out+" "+l_prc_snapshot.item_for_iteration+"; ")
							Result.extend (l_prc_snapshot.key_for_iteration)
						end
					end
					l_prc_snapshot.forth
				end
				io.put_string ("%N")
			end
		end

	retrieve_raw_value (a_counter: SYSTEM_DLL_PERFORMANCE_COUNTER) is
			-- Raw value of `a_counter'
		require
			a_counter_not_void: a_counter /= Void
		local
			retried: BOOLEAN
		do
			if not retried then
				last_raw_value := a_counter.raw_value
				raw_value_retrieved_successful := True
			end
		rescue
			retried := True
			raw_value_retrieved_successful := False
			retry
		end

	raw_value_retrieved_successful: BOOLEAN
			-- Is last `performance_counter_raw_value' retrieved successfully?

	last_raw_value: INTEGER_64
			-- Last retrieved raw value of a performance counter.

	numbered_process_snapshot: HASH_TABLE [STRING, INTEGER] is
			-- List of names processes running on system.
			-- Names are numbered, e.g. if there are more than one process with the same name,
			-- The first occurrance is the original name, and the following occurrance is numbered by "#1", "#2"...
		local
			l_snapshot: NATIVE_ARRAY [SYSTEM_DLL_PROCESS]
			l_prc_tbl: HASH_TABLE [INTEGER, STRING]
			i: INTEGER
			c: INTEGER
			l_occur_cnt: INTEGER
			l_prc_name: STRING
			l_str: STRING
		do
			l_snapshot := {SYSTEM_DLL_PROCESS}.get_processes
			if l_snapshot /= Void and then l_snapshot.count > 0 then
				c := l_snapshot.count
				create Result.make (c)
				create l_prc_tbl.make (l_snapshot.count)
				from
					i := 0
				until
					i = c
				loop
					l_prc_name := l_snapshot.item (i).process_name
					l_str := l_prc_name.twin
					if l_prc_tbl.has (l_prc_name) then
						l_occur_cnt := l_prc_tbl.item (l_prc_name) + 1
						l_str.append ("#")
						l_str.append (l_occur_cnt.out)
					else
						l_occur_cnt := 0
					end
					l_prc_tbl.force (l_occur_cnt, l_prc_name)
					Result.force (l_str, l_snapshot.item (i).id)
					i := i + 1
				end
			else
				create Result.make (0)
			end

		end

end
