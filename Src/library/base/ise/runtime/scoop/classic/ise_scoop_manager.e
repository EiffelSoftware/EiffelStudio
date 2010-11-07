note
	description: "Summary description for {ISE_SCOOP_MANAGER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

frozen class
	ISE_SCOOP_MANAGER

create {NONE}
	init_scoop_manager

feature -- C callback function

	scoop_manager_task_callback (scoop_task: NATURAL_8; client_processor_id, supplier_processor_id: like processor_id_type; body_index: NATURAL_32; a_callback_data, a_reserved: POINTER)
		local
			l_id: INTEGER_32
		do
			inspect
				scoop_task
			when scoop_task_assign_processor then
				l_id := assign_free_processor_id
				set_return_value (a_callback_data, $l_id)
			when scoop_task_free_processor then
				free_processor_id (client_processor_id)
			when scoop_task_start_processor_loop then
					-- Reinstantate during optimization phase.
				start_processor_application_loop (client_processor_id)
			when scoop_task_signify_start_of_new_chain then
				signify_start_of_request_chain (client_processor_id)
			when scoop_task_signify_end_of_new_chain then
				signify_end_of_request_chain (client_processor_id)
			when scoop_task_add_supplier_to_request_chain then
				assign_supplier_processor_to_request_chain (client_processor_id, supplier_processor_id)
			when scoop_task_wait_for_supplier_processor_locks then
				wait_for_request_chain_supplier_processor_locks (client_processor_id)
			when scoop_task_add_call then
				log_call_on_processor (client_processor_id, supplier_processor_id, body_index, a_callback_data)
			when scoop_task_wait_for_processor_redundancy then
				wait_for_processor_redundancy
				do_nothing -- Noop for system completion breakpoint.
			else
				check invalid_task: False end
			end
		end

	frozen scoop_task_assign_processor: NATURAL_8 = 1
	frozen scoop_task_free_processor: NATURAL_8 = 2
	frozen scoop_task_start_processor_loop: NATURAL_8 = 3
	frozen scoop_task_signify_start_of_new_chain: NATURAL_8 = 4
	frozen scoop_task_signify_end_of_new_chain: NATURAL_8 = 5
	frozen scoop_task_add_supplier_to_request_chain: NATURAL_8 = 6
	frozen scoop_task_wait_for_supplier_processor_locks: NATURAL_8 = 7
	frozen scoop_task_add_call: NATURAL_8 = 8
	frozen scoop_task_wait_for_processor_redundancy: NATURAL_8 = 9
		-- SCOOP Task Constants, copy of those defined in <eif_macros.h>
		-- FIXME IEK: Use external macros when valid in an inspect statement.

	set_return_value (a_typed_value: POINTER; a_value_addr: POINTER)
		external
			"C inline"
		alias
			"[
				EIF_TYPED_VALUE *etval = (EIF_TYPED_VALUE*)$a_typed_value;
				switch (etval->type)
				{
					case SK_REF:
						etval->item.r = *((EIF_REFERENCE*)$a_value_addr); break;
					case SK_POINTER:
						etval->item.p = *((EIF_POINTER*)$a_value_addr); break;
					case SK_BOOL:
						etval->item.b = *((EIF_BOOLEAN*)$a_value_addr); break;
					case SK_CHAR8:
						etval->item.c1 = *((EIF_CHARACTER_8*)$a_value_addr); break;
					case SK_CHAR32:
						etval->item.c4 = *((EIF_CHARACTER_32*)$a_value_addr); break;
					case SK_INT8:
						etval->item.i1 = *((EIF_INTEGER_8*)$a_value_addr); break;
					case SK_INT16:
						etval->item.i2 = *((EIF_INTEGER_16*)$a_value_addr); break;
					case SK_INT32:
						etval->item.i4 = *((EIF_INTEGER_32*)$a_value_addr); break;
					case SK_INT64:
						etval->item.i8 = *((EIF_INTEGER_64*)$a_value_addr); break;
					case SK_UINT8:
						etval->item.n1 = *((EIF_NATURAL_8*)$a_value_addr); break;
					case SK_UINT16:
						etval->item.n2 = *((EIF_NATURAL_16*)$a_value_addr); break;
					case SK_UINT32:
						etval->item.n4 = *((EIF_NATURAL_32*)$a_value_addr); break;
					case SK_UINT64:
						etval->item.n8 = *((EIF_NATURAL_64*)$a_value_addr); break;
					case SK_REAL32:
						etval->item.r4 = *((EIF_REAL_32*)$a_value_addr); break;
					case SK_REAL64:
						etval->item.r8 = *((EIF_REAL_64*)$a_value_addr); break;
					default:
						;// exception;
				}
			]"
		end

