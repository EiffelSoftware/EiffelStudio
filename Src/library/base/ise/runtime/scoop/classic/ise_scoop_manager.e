note
	description: "Core for handling of separate calls in SCOOP"
	patent: "[
		The concurrency techniques associated with this and other classes are covered by a
		filed patent application.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

frozen class
	ISE_SCOOP_MANAGER

create {NONE}
	init_scoop_manager

feature -- C callback function

	scoop_manager_task_callback (scoop_task: NATURAL_8; client_processor_id, supplier_processor_id: like processor_id_type; body_index: NATURAL_32; a_callback_data, a_reserved: POINTER)
			-- Entry point to ISE_SCOOP_MANAGER from RTS SCOOP macros.
		local
			l_id: INTEGER_32
			l_uncontrolled: BOOLEAN
		do
			inspect
				scoop_task
			when assign_processor_task_id then
				l_id := assign_free_processor_id
				set_return_value (a_callback_data, $l_id)
			when free_processor_task_id then
				free_processor_id (client_processor_id)
			when start_processor_loop_task_id then
					-- Reinstantate during optimization phase.
--				start_processor_application_loop (client_processor_id)
			when signify_start_of_new_chain_task_id then
				signify_start_of_request_chain (client_processor_id)
			when signify_end_of_new_chain_task_id then
				if supplier_processor_id = null_processor_id then
					signify_end_of_wait_condition_chain (client_processor_id)
				else
					signify_end_of_request_chain (client_processor_id)
				end
			when add_supplier_to_request_chain_task_id then
				assign_supplier_processor_to_request_chain (client_processor_id, supplier_processor_id)
			when wait_for_supplier_processor_locks_task_id then
				wait_for_request_chain_supplier_processor_locks (client_processor_id)
			when add_call_task_id then
				log_call_on_processor (client_processor_id, supplier_processor_id, body_index, a_callback_data)
			when wait_for_processor_redundancy_task_id then
				set_root_processor_has_exited
			when add_processor_reference_task_id then
				add_processor_reference (supplier_processor_id)
			when remove_processor_reference_task_id then
				remove_processor_reference (supplier_processor_id)
			when check_uncontrolled_call_task_id then
				l_uncontrolled := is_uncontrolled (client_processor_id, supplier_processor_id)
				set_return_value (a_callback_data, $l_uncontrolled)
			else
				check invalid_task: False end
			end
		end

	add_processor_reference (a_processor_id: like processor_id_type)
			-- Increase reference count for `a_processor_id'.
			--| FIXME Needs GC implementation for use
		local
			l_ref: INTEGER_32
		do
			l_ref := {ATOMIC_MEMORY_OPERATIONS}.increment_integer_32 (processor_meta_data [a_processor_id].item_address (processor_reference_count_index))
		end

	remove_processor_reference (a_processor_id: like processor_id_type)
			-- Decrease reference count for `a_processor_id'.
			--| FIXME Needs GC implementation for use
		local
			l_ref: INTEGER_32
		do
			l_ref := {ATOMIC_MEMORY_OPERATIONS}.decrement_integer_32 (processor_meta_data [a_processor_id].item_address (processor_reference_count_index))
		end

	is_uncontrolled (a_client_processor_id, a_supplier_processor_id: like processor_id_type): BOOLEAN
			-- Is `a_supplier_processor_id' uncontrolled in the current context of `a_client_processor_id'.
		local
			l_current_request_chain: detachable like new_request_chain_meta_data_entry
			l_end_index, i: INTEGER
		do
			l_current_request_chain := request_chain_meta_data [a_client_processor_id]
			if l_current_request_chain /= Void then
					-- Check first if we are lock passing, if not then we check the entire chain.
				Result := l_current_request_chain [request_chain_client_pid_index] /= a_supplier_processor_id
				if Result then
					l_end_index := l_current_request_chain [request_chain_pid_count_index]
					if l_end_index > 0 then
						from
							i := request_chain_meta_data_header_size
							l_end_index := l_end_index + i
						until
							i = l_end_index or else not Result
						loop
							Result := l_current_request_chain [i] /= a_supplier_processor_id
							i := i + 1
						end
					end
				end
			else
					-- There is no current chain, the supplier processor is uncontrolled if different from the client processor.
				Result := a_client_processor_id /= a_supplier_processor_id
			end
		end

	frozen assign_processor_task_id: NATURAL_8 = 1
	frozen free_processor_task_id: NATURAL_8 = 2
	frozen start_processor_loop_task_id: NATURAL_8 = 3
	frozen signify_start_of_new_chain_task_id: NATURAL_8 = 4
	frozen signify_end_of_new_chain_task_id: NATURAL_8 = 5
	frozen add_supplier_to_request_chain_task_id: NATURAL_8 = 6
	frozen wait_for_supplier_processor_locks_task_id: NATURAL_8 = 7
	frozen add_call_task_id: NATURAL_8 = 8
	frozen add_synchronous_call_task_id: NATURAL_8 = 9
	frozen wait_for_processor_redundancy_task_id: NATURAL_8 = 10
	frozen add_processor_reference_task_id: NATURAL_8 = 11
	frozen remove_processor_reference_task_id: NATURAL_8 = 12
	frozen check_uncontrolled_call_task_id: NATURAL_8 = 13
		-- SCOOP Task Constants, similies of those defined in <eif_macros.h>
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
			-- Find the next available free SCOOP Processor, reuse or instantiate as needs be.
		do
				--| FIXME Implement redundant processor traversal to return next available id
			Result := {ATOMIC_MEMORY_OPERATIONS}.increment_integer_32 ($processor_count) - 1

			if Result = max_scoop_processors_instantiable then
				-- Perform processor cleanup.
				-- Raise Exception if no free processor could not be found, or block until there is one.
				(create {EXCEPTIONS}).raise ("Maximum SCOOP Processor Allocation reached%N")
			end

			initialize_default_processor_meta_data (Result)

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
		do
			create_and_initialize_scoop_processor (Current, $scoop_processor_loop, default_processor_attributes.item, a_processor_id)
		end

	default_processor_attributes: ISE_SCOOP_PROCESSOR_ATTRIBUTES
			-- Default scoop processor thread attributes.
		once
			create Result.make_with_stack_size (1_048_576)
		end

	set_root_processor_has_exited
			-- Set `root_processor_has_exited' to True
		local
			l_temp: INTEGER_32
			l_wait_counter: NATURAL_32
		do
			--| FIXME Run through SCOOP Loop for root processor.
			--| For now as the root procedure has exited we can increase the idle count.
			l_temp := {ATOMIC_MEMORY_OPERATIONS}.increment_integer_32 ($idle_processor_count)

			from
					-- Wait for the SCOOP system to be in a static state, ie: all processors are in an idle state.
				l_wait_counter := 0
			until
				processor_count = idle_processor_count + waiting_processor_count
			loop
				processor_yield (root_processor_id, l_wait_counter)
				l_wait_counter := l_wait_counter + 1
			end

				-- Flag that root processor has finished logging so that the idle processors can finish.
			from
				root_processor_has_exited := True
				l_wait_counter := 0
			until
				idle_processor_count = 1
			loop
				processor_yield (root_processor_id, l_wait_counter)
				l_wait_counter := l_wait_counter + 1
			end

			if waiting_processor_count > 0 then
				(create {EXCEPTIONS}).raise ("SCOOP Processor Deadlock");
			else
					-- Wait for all threads to completely finish executing (disposal)
				root_processor_wait_for_redundancy
			end
		end

	root_processor_has_exited: BOOLEAN
		-- Has the root processor exited the creation routine of the root class?

feature -- Request Chain Handling

	signify_start_of_request_chain (a_client_processor_id: like processor_id_type)
			-- Signify the start of a new request chain on `a_client_processor_id'
		local
			l_request_chain_id: like invalid_request_chain_id
			l_request_chain_id_depth: like default_request_chain_depth_value
			l_request_chain_meta_data: detachable like new_processor_meta_data_entry
		do
			debug ("ISE_SCOOP_MANAGER")
				print ("signify_start_of_request_chain for pid " + a_client_processor_id.out + " %N")
			end

			l_request_chain_meta_data := request_chain_meta_data [a_client_processor_id]
			if l_request_chain_meta_data /= Void then
				if l_request_chain_meta_data [request_chain_client_pid_index] /= a_client_processor_id then
					l_request_chain_meta_data [request_chain_status_index] := request_chain_status_closed
				end
			end

			l_request_chain_meta_data := new_request_chain_meta_data_entry

				-- Reset node count to default values	
			l_request_chain_meta_data [request_chain_pid_count_index] := 0
			l_request_chain_meta_data [request_chain_client_pid_index] := a_client_processor_id
			l_request_chain_meta_data [request_chain_client_pid_request_chain_id_index] := invalid_request_chain_id
			l_request_chain_meta_data [request_chain_status_index] := request_chain_status_uninitialized
			l_request_chain_meta_data [request_chain_sync_counter_index] := 0

				-- Increase request chain id.
			l_request_chain_id := {ATOMIC_MEMORY_OPERATIONS}.increment_integer_32 (processor_meta_data [a_client_processor_id].item_address (current_request_chain_id_index));

				-- Increment current request chain id depth
			l_request_chain_id_depth := {ATOMIC_MEMORY_OPERATIONS}.increment_integer_32 (processor_meta_data [a_client_processor_id].item_address (current_request_chain_id_depth_index));

			(request_chain_meta_data_stack_list [a_client_processor_id]) [l_request_chain_id_depth] := l_request_chain_meta_data
			request_chain_meta_data [a_client_processor_id] := l_request_chain_meta_data;
		end

	signify_end_of_request_chain (a_client_processor_id: like processor_id_type)
			-- Signal the end of a request chain for `a_client_processor_id'.
		local
			l_request_chain_id_depth: like default_request_chain_depth_value
			l_request_chain_meta_data: detachable like new_request_chain_meta_data_entry
		do
				-- Retrieve existing meta data chain.
			l_request_chain_meta_data := request_chain_meta_data [a_client_processor_id]
			check l_request_chain_meta_data_entry_attached: attached l_request_chain_meta_data end

			--| Testing Code for synchronizing all processors when fully exiting a chain.
--			if l_request_chain_meta_data [request_chain_client_pid_index] = a_client_processor_id and then l_request_chain_meta_data [request_chain_status_index] = request_chain_status_application then
--					-- If we are the owner of the chain and the chain is currently being applied we sync up with the supplier processors.
--				synchronize_processors_upon_application (a_client_processor_id)
--			end
				-- Get current request chain depth
			l_request_chain_id_depth := (processor_meta_data [a_client_processor_id])[current_request_chain_id_depth_index]

				-- Decrease current request chain id depth
			l_request_chain_id_depth := l_request_chain_id_depth - 1
			(processor_meta_data [a_client_processor_id])[current_request_chain_id_depth_index] := l_request_chain_id_depth

			if l_request_chain_id_depth > default_request_chain_depth_value then
				request_chain_meta_data [a_client_processor_id] := (request_chain_meta_data_stack_list [a_client_processor_id]) [l_request_chain_id_depth]
			else
				request_chain_meta_data [a_client_processor_id] := Void
			end

				-- Remove previous request chain from stack
			(request_chain_meta_data_stack_list [a_client_processor_id]) [l_request_chain_id_depth + 1] := Void

			l_request_chain_meta_data [request_chain_status_index] := request_chain_status_closed

			debug ("ISE_SCOOP_MANAGER")
				print ("signify_end_of_request_chain for pid " + a_client_processor_id.out + "%N")
			end
		end

	signify_end_of_wait_condition_chain (a_client_processor_id: like processor_id_type)
			-- Signal the end of a failed wait_condition
		do
			signify_end_of_request_chain (a_client_processor_id)
				-- Pause the processor a small amount so that it can attempt to reacquire a request chain.
			processor_sleep (processor_sleep_quantum)
		end

	assign_supplier_processor_to_request_chain (a_client_processor_id, a_supplier_processor_id: like processor_id_type)
			-- Assign `a_supplier_processor_id' to the current request chain of `a_client_processor_id'
		local
			l_request_chain_id: like invalid_request_chain_id
			l_request_chain_meta_data: detachable like new_processor_meta_data_entry
			i, l_count: INTEGER
			l_pid_present: BOOLEAN
		do
			debug ("ISE_SCOOP_MANAGER")
				print ("assign_supplier_process_to_request_chain for pid " + a_client_processor_id.out + " with supplier processor " + a_supplier_processor_id.out + "%N")
			end

			l_request_chain_id := (processor_meta_data [a_client_processor_id])[current_request_chain_id_index]

				-- Retrieve request chain meta data structure, add supplier pid to it if not already present.
			l_request_chain_meta_data := request_chain_meta_data [a_client_processor_id]
			check l_request_chain_meta_data_attached: attached l_request_chain_meta_data end

			from
				i := request_chain_meta_data_header_size
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
					update_request_chain_meta_data (a_client_processor_id, l_request_chain_meta_data)
				end
					-- Add new pid to request chain list.
				l_request_chain_meta_data.extend (a_supplier_processor_id)
			end
		end

	update_request_chain_meta_data (a_client_processor_id: like processor_id_type; a_request_chain_meta_data: detachable like new_request_chain_meta_data_entry)
			-- Update request chain meta data for `a_client_processor_id'.
		local
			l_request_chain_depth: INTEGER
		do
			l_request_chain_depth := (processor_meta_data [a_client_processor_id]) [Current_request_chain_id_depth_index]
			(request_chain_meta_data_stack_list [a_client_processor_id]) [l_request_chain_depth] := a_request_chain_meta_data
			if request_chain_meta_data [a_client_processor_id] /= a_request_chain_meta_data then
				request_chain_meta_data [a_client_processor_id] := a_request_chain_meta_data
			end
		end

	wait_for_request_chain_supplier_processor_locks (a_client_processor_id: like processor_id_type)
			-- Wait until all locks for the supplier processors involved in the current request chain id of `a_client_processor_id' to become available.
		local
			l_request_chain_id: like invalid_request_chain_id
			l_request_chain_node_id: like invalid_request_chain_node_id
			l_request_chain_meta_data: detachable like new_request_chain_meta_data_entry
			l_request_chain_node_meta_data_queue: detachable like new_request_chain_node_meta_data_queue
			l_request_chain_node_queue: detachable like new_request_chain_node_queue
			l_request_chain_node_queue_entry: detachable like new_request_chain_node_queue_entry
			l_sorted, l_swap_occurred: BOOLEAN
			i, l_container_count, l_unique_pid_count: INTEGER
			l_pid: like processor_id_type
			l_lock_request_return: NATURAL_8
		do
			-- Sort unique processor id's by order of priority, then wait for locks on each processor so that a new request chain node can be initialized.
			debug ("ISE_SCOOP_MANAGER")
				print ("wait_for_request_chain_supplier_processor_locks for pid " + a_client_processor_id.out + "%N")
			end

				-- Retrieve request chain meta data structure.
			l_request_chain_meta_data := request_chain_meta_data [a_client_processor_id]
			check l_request_chain_meta_data_attached: attached l_request_chain_meta_data end

						-- Retrieve request chain meta data structure
				-- Sort unique pid values by logical order
			l_request_chain_id := (processor_meta_data [a_client_processor_id])[current_request_chain_id_index]

			from
					-- Start at first PID value, with zero based SPECIAL this equals the header size.
				i := request_chain_meta_data_header_size
					-- At this stage the number of unique pid's in structure is count - header size.
				l_unique_pid_count := l_request_chain_meta_data.count - request_chain_meta_data_header_size
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
						i := request_chain_meta_data_header_size
					else
						l_sorted := True
					end
				else
					i := i + 1
				end
			end

				-- Reformulate meta data structure with unique pid count as the first value followed by the unique sorted pid values
			l_request_chain_meta_data [request_chain_pid_count_index] := l_unique_pid_count
			l_request_chain_meta_data [request_chain_client_pid_index] := a_client_processor_id
			l_request_chain_meta_data [request_chain_client_pid_request_chain_id_index] := l_request_chain_id
			l_request_chain_meta_data [request_chain_status_index] := request_chain_status_uninitialized
			l_request_chain_meta_data [request_chain_sync_counter_index] := l_unique_pid_count

				-- Resize meta data to allow for supplier processor meta data.
			if (l_container_count + l_unique_pid_count) > l_request_chain_meta_data.capacity  then
				l_request_chain_meta_data := l_request_chain_meta_data.aliased_resized_area (l_container_count + l_unique_pid_count)
				update_request_chain_meta_data (a_client_processor_id, l_request_chain_meta_data)
			end

				-- Obtain a request queue lock on each of the processors (already uniquely sorted by logical pid order)
			from
				i := request_chain_meta_data_header_size
			until
				i = l_container_count
			loop
					-- Obtain lock on request chain node id value to prevent other processors from accessing it
					-- This has to be done atomically via compare and swap
				l_pid := l_request_chain_meta_data [i]
				l_lock_request_return := request_processor_resource (
					current_request_chain_node_id_lock_index,
					l_pid,
					a_client_processor_id,
					True, -- Wait until granted, we cannot continue until we have control over the value.
					True  -- Low Priority, wait is minimal as this is a temporary lock value
				)
				check resource_attained: l_lock_request_return = resource_lock_newly_attained end

				i := i + 1
			end

			-- When all locks have been obtained we retrieve the request chain node ids for each of the locked processors.
			-- When retrieved we initialize the data structure for each supplier pid so that we can then log calls.


			from
				i := request_chain_meta_data_header_size
			until
				i = l_container_count
			loop
					-- Add the current supplier processor request chain node id
				l_pid := l_request_chain_meta_data [i]

					-- We atomically increase for the next use and set the current request chain node id value.
				l_request_chain_node_id := (processor_meta_data [l_pid]) [current_request_chain_node_id_index]

				if l_request_chain_node_id = max_request_chain_node_queue_index then
						-- We are at the maximum amount of allocations so we wait for the processor to reset its request chain node counter.
					from
						-- We can wait until the processor's application counter has caught up to the logging counter so that everything may be reset.
					until
						l_request_chain_node_id < max_request_chain_node_queue_index
					loop
						processor_yield (a_client_processor_id, 0)
						l_request_chain_node_id := {ATOMIC_MEMORY_OPERATIONS}.add_integer_32 (processor_meta_data [l_pid].item_address (current_request_chain_node_id_index), 0)
					end
					-- Processor `a_client_processor_id' has to wait for `l_pid' to reset its application queue.
					--| FIXME: We may have to force iteration of application loop to allow for reset.
				end

					-- Extend value to request chain node meta data.
				l_request_chain_meta_data.extend (l_request_chain_node_id)

				l_request_chain_node_id := {ATOMIC_MEMORY_OPERATIONS}.increment_integer_32 (processor_meta_data [l_pid].item_address (current_request_chain_node_id_index))
				i := i + 1
			end

				-- Release locks when request chain nodes ids have been calculated.
			from
				i := request_chain_meta_data_header_size
			until
				i = l_container_count
			loop
					-- Release lock on processor request chain node id
					-- This has to be done atomically via compare and swap
				l_pid := l_request_chain_meta_data [i]

				relinquish_processor_resource (
					processor_meta_data [l_pid].item_address (current_request_chain_node_id_lock_index),
					a_client_processor_id,
					True  -- High Priority
				)

				i := i + 1
			end

			from
				i := request_chain_meta_data_header_size
			until
				i = l_container_count
			loop
				l_pid := l_request_chain_meta_data [i]
				l_request_chain_node_id := l_request_chain_meta_data [i + l_unique_pid_count]

					-- Set meta data for the request node of `l_pid'
					-- This is used for both `head' and `tail' request chain nodes.
				l_request_chain_node_meta_data_queue := request_chain_node_meta_data_queue_list [l_pid]
				check l_request_chain_node_meta_data_queue_attached: attached l_request_chain_node_meta_data_queue end
				l_request_chain_node_meta_data_queue [l_request_chain_node_id] := l_request_chain_meta_data

					-- Set request chain node queue entry for `l_pid' for future logging.
				l_request_chain_node_queue := request_chain_node_queue_list [l_pid]
				check l_request_chain_node_queue_attached: attached l_request_chain_node_queue end
				l_request_chain_node_queue_entry := l_request_chain_node_queue [l_request_chain_node_id]
				if not attached l_request_chain_node_queue_entry then
					l_request_chain_node_queue_entry := new_request_chain_node_queue_entry
					l_request_chain_node_queue [l_request_chain_node_id] := l_request_chain_node_queue_entry
				else
						-- Make sure request chain node structure is empty.
					l_request_chain_node_queue_entry.wipe_out
				end
				i := i + 1
			end

				-- Set chain as open so that the processors may enter the chain
			l_request_chain_meta_data [request_chain_status_index] := request_chain_status_open
		end

feature -- Command/Query Handling

	frozen call_data_result (a_call_data: like call_data): POINTER
		require
			a_call_data_valid: a_call_data /= default_pointer
		external
			"C inline use %"eif_scoop.h%""
		alias
			"((call_data*) $a_call_data)->result"
		end

	frozen call_data_count (a_call_data: like call_data): NATURAL_32
		require
			a_call_data_valid: a_call_data /= default_pointer
		external
			"C inline use %"eif_scoop.h%""
		alias
			"((call_data*) $a_call_data)->count"
		end

	frozen call_data_body_index (a_call_data: like call_data): INTEGER_32
		require
			a_call_data_valid: a_call_data /= default_pointer
		external
			"C inline use %"eif_scoop.h%""
		alias
			"((call_data*) $a_call_data)->body_index"
		end

	frozen call_data_sync_pid (a_call_data: like call_data): INTEGER_16
		require
			a_call_data_valid: a_call_data /= default_pointer
		external
			"C inline use %"eif_scoop.h%""
		alias
			"((call_data*) $a_call_data)->sync_pid"
		end

	frozen call_data_is_lock_passing (a_call_data: like call_data): BOOLEAN
		require
			a_call_data_valid: a_call_data /= default_pointer
		external
			"C inline use %"eif_scoop.h%""
		alias
			"((call_data*) $a_call_data)->is_lock_passing"
		end

	frozen call_data_target (a_call_data: like call_data): POINTER
		require
			a_call_data_valid: a_call_data /= default_pointer
		external
			"C inline use %"eif_scoop.h%""
		alias
			"((call_data*) $a_call_data)->target"
		end

	frozen call_data_argument (a_call_data: like call_data; i_th: NATURAL_32): POINTER
		require
			a_call_data_valid: a_call_data /= default_pointer
		external
			"C inline use %"eif_scoop.h%""
		alias
			"&((call_data*) $a_call_data)->argument [$i_th]"
		end

	log_call_on_processor (a_client_processor_id, a_supplier_processor_id: like processor_id_type; a_routine: like routine_type; a_call_data: like call_data)
			-- Log call on `a_suppler_processor_id' for `a_client_processor_id'
		local
			l_request_chain_meta_data, l_client_request_chain_meta_data, l_creation_request_chain_meta_data: detachable like new_request_chain_meta_data_entry
			l_request_chain_node_id: like invalid_request_chain_node_id
			l_request_chain_node_queue: detachable like new_request_chain_node_queue
			l_client_request_chain_node_queue_entry, l_request_chain_node_queue_entry: detachable like new_request_chain_node_queue_entry
			l_request_chain_node_meta_data_queue: detachable like new_request_chain_node_meta_data_queue
			l_unique_pid_count, i, l_last_pid_index, l_logged_calls_count: INTEGER_32
			l_is_synchronous, l_is_lock_passing, l_client_is_sibling, l_client_sync_needed, l_exit_loop: BOOLEAN
			l_call_ptr, l_default_ptr: POINTER
		do
			debug ("ISE_SCOOP_MANAGER")
				print ("log_call_on_processor for pid " + a_client_processor_id.out + " on pid " + a_supplier_processor_id.out + "%N")
			end

				-- Retrieve request chain node list so the call can be logged
			l_request_chain_node_queue := request_chain_node_queue_list [a_supplier_processor_id]
			check l_request_chain_node_queue_attached: attached l_request_chain_node_queue end

			l_is_lock_passing := call_data_is_lock_passing (a_call_data)
			l_is_synchronous := call_data_sync_pid (a_call_data) /= null_processor_id

				-- Initially mark the request chain node as invalid if not a creation routine
			if (processor_meta_data [a_supplier_processor_id])[current_request_chain_id_index] = 0 then
				l_request_chain_node_id := 0
			else
				l_request_chain_node_id := invalid_request_chain_node_id
			end

			l_client_request_chain_meta_data := request_chain_meta_data [a_client_processor_id]
			if l_client_request_chain_meta_data /= Void then
					-- Call is specific to `a_client_processor_id' so we need to retrieve the request chain node for `a_supplier_processor_id' from here.
				l_unique_pid_count := l_client_request_chain_meta_data [request_chain_pid_count_index]
					-- Search through remaining pid's to find the associating request chain node id.
				from
					i := request_chain_meta_data_header_size
					l_last_pid_index := request_chain_meta_data_header_size + l_unique_pid_count - 1
				until
					i > l_last_pid_index
				loop
					if l_client_request_chain_meta_data [i] = a_supplier_processor_id then
						l_request_chain_node_id := l_client_request_chain_meta_data [i + l_unique_pid_count]
					elseif l_client_request_chain_meta_data [i] = a_client_processor_id then
						l_client_is_sibling := True
					end
					i := i + 1
				end
			end

			if l_request_chain_node_id = invalid_request_chain_id then
					-- We are logging either via lock passing or a sibling processor is asynchronously logging on another sibling processor.
				l_client_sync_needed := l_is_synchronous
				l_request_chain_node_id := (processor_meta_data [a_supplier_processor_id])[current_request_node_id_execution_index]
				l_request_chain_node_queue_entry := l_request_chain_node_queue [l_request_chain_node_id]
			else
				l_request_chain_node_queue_entry := l_request_chain_node_queue [l_request_chain_node_id]
			end

			if l_request_chain_node_queue_entry = Void then
					-- We already have the locks so we may not have created the node queue yet.
				l_request_chain_node_queue_entry := new_request_chain_node_queue_entry
				l_request_chain_node_queue [l_request_chain_node_id] := l_request_chain_node_queue_entry
			end

			l_logged_calls_count := l_request_chain_node_queue_entry.count
			if l_logged_calls_count = l_request_chain_node_queue_entry.capacity then
					-- Resize node structure if there is not enough room for the new entry
					--| FIXME IEK: Resizing 3 extra items may not be optimal in all cases
				if l_client_request_chain_meta_data /= Void and then
					{ATOMIC_MEMORY_OPERATIONS}.add_integer_32 (l_client_request_chain_meta_data.item_address (request_chain_status_index), 0) = request_chain_status_open
				then
						-- We can reuse the data structure if the chain is still open.
					l_request_chain_node_queue_entry := l_request_chain_node_queue_entry.aliased_resized_area (l_request_chain_node_queue_entry.count + 3)
				else
					l_request_chain_node_queue_entry := l_request_chain_node_queue_entry.resized_area (l_request_chain_node_queue_entry.count + 3)
				end
				l_request_chain_node_queue [l_request_chain_node_id] := l_request_chain_node_queue_entry
					-- Readd in case we have a new structure.
			end

			if l_request_chain_node_id = 0 then

				l_creation_request_chain_meta_data := new_request_chain_meta_data_entry
					-- Set request chain meta data for creation routine.
				l_creation_request_chain_meta_data [request_chain_client_pid_index] := a_client_processor_id -- Processor initializing the creation.
				l_creation_request_chain_meta_data [request_chain_pid_count_index] := 1 -- Number of processors involved in chain (a_processor_id)
				l_creation_request_chain_meta_data [request_chain_client_pid_request_chain_id_index] := 0 -- current request chain id
				l_creation_request_chain_meta_data [request_chain_sync_counter_index] := 1 -- One value in the sync chain.
				l_creation_request_chain_meta_data [request_chain_status_index] := request_chain_status_open

				l_creation_request_chain_meta_data.extend (a_supplier_processor_id) -- Set the head pid as the one in the chain.
				l_creation_request_chain_meta_data.extend (l_request_chain_node_id)

				l_request_chain_node_meta_data_queue := request_chain_node_meta_data_queue_list [a_supplier_processor_id]
				check l_request_chain_node_meta_data_queue_attached: attached l_request_chain_node_meta_data_queue end
				l_request_chain_node_meta_data_queue [l_request_chain_node_id] := l_creation_request_chain_meta_data;

					-- Increase request chain and request chain node id to simulate normal logging procedure
				(processor_meta_data [a_supplier_processor_id]) [current_request_chain_id_index] := 1
				(processor_meta_data [a_supplier_processor_id]) [current_request_chain_node_id_index] := 1
			end

			if l_is_lock_passing then
					-- Retrieve the node queue list for the client processor.
				l_request_chain_node_queue := request_chain_node_queue_list [a_client_processor_id]
				check l_request_chain_node_queue_attached: attached l_request_chain_node_queue end

				l_client_request_chain_meta_data := request_chain_meta_data [a_client_processor_id]
				check l_client_request_chain_meta_data_attached: attached l_client_request_chain_meta_data end

				from
					l_client_request_chain_node_queue_entry := l_request_chain_node_queue [(processor_meta_data [a_client_processor_id])[current_request_node_id_execution_index]]
					check l_client_request_chain_node_queue_entry_attached: l_client_request_chain_node_queue_entry /= Void end

						-- Wait until the request chain has started.
					wait_for_request_chain_to_begin (a_client_processor_id, a_supplier_processor_id, l_client_request_chain_meta_data)
						-- We make a copy of the current request chain meta data and pass to the supplier for controlled argument processing.

						-- Pass the locks of the current processor.
					l_request_chain_meta_data := l_client_request_chain_meta_data
					request_chain_meta_data [a_supplier_processor_id] := l_request_chain_meta_data;

						-- Store current logged call count to see if any feature application requests are made by the call.
					l_logged_calls_count := l_client_request_chain_node_queue_entry.count;

					l_request_chain_node_queue_entry.extend (a_call_data)

					if l_creation_request_chain_meta_data /= Void then
							-- We are lock passing to a creation routine so we start the loop.
						start_processor_application_loop (a_supplier_processor_id)
						wait_for_request_chain_to_begin (a_client_processor_id, a_supplier_processor_id, l_creation_request_chain_meta_data)
					end
						-- Wait for client processor to be signalled to continue.
					processor_semaphore_wait (a_client_processor_id)

				until
					l_exit_loop
				loop
						-- We need to set the queue entry each time in case it has resized.
					l_client_request_chain_node_queue_entry := l_request_chain_node_queue [(processor_meta_data [a_client_processor_id])[current_request_node_id_execution_index]]
					check l_client_request_chain_node_queue_entry_attached: l_client_request_chain_node_queue_entry /= Void end
					if
						l_client_request_chain_node_queue_entry.count > l_logged_calls_count
					then
							-- The supplier processor has logged a call on the client processor so we must service it.
						l_call_ptr := l_client_request_chain_node_queue_entry [l_logged_calls_count]

							-- Reset call ptr from list before call in case list resizes
						l_client_request_chain_node_queue_entry [l_logged_calls_count] := l_default_ptr
						l_client_request_chain_node_queue_entry.keep_head (l_logged_calls_count)
							-- We must service all requests until the routine has closed its chain.

						l_is_synchronous := call_data_sync_pid (l_call_ptr) /= null_processor_id
						scoop_command_call (l_call_ptr)
						if l_is_synchronous then
							processor_semaphore_signal (a_supplier_processor_id)
						end
						processor_semaphore_wait (a_client_processor_id)
						scoop_command_call_cleanup (l_call_ptr)
						l_call_ptr := default_pointer
					else
						if l_creation_request_chain_meta_data /= Void then
								-- Here we wait for the creation routine to finish.
							l_creation_request_chain_meta_data [request_chain_status_index] := request_chain_status_waiting
							processor_semaphore_wait (a_client_processor_id)
							l_creation_request_chain_meta_data [request_chain_status_index] := request_chain_status_closed
							processor_semaphore_signal (a_supplier_processor_id)
						end
						l_exit_loop := True
					end
				end
			else
				if l_client_sync_needed then
						-- We must be a synchronous call so we need to sync up with the supplier processor.
					l_request_chain_node_queue_entry.extend (a_call_data)
					processor_semaphore_signal (a_supplier_processor_id)
					processor_semaphore_wait (a_client_processor_id)
				elseif l_is_synchronous then
					if a_supplier_processor_id = root_processor_id then
						scoop_command_call (a_call_data)
						scoop_command_call_cleanup (a_call_data)
					else
						l_request_chain_node_queue_entry.extend (a_call_data)
						i := {ATOMIC_MEMORY_OPERATIONS}.increment_integer_32 ($waiting_processor_count)
						processor_semaphore_wait (a_client_processor_id)
						i := {ATOMIC_MEMORY_OPERATIONS}.decrement_integer_32 ($waiting_processor_count)
					end
				else
						-- Asynchronous logging
					l_request_chain_node_queue_entry.extend (a_call_data)
					if l_creation_request_chain_meta_data /= Void then
							-- We are logging an asynchronous creation routine.
						start_processor_application_loop (a_supplier_processor_id)
						wait_for_request_chain_to_begin (a_client_processor_id, a_supplier_processor_id, l_creation_request_chain_meta_data)
						l_creation_request_chain_meta_data [request_chain_status_index] := request_chain_status_waiting
						processor_semaphore_wait (a_client_processor_id)
						l_creation_request_chain_meta_data [request_chain_status_index] := request_chain_status_closed
						processor_semaphore_signal (a_supplier_processor_id)
					end
				end
			end
		end

	wait_for_request_chain_to_begin (a_client_processor_id, a_supplier_processor_id: like processor_id_type; a_request_chain_meta_data: like new_request_chain_meta_data_entry)
			-- Wait for the request chain represented by `a_request_chain_meta_data' to begin.
		local
			l_counter: NATURAL_32
			l_chain_status: INTEGER_32
		do
				-- Spin lock before resorting to the semaphore
			l_chain_status := {ATOMIC_MEMORY_OPERATIONS}.add_integer_32 (a_request_chain_meta_data.item_address (Request_chain_status_index), 0)
			from
				l_counter := 0
			until
				l_chain_status > request_chain_status_open or else l_counter = 100
			loop
				processor_yield (a_client_processor_id, l_counter)
				l_counter := l_counter + 1
				l_chain_status := {ATOMIC_MEMORY_OPERATIONS}.add_integer_32 (a_request_chain_meta_data.item_address (Request_chain_status_index), 0)
			end

			if l_chain_status <= request_chain_status_open then
				if a_client_processor_id = a_request_chain_meta_data [request_chain_client_pid_index] then
						-- `a_client_processor_id' is the owner of the chain so we can wait in a semaphore if the chain is not already being applied.
					l_chain_status := {ATOMIC_MEMORY_OPERATIONS}.compare_and_swap_integer_32 (
						a_request_chain_meta_data.item_address (Request_chain_status_index),
						Request_chain_status_application,
						Request_chain_status_open
					)
					if l_chain_status = request_chain_status_open then
							-- The chain is not yet being applied, wait for the head node to signal the processor to continue.

							-- Chain status is now set to application so we update the flag so we don't needlessly enter the spin lock loop.
						l_chain_status := request_chain_status_application
						processor_semaphore_wait (a_client_processor_id)
					end
				end

				from
					l_counter := 0
				until
					l_chain_status > request_chain_status_open
				loop
					processor_yield (a_client_processor_id, l_counter)
					l_counter := l_counter + 1
					l_chain_status := {ATOMIC_MEMORY_OPERATIONS}.add_integer_32 (a_request_chain_meta_data.item_address (Request_chain_status_index), 0)
				end
			end
		end

