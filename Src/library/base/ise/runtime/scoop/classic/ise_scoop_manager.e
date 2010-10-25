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

		set_return_value (a_sk_type_value: INTEGER_32; a_return_value: POINTER; a_value_addr: POINTER)
		external
			"C inline"
		alias
			"[
				switch ((EIF_INTEGER_32)$a_sk_type_value)
				{
					case SK_REF:
						*(EIF_REFERENCE*)$a_return_value = *(EIF_REFERENCE*)$a_value_addr; break;
					case SK_POINTER:
						*(EIF_POINTER*)$a_return_value = *(EIF_POINTER*)$a_value_addr; break;
					case SK_BOOL:
						*(EIF_BOOLEAN*)$a_return_value = *(EIF_BOOLEAN*)$a_value_addr; break;
					case SK_CHAR8:
						*(EIF_CHARACTER_8*)$a_return_value = *(EIF_CHARACTER_8*)$a_value_addr; break;
					case SK_CHAR32:
						*(EIF_CHARACTER_32*)$a_return_value = *(EIF_CHARACTER_32*)$a_value_addr; break;
					case SK_INT8:
						*(EIF_INTEGER_8*)$a_return_value = *(EIF_INTEGER_8*)$a_value_addr; break;
					case SK_INT16:
						*(EIF_INTEGER_16*)$a_return_value = *(EIF_INTEGER_16*)$a_value_addr; break;
					case SK_INT32:
						*(EIF_INTEGER_32*)$a_return_value = *(EIF_INTEGER_32*)$a_value_addr; break;
					case SK_INT64:
						*(EIF_INTEGER_64*)$a_return_value = *(EIF_INTEGER_64*)$a_value_addr; break;
					case SK_UINT8:
						*(EIF_NATURAL_8*)$a_return_value = *(EIF_NATURAL_8*)$a_value_addr; break;
					case SK_UINT16:
						*(EIF_NATURAL_16*)$a_return_value = *(EIF_NATURAL_16*)$a_value_addr; break;
					case SK_UINT32:
						*(EIF_NATURAL_32*)$a_return_value = *(EIF_NATURAL_32*)$a_value_addr; break;
					case SK_UINT64:
						*(EIF_NATURAL_64*)$a_return_value = *(EIF_NATURAL_64*)$a_value_addr; break;
					case SK_REAL32:
						*(EIF_REAL_32*)$a_return_value = *(EIF_REAL_32*)$a_value_addr; break;
					case SK_REAL64:
						*(EIF_REAL_64*)$a_return_value = *(EIF_REAL_64*)$a_value_addr; break;
					default:
						;// exception;
				}
			]"
		end

	sk_ref: INTEGER_32 external "C inline" alias "SK_REF" end
	sk_pointer: INTEGER_32 external "C inline" alias "SK_POINTER" end
	sk_bool: INTEGER_32 external "C inline" alias "SK_BOOL" end
	sk_char8: INTEGER_32 external "C inline" alias "SK_CHAR8" end
	sk_char32: INTEGER_32 external "C inline" alias "SK_CHAR32" end
	sk_int8: INTEGER_32 external "C inline" alias "SK_INT8" end
	sk_int16: INTEGER_32 external "C inline" alias "SK_INT16" end
	sk_int32: INTEGER_32 external "C inline" alias "SK_INT32" end
	sk_int64: INTEGER_32 external "C inline" alias "SK_INT64" end
	sk_uint8: INTEGER_32 external "C inline" alias "SK_UINT8" end
	sk_uint16: INTEGER_32 external "C inline" alias "SK_UINT16" end
	sk_uint32: INTEGER_32 external "C inline" alias "SK_UINT32" end
	sk_uint64: INTEGER_32 external "C inline" alias "SK_UINT64" end
	sk_real32: INTEGER_32 external "C inline" alias "SK_REAL32" end
	sk_real64: INTEGER_32 external "C inline" alias "SK_REAL64" end

	set_typed_value_value (a_typed_value: POINTER; a_value_addr: POINTER)
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

	scoop_manager_task_callback (scoop_task: NATURAL_8; client_processor_id, supplier_processor_id: like processor_id_type; body_index: NATURAL_32; arguments_tuple, return_value_address: POINTER)
		local
			l_id: INTEGER_32
		do
			inspect
				scoop_task
			when scoop_task_assign_processor then
				l_id := assign_free_processor_id
				set_return_value (sk_int32, return_value_address, $l_id)
				start_processor_application_loop (l_id)
			when scoop_task_free_processor then
				free_processor_id (client_processor_id)
			when scoop_task_start_processor_loop then
				start_processor_application_loop (client_processor_id)
			when scoop_task_signify_start_of_new_chain then
				signify_start_of_request_chain (client_processor_id)
			when scoop_task_signify_end_of_new_chain then
				signify_end_of_request_chain (client_processor_id)
			when scoop_task_add_supplier_to_request_chain then
				assign_supplier_processor_to_request_chain (client_processor_id, supplier_processor_id)
			when scoop_task_wait_for_supplier_processor_locks then
				wait_for_request_chain_supplier_processor_locks (client_processor_id)
			when scoop_task_add_predicate then
				log_predicate_on_processor (client_processor_id, supplier_processor_id, body_index, arguments_tuple, return_value_address)
			when scoop_task_add_command then
				log_command_on_processor (client_processor_id, supplier_processor_id, body_index, arguments_tuple)
			when scoop_task_add_query then
				log_query_on_processor (client_processor_id, supplier_processor_id, body_index, arguments_tuple, return_value_address)
			else
				check invalid_task: False end
			end
		end

	scoop_task_assign_processor: NATURAL_8 = 1
	scoop_task_free_processor: NATURAL_8 = 2
	scoop_task_start_processor_loop: NATURAL_8 = 3
	scoop_task_signify_start_of_new_chain: NATURAL_8 = 4
	scoop_task_signify_end_of_new_chain: NATURAL_8 = 5
	scoop_task_add_supplier_to_request_chain: NATURAL_8 = 6
	scoop_task_wait_for_supplier_processor_locks: NATURAL_8 = 7
	scoop_task_add_predicate: NATURAL_8 = 8
	scoop_task_add_command: NATURAL_8 = 9
	scoop_task_add_query: NATURAL_8 = 10