feature -- Processor Initialization

	assign_free_processor_id: like processor_id_type
		do
			-- Find the next available free SCOOP Processor, reuse or instantiate as needs be.
			-- Either return new scoop processor id or set in EIF_OBJECT header.

			Result := {ATOMIC_MEMORY_OPERATIONS}.increment_integer_32 ($scoop_logical_processor_id_count)
			if Result = max_scoop_processors_instantiable then
				-- Perform processor cleanup.
				-- Raise Exception if no free processor could not be found, or block until there is one.
			end


			debug ("ISE_SCOOP_MANAGER")
				print ("assign_free_processor_id of pid " + Result.out + "%N")
			end
		end

	free_processor_id (a_processor_id: like processor_id_type)
			-- Free resources of processor id `a_processor_id'.
		do
			-- Mark `a_processor_id' as free.
			-- Called via GC so all threads will be stopped.
		end

	start_processor_application_loop (a_processor_id: like processor_id_type)
			-- Start feature application loop for `a_processor_id'.
		local
			l_scoop_processor_attributes: ISE_SCOOP_PROCESSOR_ATTRIBUTES
		do
				--!FIXME IEK: Allocate a default value for reuse.
			create l_scoop_processor_attributes
			create_and_initialize_scoop_processor (Current, $scoop_processor_loop, l_scoop_processor_attributes.item, a_processor_id)
		end

	frozen wait_for_processor_redundancy
			-- The calling thread waits for all other threads to terminate.
		external
			"C blocking use %"eif_threads.h%""
		alias
			"eif_thr_join_all"
		end

feature -- Request Chain Handling

	signify_start_of_request_chain (a_client_processor_id: like processor_id_type)
			-- Signify the start of a new request chain on `a_client_processor_id'
		local
			l_new_request_chain_id: like scoop_processor_invalid_request_chain_id
			l_new_request_chain_meta_data: like new_scoop_processor_meta_data_entry
		do
			-- Check for any set request chain id for `a_client_processor_id', if already set then may have a lock passing situation.

			--debug ("ISE_SCOOP_MANAGER")
				print ("signify_start_of_request_chain for pid " + a_client_processor_id.out + " %N")
			--end

			l_new_request_chain_id := (scoop_processor_meta_data [a_client_processor_id])[scoop_processor_current_request_chain_id_index]
			if l_new_request_chain_id = scoop_processor_invalid_request_chain_id then
					-- There are no nested chains so we initialize a new request chain id for `a_client_processor_id'

					-- Could be replace with a global counter for speed
				l_new_request_chain_id := (scoop_processor_meta_data [a_client_processor_id])[scoop_processor_request_chain_id_counter_index] + 1
				(scoop_processor_meta_data [a_client_processor_id]).put (l_new_request_chain_id, scoop_processor_current_request_chain_id_index)

					-- Create new meta data for the new request chain.
				l_new_request_chain_meta_data := new_scoop_processor_request_chain_meta_data_entry
				scoop_processor_request_chain_meta_data [a_client_processor_id] := l_new_request_chain_meta_data

					-- Store in structure that is accessed via the new request chain id index.
			end
		end

	assign_supplier_processor_to_request_chain (a_client_processor_id, a_supplier_processor_id: like processor_id_type)
		local
			l_request_chain_id: like scoop_processor_invalid_request_chain_id
			l_request_chain_meta_data: detachable like new_scoop_processor_meta_data_entry
			i, l_count: INTEGER
			l_pid_present: BOOLEAN
		do
			--debug ("ISE_SCOOP_MANAGER")
				print ("assign_supplier_process_to_request_chain for pid " + a_client_processor_id.out + " with supplier processor " + a_supplier_processor_id.out + "%N")
			--end

			l_request_chain_id := (scoop_processor_meta_data [a_client_processor_id])[scoop_processor_current_request_chain_id_index]

				-- Retrieve request chain meta data structure, add supplier pid to it if not already present.
			l_request_chain_meta_data := scoop_processor_request_chain_meta_data [a_client_processor_id]
			check l_request_chain_meta_data_attached: attached l_request_chain_meta_data end


			from
				i := 0
				l_count := l_request_chain_meta_data.count
			until
				i = l_count
			loop
				if l_request_chain_meta_data [i] = a_supplier_processor_id then
						-- pid already present so exit loop and do nothing else.
					l_pid_present := True
					i := l_count
				else
					i := i + 1
				end
			end

			if not l_pid_present then
					-- Check that structure is big enough, if not then resize and readd to parent structure.
				if l_request_chain_meta_data.count = l_request_chain_meta_data.capacity then
					l_request_chain_meta_data := l_request_chain_meta_data.aliased_resized_area (l_request_chain_meta_data.count + 2)
					scoop_processor_request_chain_meta_data [a_client_processor_id] := l_request_chain_meta_data
				end
					-- Add new pid to request chain list.
				l_request_chain_meta_data.extend (a_supplier_processor_id)
			end
		end

	wait_for_request_chain_supplier_processor_locks (a_client_processor_id: like processor_id_type)
		local
			l_request_chain_id: like scoop_processor_invalid_request_chain_id
			l_request_chain_meta_data: detachable like new_scoop_processor_meta_data_entry
			l_sorted, l_swap_occurred: BOOLEAN
			i, l_container_count, l_unique_pid_count: INTEGER
			l_pid: like processor_id_type
			l_lock_request_return: NATURAL_8
		do
			-- Sort unique processor id's by order of priority, then wait for locks on each processor so that a new request chain node can be initialized.
			--debug ("ISE_SCOOP_MANAGER")
				print ("wait_for_request_chain_supplier_processor_locks for pid " + a_client_processor_id.out + "%N")
			--end

				-- Retrieve request chain meta data structure
				-- Sort unique pid values by logical order

			l_request_chain_id := (scoop_processor_meta_data [a_client_processor_id])[scoop_processor_current_request_chain_id_index]

			-- Retrieve request chain meta data structure.
			l_request_chain_meta_data := scoop_processor_request_chain_meta_data [a_client_processor_id]
			check l_request_chain_meta_data_attached: attached l_request_chain_meta_data end

			from
					-- Start at first PID value, with zero based SPECIAL this equals the header size.
				i := scoop_processor_request_chain_meta_data_header_size
					-- At this stage the number of unique pid's in structure is count - header size.
				l_unique_pid_count := l_request_chain_meta_data.count - scoop_processor_request_chain_meta_data_header_size
				l_container_count := l_request_chain_meta_data.count
				l_sorted := l_unique_pid_count <= 1
			until
				l_sorted
			loop
					-- Sort Unique PID Values by order of priority (in this case the lowest PID value takes preference)
				l_pid := l_request_chain_meta_data [i]
				if l_pid > l_request_chain_meta_data [i + 1] then
					l_request_chain_meta_data [i] := l_request_chain_meta_data [i + 1]
					l_request_chain_meta_data [i + 1] := l_pid
					l_swap_occurred := l_unique_pid_count > 2
						-- If we swap with two unique values then there is no need to reiterate
						-- as this is the only operation that can occur.
				end
					-- If we are at the final PID position and no swap has occurred then we can exit the loop
					-- Otherwise we must reset the index to the position and start again to check that it is full sorted.
				if i = l_container_count - 2 then
						-- -2 for zero based penultimate value.
					if l_swap_occurred then
							-- Reset iteration to start values.
						l_swap_occurred := False
						i := scoop_processor_request_chain_meta_data_header_size
					else
						l_sorted := True
					end
				else
					i := i + 1
				end
			end


				-- Reformulate meta data structure with unique pid count as the first value followed by the unique sorted pid values
			l_request_chain_meta_data [0] := l_unique_pid_count
			l_request_chain_meta_data [1] := a_client_processor_id
			l_request_chain_meta_data [2] := l_request_chain_id

				-- Extend request chain meta data to include request chain node ids for the supplier processors.
				-- Resize container if necessary.
			l_request_chain_meta_data := l_request_chain_meta_data.aliased_resized_area (l_container_count + l_unique_pid_count)
			scoop_processor_request_chain_meta_data [a_client_processor_id] := l_request_chain_meta_data


				-- Obtain a request queue lock on each of the processors (already uniquely sorted by logical pid order)
			from
				i := scoop_processor_request_chain_meta_data_header_size
			until
				i = l_container_count
			loop
					-- Obtain lock on request chain node id value to prevent other processors from accessing it
					-- This has to be done atomically via compare and swap
				l_pid := l_request_chain_meta_data [i]
				l_lock_request_return := request_processor_resource (
					scoop_processor_meta_data [l_pid].item_address (scoop_processor_current_request_chain_node_id_lock_index),
					a_client_processor_id,
					True, -- Wait until granted, we cannot continue until we have control over the value.
					True  -- High Priority, wait is minimal as this is a temporary lock value
				)
				check resource_attained: l_lock_request_return = Scoop_processor_resource_lock_newly_attained end

				i := i + 1
			end

			-- When all locks have been obtained we retrieve the request chain node ids for each of the locked processors.

			from
				i := scoop_processor_request_chain_meta_data_header_size
			until
				i = l_container_count
			loop
					-- Add the current supplier processor request chain node id
				l_pid := l_request_chain_meta_data [i]
				l_request_chain_meta_data.extend (
					{ATOMIC_MEMORY_OPERATIONS}.increment_integer_32 (scoop_processor_meta_data [l_pid].item_address (scoop_processor_current_request_chain_node_id_index))
				)
				i := i + 1
			end

			-- Release locks when request chain nodes ids have been calculated.

			from
				i := scoop_processor_request_chain_meta_data_header_size
			until
				i = l_container_count
			loop
					-- Release lock on processor request chain node id
					-- This has to be done atomically via compare and swap
				l_pid := l_request_chain_meta_data [i]
				l_lock_request_return := request_processor_resource (
					scoop_processor_meta_data [l_pid].item_address (scoop_processor_current_request_chain_node_id_lock_index),
					a_client_processor_id,
					True, -- Wait until granted
					True  -- High Priority
				)
				i := i + 1
			end

		end

	signify_end_of_request_chain (a_client_processor_id: like processor_id_type)
		do
			-- Increase request chain id
			--debug ("ISE_SCOOP_MANAGER")
				print ("signify_end_of_request_chain for pid " + a_client_processor_id.out + "%N")
			--end

			-- Reset current request chain id if no lock passing occurred.

			-- Reset count existing request chain meta data for `a_client_processor_id' if no lock passing occurred.
		end

feature -- Command/Query Handling

	request_chain_node: ARRAYED_QUEUE [POINTER]
		do
			if attached detachable_request_chain_node as n then
				Result := n
			else
				create Result.make (default_chain_node_size)
			end
		end

	default_chain_node_size: INTEGER = 5

	detachable_request_chain_node: detachable like request_chain_node

	log_call_on_processor (a_client_processor_id, a_supplier_processor_id: like processor_id_type; a_routine: like routine_type; data: like call_data)
		local
			l_request_chain_node: like request_chain_node
		do
			--debug ("ISE_SCOOP_MANAGER")
			--	print ("log_call_on_processor for pid " + a_client_processor_id.out + " on pid " + a_supplier_processor_id.out + "%N")
			--end

			-- Log command on target processor,
			l_request_chain_node := request_chain_node
			l_request_chain_node.extend (data)

			-- Check if we are currently uninitialized, if not then we must be logging a creation routine.
			-- Therefore we can start the processor loop as the creation routine has been logged.

							-- No locks needed as structure is preallocated.
			if (scoop_processor_meta_data [a_supplier_processor_id])[scoop_processor_status_index] = scoop_processor_status_uninitialized then
					-- Mark processor as initialized.
				(scoop_processor_meta_data [a_supplier_processor_id]).put (scoop_processor_status_initialized, scoop_processor_status_index)
				start_processor_application_loop (a_supplier_processor_id)
			end

			detachable_request_chain_node := l_request_chain_node
		end

feature {NONE} -- Resource Initialization

	init_scoop_manager
			-- Initialize processor meta data.
		local
			i: INTEGER_32
			l_scoop_processor_meta_data: like scoop_processor_meta_data
		do
			from
				i := 1
				create l_scoop_processor_meta_data.make_empty (Max_scoop_processors_instantiable)
				create scoop_processor_request_chain_meta_data.make_filled (Void, max_scoop_processors_instantiable)
			until
				i > Max_scoop_processors_instantiable
			loop
				l_scoop_processor_meta_data.extend (new_scoop_processor_meta_data_entry)
				i := i + 1
			end
			scoop_processor_meta_data := l_scoop_processor_meta_data
		end

	scoop_processor_loop (a_logical_processor_id: like processor_id_type)
		local
			l_exit: BOOLEAN
			i: INTEGER
		do
			from
				l_exit := False
			until
				l_exit
			loop
				if attached detachable_request_chain_node as n and then not n.is_empty then
					scoop_command_call (n.item)
					n.remove
				end
				scoop_processor_sleep (10000000)
				i := i + 1
				l_exit := i = 20
			end
		end

	scoop_command_call (data: POINTER)
		external
			"C inline"
		alias
			"[
			#ifdef WORKBENCH
				eif_try_call ($data);
			#endif
			]"
		end

	request_processor_resource (a_resource_address: POINTER; a_requesting_processor: like processor_id_type; a_block_until_request_granted, a_high_priority: BOOLEAN): NATURAL_8
			--| FIXME IEK: a_resource_address should be type safe with TYPED_POINTER [INTEGER_32] but this not current be returned from SPECIAL [INTEGER_32]
		local
			l_exit: BOOLEAN
			l_original_value: INTEGER_32
		do
			from
			until
				l_exit
			loop
					-- Use `a_resource_type' to determine what kind of resource of `a_requesting_processor' needs from `a_resource_processor'.
					-- Be it exclusive access to request queue, or for access to processor locks for lock passing.
				l_original_value := {ATOMIC_MEMORY_OPERATIONS}.compare_and_swap_integer_32 (a_resource_address, a_requesting_processor, null_processor_id)
				if l_original_value = null_processor_id then
						-- The value has been correctly set so Return True and Exit
					Result := scoop_processor_resource_lock_newly_attained
					l_exit := True
				else
					-- The processor resource has already been prior requested.
					if l_original_value = a_requesting_processor then
						-- `a_requesting_processor' already has the lock so we can exit.

						--| FIXME We need to handle recursive locking for unlock.
						Result := scoop_processor_resource_lock_previously_attained
						l_exit := True
					elseif a_block_until_request_granted then
							-- If high priority then we perform a spin lock.
						if not a_high_priority then
							yield_to_operating_system
						end
					else
						-- We don't have the lock and we do not block so we exit and return False.
						Result := scoop_processor_resource_lock_unattained
						l_exit := True
						if not a_high_priority then
							yield_to_operating_system
						end
					end
				end
			end
		end

	scoop_processor_resource_lock_unattained: NATURAL_8 = 0
	scoop_processor_resource_lock_newly_attained: NATURAL_8 = 1
	scoop_processor_resource_lock_previously_attained: NATURAL_8 = 2
		-- SCOOP Processor resource lock return values.

	relinquish_processor_resource (a_resource_address: POINTER; a_requesting_processor: like processor_id_type; a_high_priority: BOOLEAN)
			-- Relinquish processor resource at `a_resource_address' previously obtained by `a_requesting_processor'.
		local
			l_original_value: INTEGER_32
		do
			l_original_value := {ATOMIC_MEMORY_OPERATIONS}.compare_and_swap_integer_32 (a_resource_address, null_processor_id, a_requesting_processor)
			check resource_relinquished: l_original_value = a_requesting_processor end
			if not a_high_priority then
				yield_to_operating_system
			end
		end

	requesting_processor_value: INTEGER

	processor_id_type: INTEGER_32
		do
			-- Type used for unique SCOOP processor id.
		end

	null_processor_id: INTEGER_32 = -1

	scoop_logical_processor_id_count: INTEGER_32
		-- Number of logical processor ids that have been allocated.
		-- Value should not be used directly and only accessed via atomic memory operations.