feature {NONE} -- Resource Initialization

	init_scoop_manager
			-- Initialize processor meta data.
		local
			i: INTEGER_32
			l_processor_meta_data: like processor_meta_data
			l_request_chain_meta_data_stack_list: like request_chain_meta_data_stack_list
			l_request_chain_meta_data: detachable like new_request_chain_meta_data_entry
		do
			logical_cpu_count := available_cpus

			from
				i := 1
				create l_processor_meta_data.make_empty (max_scoop_processors_instantiable)
				create request_chain_meta_data.make_filled (Void, max_scoop_processors_instantiable)
				create l_request_chain_meta_data_stack_list.make_empty (max_scoop_processors_instantiable)
			until
				i > Max_scoop_processors_instantiable
			loop
				l_request_chain_meta_data_stack_list.extend (new_request_chain_meta_data_stack_list_entry)
				l_processor_meta_data.extend (new_processor_meta_data_entry)
					-- FIXME IEK Free semaphore list when application exits
				i := i + 1
			end
			processor_meta_data := l_processor_meta_data
			request_chain_meta_data_stack_list := l_request_chain_meta_data_stack_list


				-- Create request chain node meta data queue pigeon hole for each potential processor.
			create request_chain_node_meta_data_queue_list.make_filled (Void, max_scoop_processors_instantiable)

				-- Create request chain node queue pigeon for each potential processor.
			create request_chain_node_queue_list.make_filled (Void, max_scoop_processors_instantiable)

				-- Create processor semaphore list for use during processor meta data creation.
			create processor_semaphore_list.make_filled (default_pointer, max_scoop_processors_instantiable)

				-- Set up root processor and initial chain meta data.
			root_processor_id := assign_free_processor_id
			signify_start_of_request_chain (root_processor_id)
			assign_supplier_processor_to_request_chain (root_processor_id, root_processor_id)
			wait_for_request_chain_supplier_processor_locks (root_processor_id)
			l_request_chain_meta_data := request_chain_meta_data [root_processor_id]
			check l_request_chain_meta_data_attached: attached l_request_chain_meta_data end
			l_request_chain_meta_data [request_chain_status_index] := request_chain_status_application
		end

	initialize_default_processor_meta_data (a_processor_id: like processor_id_type)
			-- Initialize processor `a_processor_id' meta data to default values after a creation routine has been logged.
		local
			l_request_chain_node_meta_data_queue: detachable like new_request_chain_node_meta_data_queue
			l_request_chain_node_queue: detachable like new_request_chain_node_queue
		do
				-- Initialize request chain node meta data queue
			l_request_chain_node_meta_data_queue := request_chain_node_meta_data_queue_list [a_processor_id]
			if not attached l_request_chain_node_meta_data_queue then
				l_request_chain_node_meta_data_queue := new_request_chain_node_meta_data_queue
				request_chain_node_meta_data_queue_list [a_processor_id] := l_request_chain_node_meta_data_queue
			else
				l_request_chain_node_meta_data_queue.fill_with_default (0, Max_request_chain_node_queue_index)
			end

				-- Initialize request chain node queue
			l_request_chain_node_queue := request_chain_node_queue_list [a_processor_id]
			if not attached l_request_chain_node_queue then
				l_request_chain_node_queue := new_request_chain_node_queue
				request_chain_node_queue_list [a_processor_id] := l_request_chain_node_queue
			else
				l_request_chain_node_queue.fill_with_default (0, Max_request_chain_node_queue_index)
			end

				-- Initialize processor semaphore with a count of zero for client - supplier processor notification.

				-- FIXME IEK Destroy processor semaphore when resources are freed.
			processor_semaphore_list [a_processor_id] := new_semaphore (0)

			(processor_meta_data [a_processor_id]).put (0, current_request_chain_id_index)
			(processor_meta_data [a_processor_id]).put (0, current_request_chain_node_id_index)

				-- Reset execution index to `0'
			(processor_meta_data [a_processor_id]).put (0, current_request_node_id_execution_index)

				-- Mark processor as initialized.
			(processor_meta_data [a_processor_id]).put (processor_status_initialized, processor_status_index)
		end

	scoop_processor_loop (a_logical_processor_id: like processor_id_type)
			-- Entry point for all scoop processors, each unique identified by `a_logical_processor_id'.
		local
			l_processor_exit, l_feature_application_loop_exit: BOOLEAN
			l_processor_meta_data: like new_processor_meta_data_entry
			l_executing_node_id: like invalid_request_chain_node_id
			l_executing_node_id_cursor: INTEGER_32
			l_request_chain_node_queue: detachable like new_request_chain_node_queue
			l_executing_request_chain_node: detachable like new_request_chain_node_queue_entry
			l_request_chain_node_meta_data_queue: detachable like new_request_chain_node_meta_data_queue
			l_executing_request_chain_node_meta_data: detachable like new_request_chain_node_meta_data_queue_entry
			l_head_pid, l_sync_pid: like processor_id_type
			l_is_head: BOOLEAN
			l_orig_sync_count, l_temp_count: INTEGER
			l_wait_counter: NATURAL_32
			l_call_ptr, l_default_ptr: POINTER
		do
			-- SCOOP Processor has been launched
			-- We are guaranteed that at least a creation routine has been logged.

			from
				l_processor_meta_data := processor_meta_data [a_logical_processor_id]
				l_request_chain_node_queue := request_chain_node_queue_list [a_logical_processor_id]
				check l_request_chain_node_queue_attached: attached l_request_chain_node_queue end
				l_request_chain_node_meta_data_queue := request_chain_node_meta_data_queue_list [a_logical_processor_id]
				check l_request_chain_node_meta_data_queue_attached: attached l_request_chain_node_meta_data_queue end
			until
				l_processor_exit
			loop
					--| This is needed so that any pending gc cycles are correctly handled
					--| as this is a tight loop without any call to RTGC
				check_for_gc

				if l_processor_meta_data [processor_status_index] = processor_status_initialized then
						-- SCOOP processor is initialized so we can check current index

						-- Retrieve execution index
					l_executing_node_id := l_processor_meta_data [current_request_node_id_execution_index]

					l_executing_request_chain_node_meta_data := l_request_chain_node_meta_data_queue [l_executing_node_id]
					if
						l_executing_request_chain_node_meta_data /= Void and then l_executing_request_chain_node_meta_data [request_chain_status_index] /= request_chain_status_uninitialized
							-- We only allow feature application to occur when the chain is correctly set.
					then
							-- We are in a valid feature application position as the request chain has been initialized.
						from
							l_head_pid := l_executing_request_chain_node_meta_data [request_chain_meta_data_header_size]
							l_is_head := l_head_pid = a_logical_processor_id

							if l_is_head then
								l_orig_sync_count := {ATOMIC_MEMORY_OPERATIONS}.add_integer_32 (l_executing_request_chain_node_meta_data.item_address (request_chain_sync_counter_index), 0)
									-- We are a head node, set sync count to minus original sync count
								if l_orig_sync_count > 1 then
										-- We only need synchronization if there are tail nodes involved.

										-- Increment waiting processor count.
									l_temp_count := {ATOMIC_MEMORY_OPERATIONS}.increment_integer_32 ($waiting_processor_count)

									from
										l_temp_count := {ATOMIC_MEMORY_OPERATIONS}.swap_integer_32 (l_executing_request_chain_node_meta_data.item_address (request_chain_sync_counter_index), -l_orig_sync_count)
										l_wait_counter := 0
									until
										l_temp_count = -1
									loop
										processor_yield (a_logical_processor_id, l_wait_counter)
										l_temp_count := {ATOMIC_MEMORY_OPERATIONS}.add_integer_32 (l_executing_request_chain_node_meta_data.item_address (request_chain_sync_counter_index), 0)
										l_wait_counter := l_wait_counter + 1
									end

										-- Decrement waiting processor count.
									l_temp_count := {ATOMIC_MEMORY_OPERATIONS}.decrement_integer_32 ($waiting_processor_count)

										-- Set to zero, increment by 1 (atomic swap with 1 as shortcut)
										-- Wait until sync counter is original value, this signifies that all tail nodes are now executing
									from
										l_temp_count := {ATOMIC_MEMORY_OPERATIONS}.increment_integer_32 (l_executing_request_chain_node_meta_data.item_address (request_chain_sync_counter_index))
										l_temp_count := {ATOMIC_MEMORY_OPERATIONS}.increment_integer_32 (l_executing_request_chain_node_meta_data.item_address (request_chain_sync_counter_index))
										l_wait_counter := 0
									until
										l_temp_count = l_orig_sync_count
									loop
										processor_yield (a_logical_processor_id, l_wait_counter)
										l_temp_count := {ATOMIC_MEMORY_OPERATIONS}.add_integer_32 (l_executing_request_chain_node_meta_data.item_address (request_chain_sync_counter_index), 0)
										l_wait_counter := l_wait_counter + 1
									end
								end
									-- Tail nodes are all synchronized and executing so head node can continue.	

									-- Signify that the chains are now being applied (if not already closed)
									-- This is used by the client to make sure that all chains have been started before attempting any wait calls.
								l_temp_count := {ATOMIC_MEMORY_OPERATIONS}.compare_and_swap_integer_32 (
									l_executing_request_chain_node_meta_data.item_address (request_chain_status_index), request_chain_status_application, request_chain_status_open
								)

								if l_temp_count = request_chain_status_open then
										-- The client processor is not currently waiting for this chain.
								else
									if l_temp_count = request_chain_status_application then
											-- The client processor is waiting to be synced.
										processor_semaphore_signal (l_executing_request_chain_node_meta_data [request_chain_client_pid_index])
									else
										check request_chain_status_closed: l_temp_count = request_chain_status_closed end
									end
								end
							else
									-- We are a tail node, we wait for head node to set pid count to negative value. (as we are a tail node then there must be at least two processors involved)
								from
									l_temp_count := {ATOMIC_MEMORY_OPERATIONS}.add_integer_32 (l_executing_request_chain_node_meta_data.item_address (request_chain_sync_counter_index), 0)
									l_wait_counter := 0
								until
									l_temp_count < -1
								loop
									processor_yield (a_logical_processor_id, l_wait_counter)
									l_temp_count := {ATOMIC_MEMORY_OPERATIONS}.add_integer_32 (l_executing_request_chain_node_meta_data.item_address (request_chain_sync_counter_index), 0)
									l_wait_counter := l_wait_counter + 1
								end
								l_temp_count := {ATOMIC_MEMORY_OPERATIONS}.increment_integer_32 (l_executing_request_chain_node_meta_data.item_address (request_chain_sync_counter_index))

								from
									l_wait_counter := 0
								until
									l_temp_count >= 1
								loop
									processor_yield (a_logical_processor_id, l_wait_counter)
									l_temp_count := {ATOMIC_MEMORY_OPERATIONS}.add_integer_32 (l_executing_request_chain_node_meta_data.item_address (request_chain_sync_counter_index), 0)
									l_wait_counter := l_wait_counter + 1
								end
								l_temp_count := {ATOMIC_MEMORY_OPERATIONS}.increment_integer_32 (l_executing_request_chain_node_meta_data.item_address (request_chain_sync_counter_index))
							end

							l_executing_node_id_cursor := 0
							l_wait_counter := 0
							l_feature_application_loop_exit := False
						until
							l_feature_application_loop_exit
						loop
							l_executing_request_chain_node := l_request_chain_node_queue [l_executing_node_id]
							check l_executing_request_chain_node_attached: attached l_executing_request_chain_node end
							if l_executing_node_id_cursor < l_executing_request_chain_node.count then
								l_call_ptr := l_executing_request_chain_node [l_executing_node_id_cursor]
								if l_call_ptr /= l_default_ptr then
									l_sync_pid := call_data_sync_pid (l_call_ptr)
									scoop_command_call (l_call_ptr)
									if l_sync_pid /= null_processor_id then
										processor_semaphore_signal (l_sync_pid)
									end
									l_executing_node_id_cursor := l_executing_node_id_cursor + 1
								end
							elseif l_executing_request_chain_node_meta_data [request_chain_status_index] = request_chain_status_closed then
									-- Request chain has been fully closed therefore we can exit if all calls have been applied.
								if l_executing_node_id_cursor >= l_executing_request_chain_node.count then
									l_feature_application_loop_exit := True
									l_request_chain_node_meta_data_queue [l_executing_node_id] := Void
								end
							elseif l_executing_request_chain_node_meta_data [request_chain_status_index] = request_chain_status_waiting then
								processor_semaphore_signal (l_executing_request_chain_node_meta_data [request_chain_client_pid_index])
								processor_semaphore_wait (a_logical_processor_id)
							else
									-- We are in an idle state, waiting for the request chain to close or to have more calls logged so we yield to another thread.
								processor_yield (a_logical_processor_id, l_wait_counter)
								l_wait_counter := l_wait_counter + 1
							end
						end

							-- Clean up call data, this can only be performed when the chain is closed as logging calls may resize the request chain node queue
							-- structure while it is being manipulated, which would break the post-condition of resize.				
						from
							l_executing_request_chain_node := l_request_chain_node_queue [l_executing_node_id]
							check l_executing_request_chain_node_attached: attached l_executing_request_chain_node end
							l_executing_node_id_cursor := 0
						until
							l_executing_node_id_cursor = l_executing_request_chain_node.count
						loop
							scoop_command_call_cleanup (l_executing_request_chain_node [l_executing_node_id_cursor])
							l_executing_node_id_cursor := l_executing_node_id_cursor + 1
						end
							-- Reset execution cursor.
						l_executing_node_id_cursor := 0

							-- Increment execution cursor by one.
						l_executing_node_id := l_executing_node_id + 1
						if l_executing_node_id >= max_request_chain_node_queue_index then
								-- We have reached the maximum indexes so we can reset both so that logging can resume.
							l_processor_meta_data [current_request_node_id_execution_index] := 1
							l_temp_count := {ATOMIC_MEMORY_OPERATIONS}.swap_integer_32 (l_processor_meta_data.item_address (current_request_chain_node_id_index), 1)
							l_executing_node_id := 1
						else
							l_processor_meta_data [current_request_node_id_execution_index] := l_executing_node_id
						end
					else
							-- There are no request chains to be applied so processor is idle until more are added.
						l_temp_count := {ATOMIC_MEMORY_OPERATIONS}.increment_integer_32 ($idle_processor_count)

						from
							l_wait_counter := 0
						until
							l_request_chain_node_meta_data_queue [l_processor_meta_data [Current_request_node_id_execution_index]] /= Void or else l_processor_exit
						loop
							if root_processor_has_exited then
									-- Processor now has to exit so we decrease the number of available SCOOP processors.
								l_temp_count := {ATOMIC_MEMORY_OPERATIONS}.decrement_integer_32 ($processor_count)
								l_processor_exit := True
							else
								processor_is_idle (a_logical_processor_id, l_wait_counter)
								l_wait_counter := l_wait_counter + 1
							end
						end
								-- Processor is no longer idle so we decrease the idle processor count.
						l_temp_count := {ATOMIC_MEMORY_OPERATIONS}.decrement_integer_32 ($idle_processor_count)
					end
				elseif l_processor_meta_data [processor_status_index] = processor_status_uninitialized then
						-- Processor is uninitialized so we yield control to OS for the time being.
					processor_yield (a_logical_processor_id, 0)
				else
					check invalid_processor_status: False end
				end
			end
		end

	processor_is_idle (a_client_processor_id: like processor_id_type; a_wait_counter: NATURAL_32)
			-- Processor `a_client_processor_id' is idle.
		do
			processor_yield (a_client_processor_id, a_wait_counter)
		end

	scoop_command_call (data: like call_data)
			-- Make scoop call from call data `data'.
		require
			data_not_null: data /= default_pointer
		external
			"C inline use <eif_scoop.h>"
		alias
			"[
			#ifdef WORKBENCH
				eif_try_call ($data);
			#endif
			]"
		end

	scoop_command_call_cleanup (data: like call_data)
			-- Free scoop call data in `data'.
		require
			data_not_null: data /= default_pointer
		external
			"C inline use <eif_scoop.h>"
		alias
			"[
			#ifdef WORKBENCH
				eif_free_call ($data);
			#endif
			]"
		end

	request_processor_resource (a_resource_index: INTEGER_32; a_resource_processor, a_requesting_processor: like processor_id_type; a_block_until_request_granted, a_high_priority: BOOLEAN): NATURAL_8
			--| Request access for `a_requesting_processor' to the resource indicated by `a_resource_index' held by `a_resource_processor'.
		local
			l_exit: BOOLEAN
			l_original_value: INTEGER_32
			l_wait_counter: NATURAL_32
			l_processor_resource: like new_processor_meta_data_entry
		do
			from
				l_processor_resource := processor_meta_data [a_resource_processor]
			until
				l_exit
			loop
					-- Use `a_resource_type' to determine what kind of resource of `a_requesting_processor' needs from `a_resource_processor'.
					-- Be it exclusive access to request queue, or for access to processor locks for lock passing.
				l_original_value := {ATOMIC_MEMORY_OPERATIONS}.compare_and_swap_integer_32 (l_processor_resource.item_address (a_resource_index), a_requesting_processor, null_processor_id)
				if l_original_value = null_processor_id then
						-- The value has been correctly set so Return True and Exit
					Result := resource_lock_newly_attained
					l_exit := True
				else
						-- The processor resource has already been prior requested.
					if l_original_value = a_requesting_processor then
						-- `a_requesting_processor' already has the lock so we can exit.

						--| FIXME We need to handle recursive locking for unlock.
						Result := resource_lock_previously_attained
						l_exit := True
					elseif a_block_until_request_granted then
							-- If high priority then we perform a spin lock.
						processor_yield (a_requesting_processor, l_wait_counter)
						l_wait_counter := l_wait_counter + 1
					else
						-- We don't have the lock and we do not block so we exit and return False.
						Result := resource_lock_unattained
						l_exit := True
						if not a_high_priority then
							processor_yield (a_requesting_processor, l_wait_counter)
						end
					end
				end
			end
		end

	frozen check_for_gc
			-- Hack needed to force the gc to kick in when code is in a tight loop.
		external
			"C macro use <eif_scoop.h>"
		alias
			"RTGC"
		end

	resource_lock_unattained: NATURAL_8 = 0
	resource_lock_newly_attained: NATURAL_8 = 1
	resource_lock_previously_attained: NATURAL_8 = 2
		-- SCOOP Processor resource lock return values.

	relinquish_processor_resource (a_resource_address: POINTER; a_requesting_processor: like processor_id_type; a_high_priority: BOOLEAN)
			-- Relinquish processor resource at `a_resource_address' previously obtained by `a_requesting_processor'.
		local
			l_original_value: INTEGER_32
		do
			l_original_value := {ATOMIC_MEMORY_OPERATIONS}.compare_and_swap_integer_32 (a_resource_address, null_processor_id, a_requesting_processor)
			check resource_relinquished: l_original_value = a_requesting_processor end
			if not a_high_priority then
				processor_yield (a_requesting_processor, 0)
			end
		end

	processor_id_type: INTEGER_32
			-- Type used for unique SCOOP processor id.
		do
		end

	null_processor_id: like processor_id_type = -1
			-- Value to designate an unset processor id value.

	root_processor_id: like processor_id_type
			-- ID of root processor.