feature -- Processor Initialization

	assign_free_processor_id: like processor_id_type
		do
			-- Find the next available free SCOOP Processor, reuse or instantiate as needs be.
			-- Either return new scoop processor id or set in EIF_OBJECT header.
			Result := {ATOMIC_MEMORY_OPERATIONS}.increment_integer_32 ($scoop_logical_processor_id_count)
		end

	free_processor_id (a_processor_id: like processor_id_type)
			-- Free resources of processor id `a_processor_id'.
		do
			-- Mark `a_processor_id' as free.
			-- Called via GC so all threads will be stopped.
		end

	start_processor_application_loop (a_processor_id: like processor_id_type)
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
		do
			-- Use currently set request chain id, if there is already one set then we have a potential lock passing situation.
		end

	assign_supplier_processor_to_request_chain (a_supplier_processor_id, a_client_processor_id: like processor_id_type)
		do
			-- Make sure that we check for duplicate supplier processor for the routine block id otherwise we will run in to problems.
			-- We also need to handle lock passing should supplier processor equal client processor.
			-- This is handled at the time of feature application so this requires some thought.
		end

	wait_for_request_chain_supplier_processor_locks (a_client_processor_id: like processor_id_type)
		do
			-- Sort unique processor id's by order of priority, then wait for locks on each processor so that a new request chain node can be initialized.
		end

	signify_end_of_request_chain (a_client_processor_id: like processor_id_type)
		do
			-- Increase request chain id
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

	log_predicate_on_processor (a_client_processor_id, a_supplier_processor_id: like processor_id_type; a_routine: like routine_type; data: like call_data; a_result_value: like result_type)
		do
			-- Log query on target processor.
			-- We need wait until the supplier processor has finished executing the current routine block id for client processor
			-- and then reset the block so that new entries can be added.
		end

	log_command_on_processor (a_client_processor_id, a_supplier_processor_id: like processor_id_type; a_routine: like routine_type; data: like call_data)
		local
			l_request_chain_node: like request_chain_node
		do
			-- Log command on target processor,
			l_request_chain_node := request_chain_node
			l_request_chain_node.extend (data)

			detachable_request_chain_node := l_request_chain_node
		end

	log_query_on_processor (a_client_processor_id, a_supplier_processor_id: like processor_id_type; a_routine: like routine_type; data: like call_data; a_result_value: like result_type)
		local
			l_request_chain_node: like request_chain_node
		do
			-- Log query on target processor.
			-- We need wait until the supplier processor has finished executing the current routine block id for client processor
			-- and then reset the block so that new entries can be added.
			l_request_chain_node := request_chain_node
			l_request_chain_node.extend (data)

			detachable_request_chain_node := l_request_chain_node
		end