feature {NONE} -- Scoop Processor Meta Data

	routine_type: NATURAL_32 do end
	call_data: POINTER do end
	result_type: POINTER do end

	max_scoop_processors_instantiable: INTEGER_32 = 256
		-- Total Number of SCOOP Processors that may be instantiated by Pool including Root.

	scoop_processor_meta_data: SPECIAL [like new_scoop_processor_meta_data_entry]
			-- Holder of Processor Meta Data (indexed by logical processor ID)

	scoop_processor_request_chain_meta_data: SPECIAL [detachable like new_scoop_processor_request_chain_meta_data_entry]
			-- Holder of Processor Request Chain Meta Data (indexed by logical processor ID)

	new_scoop_processor_meta_data_entry: SPECIAL [INTEGER_32]
			-- New Processor Meta Data Value Entry
		do
			create Result.make_filled (null_processor_id, scoop_processor_meta_data_index_count)
		end

	new_scoop_processor_request_chain_meta_data_entry: SPECIAL [INTEGER_32]
			-- New Request Chain Meta Data
		do
			create Result.make_empty (scoop_processor_request_chain_meta_data_default_size)
				-- Add meta data header null values.
			Result.fill_with (null_processor_id, 0, 2)
			-- Format = {pid_count, head_pid, tailx_pid, head request chain node id, tail request chain node id}
		end

	scoop_processor_request_chain_meta_data_default_size: INTEGER_32 = 9
		-- meta data header + (3 * supplier PID request chain meta data to hold 3 processor metadata values)
	scoop_processor_request_chain_meta_data_header_size: INTEGER_32 = 3
		-- Size of request chain meta data header {pid_count, client pid, client pid request chain id}
	scoop_processor_request_chain_meta_data_supplier_pid_meta_data_size: INTEGER_32 = 2
		-- {Supplier PID, Supplier Request Chain Node ID}

	scoop_processor_status_index: INTEGER_32 = 0
			-- Current Status of the Scoop Processor at index 'scoop_logical_index'.

	scoop_processor_status_uninitialized: INTEGER_32 = -1
		-- Only processor object has been allocated at this point.
	scoop_processor_status_initialized: INTEGER_32 = 1
		-- Processor is initialized and executing.
	scoop_processor_status_redundant: INTEGER_32 = 2
		-- Processor is redundant.

	scoop_processor_current_request_chain_id_index: INTEGER_32 = 2
		-- Index to value containing current request chain id.

	scoop_processor_invalid_request_chain_id: INTEGER_32 = -1

	scoop_processor_request_chain_id_counter_index: INTEGER_32 = 3

	scoop_processor_request_chain_id_lock_index: INTEGER_32 = 5
		-- Index to value containing the lock on the processor for request chain initialization.

	scoop_processor_current_request_chain_node_id_index: INTEGER = 6
		-- Index to value containing current request chain node id.

	scoop_processor_current_request_chain_node_id_lock_index: INTEGER = 7
		-- Index to value containing current request chain node id.


	scoop_processor_meta_data_index_count: INTEGER_32 = 8