feature {NONE} -- Atomic Access

	processor_count: INTEGER_32
		-- Total number of processors currently available to the system.

	waiting_processor_count: INTEGER_32
		-- Number of processors that are currently block waiting for other processors.

	idle_processor_count: INTEGER_32
		-- Number of processors that are at the end of their queue.
		-- If equal to processor_count then the system may exit,

feature {NONE} -- Scoop Processor Meta Data

	routine_type: NATURAL_32 do end
	call_data: POINTER do end
	result_type: POINTER do end

	max_scoop_processors_instantiable: INTEGER_32 = 1536
		-- Total Number of SCOOP Processors that may be instantiated by Pool including Root.

	processor_meta_data: SPECIAL [like new_processor_meta_data_entry]
			-- Holder of Processor Meta Data (indexed by logical processor ID)

	processor_semaphore_list: SPECIAL [POINTER]
			-- Holder of Processor Synchronous Call Semaphores

	new_semaphore (a_sem_count: NATURAL_8): POINTER
			-- Return a new semaphore with an initial count of `a_sem_count'.
		external
			"C inline use <eif_threads.h>"
		alias
			"eif_thr_sem_create ($a_sem_count)"
		end

	processor_semaphore_wait (a_client_processor_id: like processor_id_type)
			-- Make processor `a_client_processor_id' wait until its semaphore is signalled.
		do
			semaphore_client_wait (processor_semaphore_list [a_client_processor_id])
		end

	processor_semaphore_try_wait (a_client_processor_id: like processor_id_type): BOOLEAN
			-- Attempt to make processor `a_client_processor_id' wait untils its semaphore is signalled.
			-- Returns success of attempt.
		do
			Result := semaphore_client_trywait (processor_semaphore_list [a_client_processor_id])
		end

	processor_semaphore_signal (a_client_processor_id: like processor_id_type)
			-- Signal processor `a_client_processor_id' to wake up.
		do
			if a_client_processor_id /= null_processor_id then
				semaphore_supplier_signal (processor_semaphore_list [a_client_processor_id])
			end
		end

	semaphore_client_wait (a_sem_address: POINTER)
			-- Wait for semaphore `a_sem_address'.
		require
			a_sem_address_valid: a_sem_address /= default_pointer
		external
			"C blocking inline use <eif_threads.h>"
		alias
			"eif_thr_sem_wait ($a_sem_address);"
		end

	semaphore_client_trywait (a_sem_address: POINTER): BOOLEAN
			-- Attempt wait for semaphore `a_sem_address'.
		require
			a_sem_address_valid: a_sem_address /= default_pointer
		external
			"C blocking inline use <eif_threads.h>"
		alias
			"eif_thr_sem_trywait ($a_sem_address)"
		end

	semaphore_supplier_signal (a_sem_address: POINTER)
			-- Signal semaphore `a_sem_address'.
		require
			a_sem_address_valid: a_sem_address /= default_pointer
		external
			"C inline use <eif_threads.h>"
		alias
			"eif_thr_sem_post ($a_sem_address);"
		end

	new_processor_meta_data_entry: SPECIAL [INTEGER_32]
			-- New Processor Meta Data Value Entry
		do
			create Result.make_filled (null_processor_id, processor_meta_data_index_count)
		end

	request_chain_meta_data: SPECIAL [detachable like new_request_chain_meta_data_entry]
			-- Holder of Processor Request Chain Meta Data (indexed by logical processor ID)

	request_chain_meta_data_stack_list: SPECIAL [like new_request_chain_meta_data_stack_list_entry]
			-- Holder of Processor Request Chain Meta Data (indexed by logical processor ID)

	new_request_chain_meta_data_stack_list_entry: SPECIAL [detachable like new_request_chain_meta_data_entry]
		do
			create Result.make_filled (Void, request_chain_meta_data_stack_list_entry_size)
		end

	request_chain_meta_data_stack_list_entry_size: NATURAL_8 = 16

	new_request_chain_meta_data_entry: SPECIAL [INTEGER_32]
			-- New Request Chain Meta Data
		do
			create Result.make_empty (request_chain_meta_data_default_size)
				-- Add meta data header null values.
			Result.fill_with (null_processor_id, 0, 4)
			-- Format = {pid_count, client pid, client pid request chain id, node status, head_pid, tailx_pid, head request chain node id, tail request chain node id}
		end

	request_chain_pid_count_index: NATURAL_8 = 0
	request_chain_client_pid_index: NATURAL_8 = 1
	request_chain_client_pid_request_chain_id_index: NATURAL_8 = 2
	request_chain_status_index: NATURAL_8 = 3
	request_chain_sync_counter_index: NATURAL_8 = 4
			-- Index values for request chain states

	request_chain_status_uninitialized: INTEGER_8 = -1
	request_chain_status_open: INTEGER_8 = 0
	request_chain_status_waiting: INTEGER_8 = 1
	request_chain_status_application: INTEGER_8 = 2
	request_chain_status_closed: INTEGER_8 = 3
		-- Various state constants for a request chain.

	request_chain_meta_data_default_size: INTEGER_32 = 9
		-- meta data header + (2 * supplier PID request chain meta data)
	request_chain_meta_data_header_size: INTEGER_32 = 5
		-- Size of request chain meta data header {pid_count, client pid, client pid request chain id, node status}

	request_chain_meta_data_supplier_pid_meta_data_size: INTEGER_32 = 2
		-- {Supplier PID, Supplier Request Chain Node ID}

	new_request_chain_node_meta_data_entry,
	new_request_chain_node_meta_data_queue_entry: like new_request_chain_meta_data_entry
			-- New Request Chain Node Meta Data
		do
			check do_not_call: False end
			create Result.make_empty (0)
		end

	processor_status_index: INTEGER_32 = 0
		-- Current Status of the Scoop Processor at index 'scoop_logical_index'.

	processor_status_uninitialized: INTEGER_32 = -1
		-- Only processor object has been allocated at this point.
	processor_status_initialized: INTEGER_32 = 1
		-- Processor is initialized and executing.
	processor_status_redundant: INTEGER_32 = 2
		-- Processor is redundant.

	current_request_node_id_execution_index: INTEGER_32 = 1

	current_request_chain_id_index: INTEGER_32 = 2
		-- Index to value containing current request chain id.

	current_request_chain_id_depth_index: INTEGER_32 = 3
		-- Index to value containing current depth of request chain id.
		-- Initial value = -1 to signify that there is no active request chain.

	invalid_request_chain_id: INTEGER_32 = -1
	default_request_chain_depth_value: INTEGER_32 = -1

	request_chain_id_lock_index: INTEGER_32 = 4
		-- Index to value containing the lock on the processor for request chain initialization.

	current_request_chain_node_id_index: INTEGER_32 = 5
		-- Index to value containing current request chain node id.

	invalid_request_chain_node_id: INTEGER_32 = -1

	current_request_chain_node_id_lock_index: INTEGER_32 = 6
		-- Index to value containing current request chain node id.

	processor_reference_count_index: INTEGER_32 = 7
		-- Current reference count of the processor

	processor_meta_data_index_count: INTEGER_32 = 8
		-- Number of items in the SCOOP Processor Meta Data structure.


	request_chain_node_meta_data_queue_list: SPECIAL [detachable like new_request_chain_node_meta_data_queue]
		-- List of all request chain node meta data queues, indexed by supplier processor id.

	new_request_chain_node_meta_data_queue: SPECIAL [detachable like new_request_chain_node_meta_data_queue_entry]
			-- Return a new processor request chain node meta data queue.
		do
			create Result.make_filled (Void, max_request_chain_node_queue_index)
		end

	request_chain_node_queue_list: SPECIAL [detachable like new_request_chain_node_queue]
		-- List of all request chain node queues, indexed by supplier processor id.

	new_request_chain_node_queue: SPECIAL [detachable like new_request_chain_node_queue_entry]
			-- Return a new processor request chain node queue.
		do
			create Result.make_filled (Void, max_request_chain_node_queue_index)
		end

	max_request_chain_node_queue_index: INTEGER_32 = 4096
		-- Maximum index of a processors request chain node queue.

	new_request_chain_node_queue_entry: SPECIAL [POINTER]
			-- New entry for request chain node queue
		do
			create Result.make_empty (default_request_chain_node_queue_entry_size)
		end

	default_request_chain_node_queue_entry_size: INTEGER_32 = 5
		-- Default size of request chain node queue.

	logical_cpu_count: NATURAL_32
		-- Number of processors available on the system.

feature {NONE} -- Externals

	frozen available_cpus: NATURAL_8
			--| FIXME: Not Currently used: Implemented for future pooling optimizations
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

	frozen processor_sleep (nanoseconds: INTEGER_64)
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

	one_second_expressed_in_nanoseconds: INTEGER_64 = 1_000_000_000
		-- Value of one second expressed in nanoseconds.

	frozen processor_yield (a_processor_id: like processor_id_type; a_iteration_number: NATURAL_32)
			-- Yield processor `a_processor_id' to competing threads for an OS specific set time.
		do
			if a_iteration_number < processor_spin_lock_limit then
					-- Spin lock
				check_for_gc
			elseif a_iteration_number <= max_yield_counter then
				processor_cpu_yield
			else
				processor_sleep (processor_sleep_quantum)
			end
		end

	processor_spin_lock_limit: NATURAL_32 = 100
		-- Number of iterations to spin lock until yielding.

	max_yield_counter: NATURAL_32 = 4000
		-- Maximum value of the yield counter.

	processor_sleep_quantum: NATURAL_32 = 15_000_000
		-- Number of nanoseconds an idle processor should temporarily sleep for (15 ms)

	frozen processor_cpu_yield
			-- Yield processor to other threads in the processor that are on the same cpu.
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

	frozen root_processor_wait_for_redundancy
			-- Called by root processor to wait for `child' processors (direct/indirect).
		external
			"C blocking use %"eif_threads.h%""
		alias
			"eif_thr_join_all"
		end

note
	copyright: "Copyright (c) 1984-2011, Eiffel Software"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
