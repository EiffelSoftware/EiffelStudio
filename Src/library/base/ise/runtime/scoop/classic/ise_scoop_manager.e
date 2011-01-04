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
			-- Entry point to ISE_SCOOP_MANAGER from RTS SCOOP macros.
		local
			l_id: INTEGER_32
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
				start_processor_application_loop (client_processor_id)
			when signify_start_of_new_chain_task_id then
				signify_start_of_request_chain (client_processor_id)
			when signify_end_of_new_chain_task_id then
				signify_end_of_request_chain (client_processor_id)
			when add_supplier_to_request_chain_task_id then
				assign_supplier_processor_to_request_chain (client_processor_id, supplier_processor_id)
			when wait_for_supplier_processor_locks_task_id then
				wait_for_request_chain_supplier_processor_locks (client_processor_id)
			when add_call_task_id then
				log_call_on_processor (client_processor_id, supplier_processor_id, body_index, a_callback_data)
			when add_synchronous_call_task_id then
				log_call_on_processor (client_processor_id, supplier_processor_id, body_index, a_callback_data)
				wait_for_logged_synchronous_call (client_processor_id, supplier_processor_id)
			when wait_for_processor_redundancy_task_id then
				set_root_processor_has_exited
			else
				check invalid_task: False end
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
		do
			-- Find the next available free SCOOP Processor, reuse or instantiate as needs be.
			-- Either return new scoop processor id or set in EIF_OBJECT header.

			Result := {ATOMIC_MEMORY_OPERATIONS}.increment_integer_32 ($scoop_logical_processor_id_count)

			initialize_default_processor_meta_data (Result, False)

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
			l_attributes: ISE_SCOOP_PROCESSOR_ATTRIBUTES
		do
				--!FIXME IEK: Allocate a default value for reuse.
			create l_attributes.make_with_stack_size (1)
			create_and_initialize_scoop_processor (Current, $scoop_processor_loop, l_attributes.item, a_processor_id)
		end

	set_root_processor_has_exited
			-- Set `root_processor_has_exited' to True
		do
				-- Flag that root processor has finished logging.
			root_processor_has_exited := True

				-- Wait for direct/indirect processors to finish processing.
			root_processor_wait_for_redundancy
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

			l_request_chain_id := (processor_meta_data [a_client_processor_id])[current_request_chain_id_index]

				-- Increase current request chain id depth
			l_request_chain_id_depth := (processor_meta_data [a_client_processor_id])[current_request_chain_id_depth_index] + 1
			(processor_meta_data [a_client_processor_id])[current_request_chain_id_depth_index] := l_request_chain_id_depth
			if l_request_chain_id_depth = 0 then
				-- There are no nested chains so we create a new request chain
				-- We cannot use any previous ones due to aliasing.
				l_request_chain_meta_data := new_request_chain_meta_data_entry
				check l_request_chain_meta_data_attached: attached l_request_chain_meta_data end
					-- Reset node count to default values	
				l_request_chain_meta_data [request_chain_pid_count_index] := 0
				l_request_chain_meta_data [request_chain_client_pid_index] := a_client_processor_id
				l_request_chain_meta_data [request_chain_client_pid_request_chain_id_index] := invalid_request_chain_id
				l_request_chain_meta_data [request_chain_status_index] := request_chain_status_open
				request_chain_meta_data [a_client_processor_id] := l_request_chain_meta_data
			else
				--| FIXME IEK Handle nested request chain / potential lock passing / adding of supplier processors
				check lock_passing_not_yet_implemented: False end
				do_nothing
			end
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
					request_chain_meta_data [a_client_processor_id] := l_request_chain_meta_data
				end
					-- Add new pid to request chain list.
				l_request_chain_meta_data.extend (a_supplier_processor_id)
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

				-- Retrieve request chain meta data structure
				-- Sort unique pid values by logical order
			l_request_chain_id := (processor_meta_data [a_client_processor_id])[current_request_chain_id_index]

				-- Retrieve request chain meta data structure.
			l_request_chain_meta_data := request_chain_meta_data [a_client_processor_id]
			check l_request_chain_meta_data_attached: attached l_request_chain_meta_data end

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
			l_request_chain_meta_data [request_chain_status_index] := -1

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
					processor_meta_data [l_pid].item_address (current_request_chain_node_id_lock_index),
					a_client_processor_id,
					True, -- Wait until granted, we cannot continue until we have control over the value.
					True  -- High Priority, wait is minimal as this is a temporary lock value
				)
				check resource_attained: l_lock_request_return = resource_lock_newly_attained end

				i := i + 1
			end

			-- When all locks have been obtained we retrieve the request chain node ids for each of the locked processors.
			-- When retrieved we initialize the data structure for each supplier pid so that we can then log calls.

			from
				i := request_chain_meta_data_header_size

					-- Resize meta data to allow for supplier processor meta data.
				l_request_chain_meta_data := l_request_chain_meta_data.aliased_resized_area (l_container_count + l_unique_pid_count)
				request_chain_meta_data [a_client_processor_id] := l_request_chain_meta_data

			until
				i = l_container_count
			loop
					-- Add the current supplier processor request chain node id
				l_pid := l_request_chain_meta_data [i]

					-- Increase request chain node id for supplier processor `l_pid'.
					-- Increase atomically in memory.
				l_request_chain_node_id := (processor_meta_data [l_pid]) [current_request_chain_node_id_index]
					-- Extend value to request chain node meta data.
				l_request_chain_meta_data.extend (l_request_chain_node_id)

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

			-- Release locks when request chain nodes ids have been calculated.

			from
				i := request_chain_meta_data_header_size
			until
				i = l_container_count
			loop
					-- Release lock on processor request chain node id
					-- This has to be done atomically via compare and swap
				l_pid := l_request_chain_meta_data [i]

					-- Increase current request chain node id for each processor now that it has been initialized.
				l_request_chain_node_id := {ATOMIC_MEMORY_OPERATIONS}.increment_integer_32 (processor_meta_data [l_pid].item_address (current_request_chain_node_id_index));

				relinquish_processor_resource (
					processor_meta_data [l_pid].item_address (current_request_chain_node_id_lock_index),
					a_client_processor_id,
					True  -- High Priority
				)
				i := i + 1
			end
		end

	signify_end_of_request_chain (a_client_processor_id: like processor_id_type)
			-- Signal the end of a request chain for `a_client_processor_id'.
		local
			l_new_request_chain_id: like invalid_request_chain_id
			l_request_chain_id_depth: like default_request_chain_depth_value
			l_request_chain_meta_data: detachable like new_request_chain_meta_data_entry
		do
				-- Decrease current request chain id depth
			l_request_chain_id_depth := (processor_meta_data [a_client_processor_id])[current_request_chain_id_depth_index] - 1
			(processor_meta_data [a_client_processor_id])[current_request_chain_id_depth_index] := l_request_chain_id_depth

			if l_request_chain_id_depth = default_request_chain_depth_value then
				-- We are completely closing off a chain so we can increase the request chain id value.
				l_request_chain_meta_data := request_chain_meta_data [a_client_processor_id]
				check l_request_chain_meta_data_entry_attached: attached l_request_chain_meta_data end
				l_request_chain_meta_data [request_chain_status_index] := request_chain_status_closed

				l_new_request_chain_id := (processor_meta_data [a_client_processor_id])[current_request_chain_id_index] + 1
				(processor_meta_data [a_client_processor_id]).put (l_new_request_chain_id, current_request_chain_id_index)
			end

			debug ("ISE_SCOOP_MANAGER")
				print ("signify_end_of_request_chain for pid " + a_client_processor_id.out + "%N")
			end
		end

feature -- Command/Query Handling

	frozen scoop_call_data_result (a_call_data: like call_data): POINTER
		require
			a_call_data_valid: a_call_data /= default_pointer
		external
			"C inline use %"eif_scoop.h%""
		alias
			"((call_data*) $a_call_data)->result"
		end

	frozen scoop_call_data_count (a_call_data: like call_data): NATURAL_32
		require
			a_call_data_valid: a_call_data /= default_pointer
		external
			"C inline use %"eif_scoop.h%""
		alias
			"((call_data*) $a_call_data)->count"
		end

	frozen scoop_call_data_body_index (a_call_data: like call_data): INTEGER_32
		require
			a_call_data_valid: a_call_data /= default_pointer
		external
			"C inline use %"eif_scoop.h%""
		alias
			"((call_data*) $a_call_data)->body_index"
		end

	frozen scoop_call_data_is_synchronous (a_call_data: like call_data): BOOLEAN
		require
			a_call_data_valid: a_call_data /= default_pointer
		external
			"C inline use %"eif_scoop.h%""
		alias
			"((call_data*) $a_call_data)->is_synchronous"
		end

	frozen scoop_call_data_target (a_call_data: like call_data): POINTER
		require
			a_call_data_valid: a_call_data /= default_pointer
		external
			"C inline use %"eif_scoop.h%""
		alias
			"((call_data*) $a_call_data)->target"
		end

	frozen scoop_call_data_argument (a_call_data: like call_data; i_th: NATURAL_32): POINTER
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
			l_request_chain_meta_data: detachable like new_request_chain_meta_data_entry
			l_request_chain_node_id: like invalid_request_chain_node_id
			l_request_chain_node_queue: detachable like new_request_chain_node_queue
			l_request_chain_node_queue_entry: detachable like new_request_chain_node_queue_entry
			l_request_chain_node_meta_data_queue: detachable like new_request_chain_node_meta_data_queue
			l_creation_routine_logging, l_processor_needs_launch: BOOLEAN
			l_unique_pid_count, l_first_pid, i, l_last_pid_index: INTEGER_32
		do
			debug ("ISE_SCOOP_MANAGER")
				print ("log_call_on_processor for pid " + a_client_processor_id.out + " on pid " + a_supplier_processor_id.out + "%N")
			end

			if (processor_meta_data [a_supplier_processor_id])[current_request_chain_node_id_index] = 0 then
					-- We must be logging a creation routine
				l_creation_routine_logging := True
				l_request_chain_node_id := 0

					--| FIXME IEK: Update when processors can be relaunched.
				l_processor_needs_launch := True
			else
					-- Check if a query is being made, in which case we need to temporarily close off the chain and block until the query has been serviced.

					-- Call is specific to `a_client_processor_id' so we need to retrieve the request chain node for `a_supplier_processor_id' from here.
				l_request_chain_meta_data := request_chain_meta_data [a_client_processor_id]
				check l_client_request_chain_meta_data_attached: attached l_request_chain_meta_data end

				l_unique_pid_count := l_request_chain_meta_data [request_chain_pid_count_index]
				check l_unique_pid_count_valid: l_unique_pid_count > 0 end
				l_first_pid := l_request_chain_meta_data [request_chain_meta_data_header_size]
				if l_first_pid = a_supplier_processor_id then
					l_request_chain_node_id := l_request_chain_meta_data [request_chain_meta_data_header_size + l_unique_pid_count]
				else
						-- If supplier pid is not the first pid then we must have more than one unique pid
					check l_unique_pid_count_valid: l_unique_pid_count > 1 end

						-- Search through remaining pid's to find the associating request chain node id.
					from
						l_request_chain_node_id := invalid_request_chain_node_id
						i := request_chain_meta_data_header_size + 1
						l_last_pid_index := request_chain_meta_data_header_size + l_unique_pid_count - 1
					until
						i > l_last_pid_index
					loop
						if l_request_chain_meta_data [i] = a_supplier_processor_id then
							l_request_chain_node_id := l_request_chain_meta_data [i + l_unique_pid_count]
							i := l_last_pid_index
						end
						i := i + 1
					end
					check pid_found: l_request_chain_node_id /= invalid_request_chain_node_id end
				end
			end

				-- Retrieve request chain node list so the call can be logged
			l_request_chain_node_queue := request_chain_node_queue_list [a_supplier_processor_id]
			check l_request_chain_node_queue_attached: attached l_request_chain_node_queue end

			l_request_chain_node_queue_entry := l_request_chain_node_queue [l_request_chain_node_id]
			if not attached l_request_chain_node_queue_entry then
				check request_chain_node_queue_entry_value: l_creation_routine_logging end
				l_request_chain_node_queue_entry := new_request_chain_node_queue_entry
				l_request_chain_node_queue [l_request_chain_node_id] := l_request_chain_node_queue_entry
			else
				if l_creation_routine_logging then
						-- If processor has been reused we need to make sure that the request node call structure is empty.
					l_request_chain_node_queue_entry.wipe_out
				end
			end

			if l_request_chain_node_queue_entry.count = l_request_chain_node_queue_entry.capacity then
					-- Resize node structure if there is not enough room for the new entry
					--| FIXME IEK: Resizing 3 extra items may not be optimal in all cases
				l_request_chain_node_queue_entry := l_request_chain_node_queue_entry.aliased_resized_area (l_request_chain_node_queue_entry.count + 3)
				l_request_chain_node_queue [l_request_chain_node_id] := l_request_chain_node_queue_entry
					-- Readd in case we have a new structure.
			end

				-- Add `a_call_data' to the request chain node queue
			l_request_chain_node_queue_entry.extend (a_call_data)

			if l_creation_routine_logging then
					-- Creation routines are logged directly so we must add the call meta data
				l_request_chain_meta_data := new_request_chain_meta_data_entry

					-- Set request chain meta data for creation routine.
				l_request_chain_meta_data [request_chain_pid_count_index] := 1 -- Number of processors involved in chain (a_processor_id)
				l_request_chain_meta_data [request_chain_client_pid_index] := a_supplier_processor_id -- client processor id
				l_request_chain_meta_data [request_chain_client_pid_request_chain_id_index] := 0 -- current request chain id
				l_request_chain_meta_data [request_chain_status_index] := request_chain_status_closed -- Request chain is closed.
				l_request_chain_meta_data.extend (a_supplier_processor_id)
				l_request_chain_meta_data.extend (0) -- current request chain node id

				l_request_chain_node_meta_data_queue := request_chain_node_meta_data_queue_list [a_supplier_processor_id]
				check l_request_chain_node_meta_data_queue_attached: attached l_request_chain_node_meta_data_queue end
				l_request_chain_node_meta_data_queue [0] := l_request_chain_meta_data

				request_chain_meta_data [a_supplier_processor_id] := l_request_chain_meta_data;

					-- Increase request chain and request chain node id to simulate normal logging procedure
				(processor_meta_data [a_supplier_processor_id]) [current_request_chain_id_index] := 1
				(processor_meta_data [a_supplier_processor_id]) [current_request_chain_node_id_index] := 1
			end

			if l_processor_needs_launch then
				start_processor_application_loop (a_supplier_processor_id)
			end
		end

	wait_for_logged_synchronous_call (a_client_processor_id, a_supplier_processor_id: like processor_id_type)
			-- Block until previous logged synchronous call on `a_client_processor_id' has been applied by `a_supplier_processor_id'.
		local
			l_request_chain_meta_data: detachable like new_request_chain_meta_data_entry
		do
					-- Update chain to be callable, wait for tail node to signal that call has been processed.
			(processor_meta_data [a_client_processor_id]) [current_request_chain_query_blocking_processor_index] := a_supplier_processor_id

					-- Set status to waiting if nodes are not already executing, wait for execution flag.
			l_request_chain_meta_data := request_chain_meta_data [a_client_processor_id]
			check l_scoop_process_request_chain_meta_data_attached: attached l_request_chain_meta_data end


				-- Wait until status has been reset to 'application' before continuing
			from
				-- Set request chain status to waiting, this will active the current request chain
				l_request_chain_meta_data [request_chain_status_index] := request_chain_status_waiting
			until
				l_request_chain_meta_data [request_chain_status_index] = request_chain_status_application
			loop
				yield_to_operating_system
			end
		end