feature {NONE} -- Externals

	frozen available_cpus: NATURAL_8
		external
			"C inline use %"eif_scoop.h%""
		alias
			"[
				//#ifdef _WIN32
				//#include <windows.h>
				//#elif MACOS
				//#include <sys/param.h>
				//#include <sys/sysctl.h>
				//#else
				//#include <unistd.h>
				//#endif
				#ifdef EIF_WINDOWS
				    SYSTEM_INFO sysinfo;
				    GetSystemInfo(&sysinfo);
				    return sysinfo.dwNumberOfProcessors;
				#elif EIF_MACOSX
				    int nm[2];
				    size_t len = 4;
				    uint32_t count;

				    nm[0] = CTL_HW; nm[1] = HW_AVAILCPU;
				    sysctl(nm, 2, &count, &len, NULL, 0);

				    if(count < 1) {
				        nm[1] = HW_NCPU;
				        sysctl(nm, 2, &count, &len, NULL, 0);
				        if(count < 1) { count = 1; }
				    }
				    return count;
				#else
				    return sysconf(_SC_NPROCESSORS_ONLN);
				#endif
			]"
		end

	frozen create_and_initialize_scoop_processor (current_obj: like Current; init_func, attr: POINTER; a_processor_id: like processor_id_type)
			-- Initialize and start SCOOP Processor thread.
		external
			"C inline use %"eif_threads.h%""
		alias
			"[
				eif_thr_create_with_attr_new ((EIF_OBJECT)$current_obj, (EIF_PROCEDURE) $init_func, (EIF_INTEGER_32)$a_processor_id, EIF_TRUE, (EIF_POINTER)$attr);
			]"
		end

	frozen scoop_processor_sleep (nanoseconds: INTEGER_64)
			-- Suspend thread execution for interval specified in
			-- `nanoseconds' (1 nanosecond = 10^(-9) second).
			-- FIXME: Check that inlining retains blocking status
		require
			non_negative_nanoseconds: nanoseconds >= 0
		external
			"C blocking use %"eif_misc.h%""
		alias
			"eif_sleep"
		end

	frozen yield_to_operating_system
			-- Yield processor to competing threads for an OS specific set time.
			-- FIXME: Check that inlining retains blocking status
		external
			"C blocking use %"eif_threads.h%""
		alias
			"eif_thr_yield"
		end

	frozen native_thread_id: POINTER
			-- Native Thread ID of the `Current' SCOOP Processor
		external
			"C inline use <eif_threads.h>"
		alias
			"return eif_thr_thread_id();"
		end

end