feature {NONE} -- Resource Initialization

	init_scoop_manager
			-- Initialize processor meta data.
		local
			i: INTEGER
			l_scoop_processor_meta_data: like scoop_processor_meta_data
		do
			from
				i := 1
				create l_scoop_processor_meta_data.make_empty (max_scoop_processors_instantiable)
			until
				i > max_scoop_processors_instantiable
			loop
				l_scoop_processor_meta_data.extend (new_scoop_processor_meta_data_entry)
				i := i + 1
			end
			scoop_processor_meta_data := l_scoop_processor_meta_data
		end

	scoop_processor_loop (a_logical_processor_id: like processor_id_type)
		local
--			l_original_value: INTEGER_32
			l_exit: BOOLEAN
--			l_resource_lock_return_value: NATURAL_8
		do
			from
			until
				l_exit
			loop
--				l_resource_lock_return_value := request_processor_resource (0, a_logical_processor_id, 0, False, False)
--				if l_resource_lock_return_value = scoop_processor_resource_lock_newly_attained then
--					print (a_logical_processor_id.out + " has just attained the lock%N")
--					relinquish_processor_resource (0, a_logical_processor_id, 0, False)
--				elseif l_resource_lock_return_value = scoop_processor_resource_lock_unattained then
--					print (l_scoop_logical_processor_id.out + " has failed to get the lock%N")
--				else
--					print (l_scoop_logical_processor_id.out + " already has the lock%N")
--				end
				if attached detachable_request_chain_node as n and then not n.is_empty then
					scoop_command_call (n.item)
					n.remove
--					l_exit := True
					scoop_processor_sleep (10000000)
				end
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

	request_processor_resource (a_resource_type: NATURAL_8; a_requesting_processor, a_resource_processor: like processor_id_type; a_block_until_request_granted, a_high_priority: BOOLEAN): NATURAL_8
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
				l_original_value := {ATOMIC_MEMORY_OPERATIONS}.compare_and_swap_integer_32 ($requesting_processor_value, a_requesting_processor, null_processor_id)
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

	relinquish_processor_resource (a_resource_type: NATURAL_8; a_requesting_processor, a_resource_processor: like processor_id_type; a_high_priority: BOOLEAN)
		local
			l_original_value: INTEGER_32
		do
			l_original_value := {ATOMIC_MEMORY_OPERATIONS}.compare_and_swap_integer_32 ($requesting_processor_value, null_processor_id, a_requesting_processor)
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

feature {NONE} -- Scoop Processor Meta Data

	routine_type: NATURAL_32 do end
	call_data: POINTER do end
	result_type: POINTER do end

	max_scoop_processors_instantiable: INTEGER_32 = 256
		-- Total Number of SCOOP Processors that may be instantiated by Pool.

	scoop_processor_meta_data: SPECIAL [like new_scoop_processor_meta_data_entry]
			-- Holder of Processor Meta Data (indexed by logical processor ID)

	new_scoop_processor_meta_data_entry: SPECIAL [INTEGER_32]
			-- New Processor Meta Data Value Entry
		do
			create Result.make_filled (null_processor_id, scoop_processor_meta_data_index_count)
		end

	scoop_processor_status_index: INTEGER_32 = 0
		-- Current Status of the Scoop Processor at index 'scoop_logical_index'.
	scoop_process_status_unallocated: INTEGER_32 = 0
	scoop_processor_status_allocated: INTEGER_32 = 1
	scoop_processor_status_free: INTEGER_32 = 2

	reference_count_index: INTEGER_32 = 1
		-- Number of objects referenced by SCOOP Processor
		-- When zero then we flag the processor as either free or deallocate it.

	request_chain_lock_index: INTEGER_32 = 2
		-- Index to value containing SCOOP Processor ID that has a lock on the request chain.

	client_routine_block_id_index: INTEGER_32
	supplier_routine_block_id_index: INTEGER_32

	application_queue_lock_index: INTEGER_32 = 4
	scoop_processor_meta_data_index_count: INTEGER_32 = 8

feature {NONE} -- Externals

	frozen available_cpus: NATURAL_8
		external
			"C inline use %"eif_threads.h%""
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