feature {NONE} -- Resource Initialization

	init_scoop_manager
			-- Initialize processor meta data.
		local
			i: INTEGER_32
			l_processor_meta_data: like processor_meta_data
		do
			from
				i := 1
				create l_processor_meta_data.make_empty (max_scoop_processors_instantiable)
				create request_chain_meta_data.make_filled (Void, max_scoop_processors_instantiable)
			until
				i > Max_scoop_processors_instantiable
			loop
				l_processor_meta_data.extend (new_processor_meta_data_entry)
				i := i + 1
			end
			processor_meta_data := l_processor_meta_data

				-- Create request chain node meta data queue pigeon hole for each potential processor.
			create request_chain_node_meta_data_queue_list.make_filled (Void, max_scoop_processors_instantiable)

				-- Create request chain node queue pigeon for each potential processor.
			create request_chain_node_queue_list.make_filled (Void, max_scoop_processors_instantiable)

				-- Initialize request chain and request chain id node values for root processor
			initialize_default_processor_meta_data (root_processor_id, False)
		end

	initialize_default_processor_meta_data (a_processor_id: like processor_id_type; a_reinitialize: BOOLEAN)
			-- Initialize processor `a_processor_id' meta data to default values after a creation routine has been logged.
		local
			l_request_chain_node_meta_data_queue: detachable like new_request_chain_node_meta_data_queue
			l_request_chain_node_queue: detachable like new_request_chain_node_queue
		do
			(processor_meta_data [a_processor_id]).put (invalid_request_chain_node_id, current_request_chain_id_depth_index)

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
			l_head_pid: like processor_id_type
			l_is_head: BOOLEAN
			l_orig_chain_node_count, l_temp_count: INTEGER
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
				if l_processor_meta_data [processor_status_index] = processor_status_initialized then
						-- SCOOP processor is initialized so we can check current index

						-- Retrieve execution index
					l_executing_node_id := l_processor_meta_data [current_request_node_id_execution_index]
					if
						l_executing_node_id < l_request_chain_node_meta_data_queue.count
					then
						l_executing_request_chain_node_meta_data := l_request_chain_node_meta_data_queue [l_executing_node_id]
						if
							attached l_executing_request_chain_node_meta_data and then
							l_executing_request_chain_node_meta_data [request_chain_status_index] /= request_chain_status_open
								-- We only allow feature application to occur when the chain is correctly set.
						then
								-- We are in a valid feature application position as the request chain has been closed.
							from
								l_head_pid := l_executing_request_chain_node_meta_data [request_chain_meta_data_header_size]
								l_is_head := l_head_pid = a_logical_processor_id

								if l_is_head then
									l_orig_chain_node_count := {ATOMIC_MEMORY_OPERATIONS}.add_integer_32 (l_executing_request_chain_node_meta_data.item_address (request_chain_pid_count_index), 0)
										-- We are a head node, set PID count to minus original tail count

										-- Wait until value is -1
									from
										l_temp_count := {ATOMIC_MEMORY_OPERATIONS}.swap_integer_32 (l_executing_request_chain_node_meta_data.item_address (request_chain_pid_count_index), -l_orig_chain_node_count)
									until
										{ATOMIC_MEMORY_OPERATIONS}.add_integer_32 (l_executing_request_chain_node_meta_data.item_address (request_chain_pid_count_index), 0) = -1
									loop
										yield_to_operating_system
									end
										-- Set to zero, increment by 1 (atomic swap with 1 as shortcut)
										-- Wait until count is original count, this signifies that all tail nodes are now executing
									from
										l_temp_count := {ATOMIC_MEMORY_OPERATIONS}.swap_integer_32 (l_executing_request_chain_node_meta_data.item_address (request_chain_pid_count_index), 1)
									until
										{ATOMIC_MEMORY_OPERATIONS}.add_integer_32 (l_executing_request_chain_node_meta_data.item_address (request_chain_pid_count_index), 0) = l_orig_chain_node_count
									loop
										yield_to_operating_system
									end
										-- Tail nodes are all synchronized and executing so head node can continue.	

								else
									-- We are a tail node, we wait for head node to set pid count to negative value.
									from
										l_temp_count := {ATOMIC_MEMORY_OPERATIONS}.add_integer_32 (l_executing_request_chain_node_meta_data.item_address (request_chain_pid_count_index), 0)
									until
										l_temp_count < 0
									loop
										yield_to_operating_system
										l_temp_count := {ATOMIC_MEMORY_OPERATIONS}.add_integer_32 (l_executing_request_chain_node_meta_data.item_address (request_chain_pid_count_index), 0)
									end
									l_temp_count := {ATOMIC_MEMORY_OPERATIONS}.increment_integer_32 (l_executing_request_chain_node_meta_data.item_address (request_chain_pid_count_index))
									from
										l_temp_count := {ATOMIC_MEMORY_OPERATIONS}.add_integer_32 (l_executing_request_chain_node_meta_data.item_address (request_chain_pid_count_index), 0)
									until
										l_temp_count > 0
									loop
										yield_to_operating_system
										l_temp_count := {ATOMIC_MEMORY_OPERATIONS}.add_integer_32 (l_executing_request_chain_node_meta_data.item_address (request_chain_pid_count_index), 0)
									end
									l_temp_count := {ATOMIC_MEMORY_OPERATIONS}.increment_integer_32 (l_executing_request_chain_node_meta_data.item_address (request_chain_pid_count_index))
								end

								l_executing_request_chain_node := l_request_chain_node_queue [l_executing_node_id]
								check l_executing_request_chain_node_attached: attached l_executing_request_chain_node end

								l_executing_node_id_cursor := 0
								l_feature_application_loop_exit := False
							until
								l_feature_application_loop_exit
							loop
								if l_executing_node_id_cursor < l_executing_request_chain_node.count then
									scoop_command_call (l_executing_request_chain_node [l_executing_node_id_cursor])
									l_executing_node_id_cursor := l_executing_node_id_cursor + 1
								elseif l_executing_request_chain_node_meta_data [request_chain_status_index] = request_chain_status_closed then
										-- Request chain has been fully closed therefore we can exit
									l_feature_application_loop_exit := l_executing_node_id_cursor = l_executing_request_chain_node.count
								elseif l_executing_request_chain_node_meta_data [request_chain_status_index] = request_chain_status_waiting then
										-- The client is waiting for all nodes to apply all logged calls before using query value.
										from
											l_temp_count := {ATOMIC_MEMORY_OPERATIONS}.decrement_integer_32 (l_executing_request_chain_node_meta_data.item_address (request_chain_pid_count_index))
										until
											l_executing_request_chain_node_meta_data [request_chain_status_index] = request_chain_status_application
										loop
											l_temp_count := {ATOMIC_MEMORY_OPERATIONS}.add_integer_32 (l_executing_request_chain_node_meta_data.item_address (request_chain_pid_count_index), 0)
											if l_is_head and then l_temp_count = 0 then
													-- Reset count to `l_orig_chain_node_count' stored in the previous sync section.
												l_executing_request_chain_node_meta_data [request_chain_pid_count_index] := l_orig_chain_node_count
												l_executing_request_chain_node_meta_data [request_chain_status_index] := request_chain_status_application
											else
												yield_to_operating_system
											end
										end

								else
									-- We are waiting for the request chain to close or to have more calls logged
									yield_to_operating_system
								end
							end
								-- Increment execution cursor by one.
							l_processor_meta_data [current_request_node_id_execution_index] := l_executing_node_id + 1
						else
								-- We are in a dorment state so we yield to the operating system.
							yield_to_operating_system
						end
					else
						yield_to_operating_system
					end
				elseif root_processor_has_exited then
					l_processor_exit := True
				else
						-- Processor is redundant so we yield control to OS for the time being.
					yield_to_operating_system
				end
			end
		end

	scoop_command_call (data: like call_data)
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
						if not a_high_priority then
							yield_to_operating_system
						end
					else
						-- We don't have the lock and we do not block so we exit and return False.
						Result := resource_lock_unattained
						l_exit := True
						if not a_high_priority then
							yield_to_operating_system
						end
					end
				end
			end
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
				yield_to_operating_system
			end
		end

	processor_id_type: INTEGER_32
			-- Type used for unique SCOOP processor id.
		do
		end

	null_processor_id: like processor_id_type = -1
			-- Value to designate an unset processor id value.

	root_processor_id: like processor_id_type = 0
			-- ID of root processor.

	scoop_logical_processor_id_count: INTEGER_32
		-- Number of logical processor ids that have been allocated.
		-- Value should not be used directly and only accessed via atomic memory operations.

feature {NONE} -- Scoop Processor Meta Data

	routine_type: NATURAL_32 do end
	call_data: POINTER do end
	result_type: POINTER do end

	max_scoop_processors_instantiable: INTEGER_32 = 256
		-- Total Number of SCOOP Processors that may be instantiated by Pool including Root.

	processor_meta_data: SPECIAL [like new_processor_meta_data_entry]
			-- Holder of Processor Meta Data (indexed by logical processor ID)

	new_processor_meta_data_entry: SPECIAL [INTEGER_32]
			-- New Processor Meta Data Value Entry
		do
			create Result.make_filled (null_processor_id, processor_meta_data_index_count)
		end

	request_chain_meta_data: SPECIAL [detachable like new_request_chain_meta_data_entry]
			-- Holder of Processor Request Chain Meta Data (indexed by logical processor ID)

	new_request_chain_meta_data_entry: SPECIAL [INTEGER_32]
			-- New Request Chain Meta Data
		do
			create Result.make_empty (request_chain_meta_data_default_size)
				-- Add meta data header null values.
			Result.fill_with (null_processor_id, 0, 3)
			-- Format = {pid_count, client pid, client pid request chain id, node status, head_pid, tailx_pid, head request chain node id, tail request chain node id}
		end

	request_chain_pid_count_index: NATURAL_8 = 0
	request_chain_client_pid_index: NATURAL_8 = 1
	request_chain_client_pid_request_chain_id_index: NATURAL_8 = 2
	request_chain_status_index: NATURAL_8 = 3

	request_chain_status_open: INTEGER_8 = -1
	request_chain_status_waiting: INTEGER_8 = 0
	request_chain_status_application: INTEGER_8 = 1
	request_chain_status_closed: INTEGER_8 = 2

	request_chain_meta_data_default_size: INTEGER_32 = 8
		-- meta data header + (2 * supplier PID request chain meta data)
	request_chain_meta_data_header_size: INTEGER_32 = 4
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

	current_request_chain_query_blocking_processor_index: INTEGER_32 = 7
		-- Index to value containing blocking processor that is being waited on in the current request chain.

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

	frozen root_processor_wait_for_redundancy
			-- Called by root processor to wait for `child' processors (direct/indirect).
		external
			"C blocking use %"eif_threads.h%""
		alias
			"eif_thr_join_all"
		end

end
