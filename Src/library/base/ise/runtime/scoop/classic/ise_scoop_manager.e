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
		do
			inspect
				scoop_task
			when check_uncontrolled_call_task_id then
				set_boolean_return_value (a_callback_data, is_uncontrolled (client_processor_id, supplier_processor_id))
			when add_call_task_id then
				log_call_on_processor (client_processor_id, supplier_processor_id, body_index, a_callback_data)
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
			when wait_for_processor_redundancy_task_id then
				root_processor_creation_routine_exited
			when assign_processor_task_id then
				set_integer_32_return_value (a_callback_data, assign_free_processor_id)
			when free_processor_task_id then
				free_processor_id (client_processor_id)
			when add_processor_reference_task_id then
				add_processor_reference (supplier_processor_id)
			when remove_processor_reference_task_id then
				remove_processor_reference (supplier_processor_id)
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

	maximum_dirty_processor_client_count: INTEGER = 16
		-- Maximum number of client processors a supplier processor may be dirty to.

	flag_processor_dirty (
			a_logical_processor_id: like processor_id_type;
			a_executing_request_chain_node_meta_data: like new_request_chain_node_meta_data_queue_entry
			a_executing_request_chain_node: like new_request_chain_node_queue_entry
			a_executing_request_chain_node_cursor: INTEGER)
		local
			l_dirty_flag_count: INTEGER
			l_dirty_processor_client_list: detachable like new_request_chain_meta_data_entry
			l_client_processor_id: like processor_id_type
			i: INTEGER
			l_lock_request_return: INTEGER
		do
				-- Signal the request chain as dirty so that any other processors in the request chain cease applying calls.
			a_executing_request_chain_node_meta_data [request_chain_status_index] := request_chain_status_dirty

				-- Retrieve currently executing request chain so that we can flag the client processor as dirty with regards to `a_processor_id'.
			l_dirty_processor_client_list := (request_chain_meta_data_stack_list [a_logical_processor_id]) [max_request_chain_depth]
			if l_dirty_processor_client_list = Void then
				create l_dirty_processor_client_list.make_filled (null_processor_id, maximum_dirty_processor_client_count)
					-- Set count to zero.
				(request_chain_meta_data_stack_list [a_logical_processor_id]) [max_request_chain_depth] := l_dirty_processor_client_list
			end

			l_client_processor_id := a_executing_request_chain_node_meta_data [request_chain_client_pid_index]
				-- Find the next available slot to add `l_client_processor_id'.

			l_lock_request_return := request_processor_resource (
				processor_dirty_processor_client_list_lock_index,
				a_logical_processor_id,
				l_client_processor_id,
				True, -- Wait until granted, we cannot continue until we have control over the value.
				True  -- High Priority, wait is minimal as this is a temporary lock value
			)
			check resource_attained: l_lock_request_return = resource_lock_newly_attained end

			from
				i := 0
			until
				i >= maximum_dirty_processor_client_count
			loop
				if l_dirty_processor_client_list [i] = null_processor_id then
					l_dirty_processor_client_list [i] := l_client_processor_id
					i := maximum_dirty_processor_client_count
				end
				i := i + 1
			end

			relinquish_processor_resource (
				processor_meta_data [a_logical_processor_id].item_address (processor_dirty_processor_client_list_lock_index),
				l_client_processor_id,
				True  -- High Priority
			)

			if i = maximum_dirty_processor_client_count then
					-- There were no available slots for `l_client_processor_id'.
				raise_scoop_exception ("Maximum SCOOP dirty processor count reached")
			end

				-- Update dirty flag count for the client processor.
			l_dirty_flag_count := {ATOMIC_MEMORY_OPERATIONS}.increment_integer_32 (processor_meta_data [l_client_processor_id].item_address (processor_dirty_flag_count_index))
				--| FIXME A check may be needed should the number of dirty processors for a client go above a certain limit.
		end

	is_uncontrolled (a_client_processor_id, a_supplier_processor_id: like processor_id_type): BOOLEAN
			-- Is `a_supplier_processor_id' uncontrolled in the current context of `a_client_processor_id'.
		local
			l_end_index, i: INTEGER
		do
			if request_chain_meta_data [a_client_processor_id] /= default_request_chain_meta_data_entry then
					-- Check first if we are lock passing, if not then we check the entire chain.
				Result := (request_chain_meta_data [a_client_processor_id]) [request_chain_client_pid_index] /= a_supplier_processor_id
				if Result then
					l_end_index := (request_chain_meta_data [a_client_processor_id]) [request_chain_pid_count_index]
					if l_end_index > 0 then
						from
							i := request_chain_meta_data_header_size
							l_end_index := l_end_index + i
						until
							i = l_end_index or else not Result
						loop
							Result := (request_chain_meta_data [a_client_processor_id]) [i] /= a_supplier_processor_id
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
--	frozen start_processor_loop_task_id: NATURAL_8 = 3
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
		--| FIXME: Use external macros when valid in an inspect statement.

feature -- EIF_TYPED_VALUE externals

	set_boolean_return_value (a_boolean_typed_value: POINTER; a_boolean: BOOLEAN)
		external
			"C macro use %"eif_scoop.h%""
		end

	set_integer_32_return_value (a_integer_32_typed_value: POINTER; a_integer: INTEGER_32)
		external
			"C macro use %"eif_scoop.h%""
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
				raise_scoop_exception ("Maximum SCOOP Processor Allocation reached")
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

	root_processor_creation_routine_exited
			-- Root processor's creation routine has exited.
		do
				-- End request chain of root processor creation routine.
			signify_end_of_request_chain (root_processor_id)

				-- Make root processor as initialized as the creation routine has completed.
			processor_meta_data [root_processor_id].put (processor_status_initialized, processor_status_index)

				-- Run processor loop for root processor for any pending logged calls.
			scoop_processor_loop (root_processor_id)

				-- Wait for all processors to have completely exited before exiting.
			root_processor_wait_for_redundancy
		end

feature -- Request Chain Handling

	signify_start_of_request_chain (a_client_processor_id: like processor_id_type)
			-- Signify the start of a new request chain on `a_client_processor_id'
		local
			l_temp_value: INTEGER_32
		do
				-- Increment current request chain id depth
			l_temp_value := {ATOMIC_MEMORY_OPERATIONS}.increment_integer_32 (processor_meta_data [a_client_processor_id].item_address (current_request_chain_id_depth_index));
			if l_temp_value = max_request_chain_depth then
				raise_scoop_exception (scoop_request_chain_stack_overflow_message)
			end

				-- Increase request chain id.
			l_temp_value := {ATOMIC_MEMORY_OPERATIONS}.increment_integer_32 (processor_meta_data [a_client_processor_id].item_address (current_request_chain_id_index));

				-- Update `a_client_processor_id' with a new request chain.
			update_request_chain_meta_data (a_client_processor_id, new_request_chain_meta_data_entry (a_client_processor_id))

			debug ("ISE_SCOOP_MANAGER")
				print ("signify_start_of_request_chain for pid " + a_client_processor_id.out + " %N")
			end
		end

	increase_request_chain_depth (a_client_processor_id: like processor_id_type)
			-- Increase request chain depth for `a_client_processor_id'
		local
			l_request_chain_depth: like default_request_chain_depth_value
		do
			l_request_chain_depth := {ATOMIC_MEMORY_OPERATIONS}.increment_integer_32 (processor_meta_data [a_client_processor_id].item_address (current_request_chain_id_depth_index));
		end

	decrease_request_chain_depth (a_client_processor_id: like processor_id_type)
			-- Decrease request chain depth for `a_client_processor_id'.
		local
			l_request_chain_depth: like default_request_chain_depth_value
		do
			l_request_chain_depth := {ATOMIC_MEMORY_OPERATIONS}.decrement_integer_32 (processor_meta_data [a_client_processor_id].item_address (current_request_chain_id_depth_index));
		end

	signify_end_of_request_chain (a_client_processor_id: like processor_id_type)
			-- Signal the end of a request chain for `a_client_processor_id'.
		local
			l_request_chain_depth: like default_request_chain_depth_value
			l_request_chain_meta_data: detachable like new_request_chain_meta_data_entry
			l_wait_condition_counter: INTEGER
		do
				-- Reset request chain values
			l_request_chain_depth := {ATOMIC_MEMORY_OPERATIONS}.decrement_integer_32 (processor_meta_data [a_client_processor_id].item_address (Current_request_chain_id_depth_index))

				-- Retrieve existing meta data chain and close it		
			l_request_chain_meta_data := (request_chain_meta_data_stack_list [a_client_processor_id]) [l_request_chain_depth + 1]
			(request_chain_meta_data_stack_list [a_client_processor_id]) [l_request_chain_depth + 1] := Void
			check l_previous_chain_meta_data_entry_attached: attached l_request_chain_meta_data end
			l_request_chain_meta_data [request_chain_status_index] := request_chain_status_closed;

			if l_request_chain_depth > default_request_chain_depth_value then
				l_request_chain_meta_data := (request_chain_meta_data_stack_list [a_client_processor_id]) [l_request_chain_depth]
				check l_request_chain_meta_data_attached: l_request_chain_meta_data /= Void end
				request_chain_meta_data [a_client_processor_id] := l_request_chain_meta_data
			else
					-- We are fully closing off the chain so we set the request chain to the default value.
				request_chain_meta_data [a_client_processor_id] := default_request_chain_meta_data_entry
			end
				-- Reset the wait condition counter to zero.
			l_wait_condition_counter := {ATOMIC_MEMORY_OPERATIONS}.swap_integer_32 (processor_meta_data [a_client_processor_id].item_address (processor_wait_condition_counter_index), 0)

			debug ("ISE_SCOOP_MANAGER")
				print ("signify_end_of_request_chain for pid " + a_client_processor_id.out + "%N")
			end
		end

	signify_end_of_wait_condition_chain (a_client_processor_id: like processor_id_type)
			-- Signal the end of a failed wait_condition.
		local
			l_wait_condition_counter: INTEGER_32
		do
				-- End request chain and make sure that the wait condition counter is incremented.
			l_wait_condition_counter := {ATOMIC_MEMORY_OPERATIONS}.increment_integer_32 (processor_meta_data [a_client_processor_id].item_address (processor_wait_condition_counter_index))

			signify_end_of_request_chain (a_client_processor_id)
				-- Set the wait counter to the incremented value as ending the request chain always resets it back to zero.
			l_wait_condition_counter := {ATOMIC_MEMORY_OPERATIONS}.swap_integer_32 (processor_meta_data [a_client_processor_id].item_address (processor_wait_condition_counter_index), l_wait_condition_counter)

				-- Yield processor temporarily (no spin locking as a failed wait condition is lower priority).
			processor_yield (a_client_processor_id, Processor_spin_lock_limit + l_wait_condition_counter.as_natural_32)
		end

	assign_supplier_processor_to_request_chain (a_client_processor_id, a_supplier_processor_id: like processor_id_type)
			-- Assign `a_supplier_processor_id' to the current request chain of `a_client_processor_id'
		local
			l_request_chain_id: like invalid_request_chain_id
			l_request_chain_meta_data: detachable like new_processor_meta_data_entry
			i, l_count, l_pid_count: INTEGER
			l_pid_present: BOOLEAN
		do
			debug ("ISE_SCOOP_MANAGER")
				print ("assign_supplier_process_to_request_chain for pid " + a_client_processor_id.out + " with supplier processor " + a_supplier_processor_id.out + "%N")
			end

			if a_supplier_processor_id /= a_client_processor_id then
				l_request_chain_id := (processor_meta_data [a_client_processor_id])[current_request_chain_id_index]

					-- Retrieve request chain meta data structure, add supplier pid to it if not already present.
				l_request_chain_meta_data := request_chain_meta_data [a_client_processor_id]
				check l_request_chain_meta_data_attached: attached l_request_chain_meta_data end

				l_pid_count := l_request_chain_meta_data [request_chain_pid_count_index]
				from
					i := request_chain_meta_data_header_size
					l_count := i + l_pid_count
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
					if a_supplier_processor_id = null_processor_id then
							-- We are adding a creation routine
						l_request_chain_meta_data.force (a_client_processor_id, l_count)
					else
						l_request_chain_meta_data.force (a_supplier_processor_id, l_count)
					end
					l_request_chain_meta_data [request_chain_pid_count_index] := l_pid_count + 1
				end
			end
		end

	update_request_chain_meta_data (a_client_processor_id: like processor_id_type; a_request_chain_meta_data: like new_request_chain_meta_data_entry)
			-- Update request chain meta data for `a_client_processor_id'.
		local
			l_request_chain_depth: INTEGER
		do
			l_request_chain_depth := (processor_meta_data [a_client_processor_id]) [Current_request_chain_id_depth_index]
			(request_chain_meta_data_stack_list [a_client_processor_id]) [l_request_chain_depth] := a_request_chain_meta_data
			request_chain_meta_data [a_client_processor_id] := a_request_chain_meta_data
		end

	wait_for_request_chain_supplier_processor_locks (a_client_processor_id: like processor_id_type)
			-- Wait until all locks for the supplier processors involved in the current request chain id of `a_client_processor_id' to become available.
		local
			l_request_chain_id: like invalid_request_chain_id
			l_request_chain_node_id: like invalid_request_chain_node_id
			l_request_chain_meta_data, l_previous_request_chain_meta_data: detachable like new_request_chain_meta_data_entry
			l_request_chain_node_meta_data_queue: detachable like new_request_chain_node_meta_data_queue
			l_request_chain_node_queue: detachable like new_request_chain_node_queue
			l_request_chain_node_queue_entry: detachable like new_request_chain_node_queue_entry
			l_exit, l_swap_occurred, l_merge_needed: BOOLEAN
			i, j, l_container_count, l_pid_count, l_previous_container_pid_count_upper, l_previous_pid_count: INTEGER
			l_pid: like processor_id_type
			l_lock_request_return: NATURAL_8
			l_request_chain_depth: INTEGER
			l_wait_condition_counter: INTEGER
		do
			-- Sort unique processor id's by order of priority, then wait for locks on each processor so that a new request chain node can be initialized.
			debug ("ISE_SCOOP_MANAGER")
				print ("wait_for_request_chain_supplier_processor_locks for pid " + a_client_processor_id.out + "%N")
			end

				-- Retrieve wait condition counter for determining priority of processor request.
			l_wait_condition_counter := (processor_meta_data [a_client_processor_id]) [processor_wait_condition_counter_index]
			if l_wait_condition_counter > max_wait_condition_retry_limit then
				raise_scoop_exception ("SCOOP Wait Condition Retry Limit Reached")
			end

				-- Retrieve request chain meta data structure.
			l_request_chain_meta_data := request_chain_meta_data [a_client_processor_id]
			check l_request_chain_meta_data_attached: attached l_request_chain_meta_data end

			l_pid_count := l_request_chain_meta_data [request_chain_pid_count_index]
			l_container_count := request_chain_meta_data_header_size + l_pid_count
				-- Number of processor ids in new structure

						-- Retrieve request chain meta data structure
				-- Sort unique pid values by logical order
			l_request_chain_id := (processor_meta_data [a_client_processor_id])[current_request_chain_id_index]
			l_request_chain_depth := (processor_meta_data [a_client_processor_id])[current_request_chain_id_depth_index]

			if l_request_chain_depth > 0 then
					-- Iterate parent chain to see if there are common processors, if so then we need to sync them.
				from
					l_previous_request_chain_meta_data := (request_chain_meta_data_stack_list [a_client_processor_id]) [l_request_chain_depth - 1]
					check l_previous_request_chain_attached: l_previous_request_chain_meta_data /= Void end
					i := request_chain_meta_data_header_size
					l_previous_pid_count := l_previous_request_chain_meta_data [request_chain_pid_count_index]
					l_previous_container_pid_count_upper := i + l_previous_pid_count
				until
					i = l_previous_container_pid_count_upper
				loop
					from
						j := request_chain_meta_data_header_size
					until
						j = l_container_count
					loop
						if l_request_chain_meta_data [j] = l_previous_request_chain_meta_data [i] then
								-- The processor exists in the previous chain so we must remove it from the new one for later merging.
							l_merge_needed := True
							if j + 1 = l_container_count then
								-- We are the last pid in the list so we can simply null the values
								l_request_chain_meta_data [j] := null_processor_id
							else
								l_request_chain_meta_data.move_data (j + 1, j, l_container_count - (j + 1))
							end
							l_pid_count := l_pid_count - 1
							l_container_count := l_container_count - 1
							l_request_chain_meta_data [request_chain_pid_count_index] := l_pid_count
								-- Exit the loop to check again the next pid in the previous chain.
							j := l_container_count
						else
							j := j + 1
						end
					end
					i := i + 1
				end
			end

			if not l_merge_needed then
					-- Reset previous pid count if no merging is required.
				l_previous_pid_count := 0
			end

			from
					-- Start at first PID value, with zero based SPECIAL this equals the header size.
				i := request_chain_meta_data_header_size
				l_exit := l_pid_count <= 1
			until
				l_exit
			loop
					-- Sort Unique PID Values by order of priority (in this case the lowest PID value takes preference)
				l_pid := l_request_chain_meta_data [i]
				if l_pid > l_request_chain_meta_data [i + 1] then
					l_request_chain_meta_data [i] := l_request_chain_meta_data [i + 1]
					l_request_chain_meta_data [i + 1] := l_pid
					l_swap_occurred := l_pid_count > 2
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
						l_exit := True
					end
				else
					i := i + 1
				end
			end

				-- Reformulate meta data structure with unique pid count as the first value followed by the unique sorted pid values
			l_request_chain_meta_data [request_chain_pid_count_index] := l_pid_count + l_previous_pid_count -- Add previous pid count should merging occur.
			l_request_chain_meta_data [request_chain_client_pid_index] := a_client_processor_id
			l_request_chain_meta_data [request_chain_client_pid_request_chain_id_index] := l_request_chain_id
			l_request_chain_meta_data [request_chain_status_index] := request_chain_status_uninitialized
			l_request_chain_meta_data [request_chain_sync_counter_index] := l_pid_count -- Do not include merged processors in sync count.

				-- Resize meta data to allow for supplier processor meta data and any previous merge data.
			if (l_container_count + l_pid_count + (l_previous_pid_count * 2)) > l_request_chain_meta_data.count  then
				l_request_chain_meta_data := l_request_chain_meta_data.aliased_resized_area_with_default (null_processor_id, l_container_count + l_pid_count + (l_previous_pid_count * 2))
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
					l_wait_condition_counter = 0  -- Low Priority if there was a previous wait condition failure.
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
				l_request_chain_meta_data.put (l_request_chain_node_id, i + l_pid_count + l_previous_pid_count)
				l_request_chain_node_id := {ATOMIC_MEMORY_OPERATIONS}.increment_integer_32 (processor_meta_data [l_pid].item_address (current_request_chain_node_id_index))
				i := i + 1
			end

			if l_merge_needed then
					-- We need to merge the previous processor values with the new ones.
				check l_previous_request_chain_meta_data_attached: l_previous_request_chain_meta_data /= Void end
				from
					i := request_chain_meta_data_header_size
				until
					i = l_previous_container_pid_count_upper
				loop
						-- Add previous pid to new chain.
					l_request_chain_meta_data.put (l_previous_request_chain_meta_data [i], i + l_pid_count)
						-- Add previous request chain node id.
					l_request_chain_meta_data.put (l_previous_request_chain_meta_data [i + l_previous_pid_count], i + (2 * l_pid_count) + l_previous_pid_count)
					i := i + 1
				end
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
					l_wait_condition_counter = 0  -- Low priority if there is a wait condition failure.
				)

				i := i + 1
			end

			from
				i := request_chain_meta_data_header_size
			until
				i = l_container_count
			loop
				l_pid := l_request_chain_meta_data [i]
				l_request_chain_node_id := l_request_chain_meta_data [i + l_pid_count + l_previous_pid_count]

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

feature {NONE} -- Exceptions

	raise_scoop_exception (a_exception_message: STRING)
			-- Raise a SCOOP Exception using `a_exception_message'.
		do
			exception_helper.raise (a_exception_message)
		end

	exception_helper: EXCEPTIONS
		-- Helper object for exceptions.

feature -- Command/Query Handling

	is_processor_dirty (a_client_processor_id, a_supplier_processor_id: like processor_id_type): BOOLEAN
			-- Is `a_supplier_processor_id' dirty with respect to `a_client_processor_id'.
		local
			l_dirty_processor_client_list: detachable like new_request_chain_meta_data_entry
			i: INTEGER
			l_lock_request_return: INTEGER
		do
			l_dirty_processor_client_list := (request_chain_meta_data_stack_list [a_supplier_processor_id]) [Max_request_chain_depth]
			if l_dirty_processor_client_list /= Void then
				l_lock_request_return := request_processor_resource (
					processor_dirty_processor_client_list_lock_index,
					a_supplier_processor_id,
					a_client_processor_id,
					True, -- Wait until granted, we cannot continue until we have control over the value.
					False  -- Low Priority, wait is minimal as this is a temporary lock value
				)
				check resource_attained: l_lock_request_return = resource_lock_newly_attained end

					-- An uncaught exception has occurred on `a_supplier_processor_id' so we must check if `a_client_processor_id' is involved.
				from
					i := 0
				until
					i >= maximum_dirty_processor_client_count
				loop
					if l_dirty_processor_client_list [i] = a_client_processor_id then
						Result := True
						i := maximum_dirty_processor_client_count
					end
					i := i + 1
				end

				relinquish_processor_resource (
					processor_meta_data [a_supplier_processor_id].item_address (processor_dirty_processor_client_list_lock_index),
					a_client_processor_id,
					False
				)
			end
		end

	log_call_on_processor (a_client_processor_id, a_supplier_processor_id: like processor_id_type; a_routine: like routine_type; a_call_data: like call_data)
			-- Log call on `a_suppler_processor_id' for `a_client_processor_id'
		local
			l_client_request_chain_meta_data, l_supplier_request_chain_meta_data, l_creation_request_chain_meta_data: detachable like new_request_chain_meta_data_entry
			l_request_chain_node_id: like invalid_request_chain_node_id
			l_request_chain_node_queue: detachable like new_request_chain_node_queue
			l_client_request_chain_node_queue_entry, l_request_chain_node_queue_entry: detachable like new_request_chain_node_queue_entry
			l_unique_pid_count, i, l_last_pid_index, l_logged_calls_original_count, l_logged_calls_current_count: INTEGER_32
			l_is_synchronous, l_client_is_sibling, l_client_sync_needed, l_exit_loop: BOOLEAN
			l_call_ptr: POINTER
		do
			debug ("ISE_SCOOP_MANAGER")
				print ("log_call_on_processor for pid " + a_client_processor_id.out + " on pid " + a_supplier_processor_id.out + "%N")
			end

				-- Retrieve request chain node list so the call can be logged
			l_request_chain_node_queue := request_chain_node_queue_list [a_supplier_processor_id]
			check l_request_chain_node_queue_attached: attached l_request_chain_node_queue end

			l_is_synchronous := call_data_sync_pid (a_call_data) /= null_processor_id

				-- Initially mark the request chain node as invalid if not a creation routine
			if (processor_meta_data [a_supplier_processor_id])[current_request_chain_id_index] = 0 then
				l_request_chain_node_id := 0
			else
				l_request_chain_node_id := invalid_request_chain_node_id
			end

				-- Check if `a_supplier_processor_id' is dirty with respect to `a_client_processor_id'.
			if {ATOMIC_MEMORY_OPERATIONS}.add_integer_32 ((processor_meta_data [a_client_processor_id]).item_address (processor_dirty_flag_count_index), 0) > 0  then
					-- We need to check if `a_client_processor_id' is dirty with respect to `a_supplier_processor_id'.
				if is_processor_dirty (a_client_processor_id, a_supplier_processor_id) then
					raise_scoop_exception (scoop_dirty_processor_exception_message)
				end
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

			l_logged_calls_original_count := l_request_chain_node_queue_entry.count
			if l_logged_calls_original_count = l_request_chain_node_queue_entry.capacity then
					-- Resize node structure if there is not enough room for the new entry.
					--| FIXME Current resizing of 25% larger may not be optimal.
				if
					l_client_request_chain_meta_data /= Void and then
					{ATOMIC_MEMORY_OPERATIONS}.add_integer_32 (l_client_request_chain_meta_data.item_address (request_chain_status_index), 0) = request_chain_status_open
				then
						-- We can reuse the data structure if the chain is still open.
					l_request_chain_node_queue_entry := l_request_chain_node_queue_entry.aliased_resized_area ((l_logged_calls_original_count * 4) // 3)
				else
					l_request_chain_node_queue_entry := l_request_chain_node_queue_entry.resized_area ((l_logged_calls_original_count * 4) // 3)
				end
				l_request_chain_node_queue [l_request_chain_node_id] := l_request_chain_node_queue_entry
					-- Readd in case we have a new structure.
			end


			if (processor_meta_data [a_supplier_processor_id]) [processor_status_index] = processor_status_uninitialized then
					-- We have an uninitialized processor so we must be logging the creation routine.

				signify_start_of_request_chain (a_supplier_processor_id)
				assign_supplier_processor_to_request_chain (a_supplier_processor_id, null_processor_id)
				wait_for_request_chain_supplier_processor_locks (a_supplier_processor_id)

				l_creation_request_chain_meta_data := request_chain_meta_data [a_supplier_processor_id]
				check l_creation_request_chain_meta_data_attached: l_creation_request_chain_meta_data /= Void end

					-- Set `a_client_processor_id' as the initiator of the new processor creation request chain.
				l_creation_request_chain_meta_data [request_chain_client_pid_index] := a_client_processor_id;

					-- Mark processor as initializing to signify that the creation routine is being logged and executing.
				(processor_meta_data [a_supplier_processor_id]) [processor_status_index] := processor_status_initializing
			end

			if call_data_is_lock_passing (a_call_data) then
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

						-- Temporarily pass the locks of the client processor to the supplier processor.
					l_supplier_request_chain_meta_data := request_chain_meta_data [a_supplier_processor_id]

					increase_request_chain_depth (a_supplier_processor_id)
					update_request_chain_meta_data (a_supplier_processor_id, l_client_request_chain_meta_data)

						-- Store current logged call count to see if any feature application requests are made by the call.
					l_logged_calls_original_count := l_client_request_chain_node_queue_entry.count;

					l_request_chain_node_queue_entry.extend (a_call_data)

					if l_creation_request_chain_meta_data /= Void then
							-- We are lock passing to a creation routine so we start the loop.
						start_processor_application_loop (a_supplier_processor_id)
						wait_for_request_chain_to_begin (a_client_processor_id, a_supplier_processor_id, l_creation_request_chain_meta_data)
					end
						-- Wait for client processor to be signalled to continue.
						-- Note: asynchronous logged calls do not need signalling.
					processor_wait (a_client_processor_id, a_supplier_processor_id)

				until
					l_exit_loop
				loop
						-- We need to set the queue entry each time in case it has resized.
					l_client_request_chain_node_queue_entry := l_request_chain_node_queue [(processor_meta_data [a_client_processor_id])[current_request_node_id_execution_index]]
					check l_client_request_chain_node_queue_entry_attached: l_client_request_chain_node_queue_entry /= Void end
					l_logged_calls_current_count := l_client_request_chain_node_queue_entry.count
					if
						l_logged_calls_current_count > l_logged_calls_original_count
					then
							-- The supplier processor has logged back calls on the client processor after signalling.
							-- The supplier processor has either finished logging or is waiting on a client sync from a synchronous call.

							-- Find the next applicable call_data pointer.						
						from
							i := l_logged_calls_original_count
						until
							l_call_ptr /= null_pointer
						loop
							l_call_ptr := l_client_request_chain_node_queue_entry [i]
							if l_call_ptr /= null_pointer then
								l_client_request_chain_node_queue_entry [i] := null_pointer
							end
							i := i + 1
						end

						if i = l_logged_calls_current_count then
								-- We are at the last logged item so we can reduce the structure back to the original size.
							l_client_request_chain_node_queue_entry.keep_head (l_logged_calls_original_count)
						end

						l_is_synchronous := call_data_sync_pid (l_call_ptr) /= null_processor_id
						scoop_command_call (l_call_ptr)
						if l_is_synchronous then
								-- Signal processor to continue
							processor_wake_up (a_supplier_processor_id, a_client_processor_id)

								-- Make client processor wait until either another synchronous call has been logged or the initial logged call has completed.
							processor_wait (a_client_processor_id, a_supplier_processor_id)
						end
						scoop_command_call_cleanup (l_call_ptr)
						l_call_ptr := null_pointer
					else
							-- Reset supplier processors request chain meta data to previous state.
						update_request_chain_meta_data (a_supplier_processor_id, default_request_chain_meta_data_entry)
						decrease_request_chain_depth (a_supplier_processor_id)
						request_chain_meta_data [a_supplier_processor_id] := l_supplier_request_chain_meta_data

						if l_creation_request_chain_meta_data /= Void then
								-- Here we wait for the creation routine to finish.
							l_creation_request_chain_meta_data [request_chain_status_index] := request_chain_status_waiting
							processor_wait (a_client_processor_id, a_supplier_processor_id)
								-- The new processor is waiting for us to close the chain so we do so and then signal it to continue.
							signify_end_of_request_chain (a_supplier_processor_id)
								-- Flag new processor as initialized as the creation routine has now executed.
							(processor_meta_data [a_supplier_processor_id]) [processor_status_index] := processor_status_initialized
							processor_wake_up (a_supplier_processor_id, a_client_processor_id)
						end
						l_exit_loop := True
					end
				end
			else
					-- Add call to request chain node then wait/sync as needed.
				l_request_chain_node_queue_entry.extend (a_call_data)
				if l_is_synchronous then
					if l_client_sync_needed then
						processor_wake_up (a_supplier_processor_id, a_client_processor_id)
					end
					processor_wait (a_client_processor_id, a_supplier_processor_id)
				elseif l_creation_request_chain_meta_data /= Void then
						-- We are logging an asynchronous creation routine.
					start_processor_application_loop (a_supplier_processor_id)
					wait_for_request_chain_to_begin (a_client_processor_id, a_supplier_processor_id, l_creation_request_chain_meta_data)
					l_creation_request_chain_meta_data [request_chain_status_index] := request_chain_status_waiting
					processor_wait (a_client_processor_id, a_supplier_processor_id)
						-- The new processor is waiting for us to close the chain so we do so and then signal it to continue.
					signify_end_of_request_chain (a_supplier_processor_id)
							-- Flag new processor as initialized as the creation routine has now executed.
					(processor_meta_data [a_supplier_processor_id]) [processor_status_index] := processor_status_initialized
					processor_wake_up (a_supplier_processor_id, a_client_processor_id)
				end
			end

				-- If we are a synchronous call and we have a dirty flag set then we should check if `a_supplier_processor_id' is dirty with respect to `a_client_processor_id'.
			if l_is_synchronous and then {ATOMIC_MEMORY_OPERATIONS}.add_integer_32 ((processor_meta_data [a_client_processor_id]).item_address (processor_dirty_flag_count_index), 0) > 0  then
				if is_processor_dirty (a_client_processor_id, a_supplier_processor_id) then
						-- Fire exception in client
					raise_scoop_exception (scoop_dirty_processor_exception_message)
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
				l_chain_status > request_chain_status_open or else l_counter > Max_yield_counter
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
						processor_wait (a_client_processor_id, a_supplier_processor_id)
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

feature {NONE} -- Implementation

	frozen call_data_sync_pid (a_call_data: like call_data): INTEGER_16
		external
			"C macro use %"eif_scoop.h%""
		end

	frozen call_data_is_lock_passing (a_call_data: like call_data): BOOLEAN
		external
			"C macro use %"eif_scoop.h%""
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

				-- Initialize exception handling helper object.
			create exception_helper

				-- Initialize the default attributes used to create each SCOOP processor.
			create default_processor_attributes.make_with_stack_size (processor_default_stack_size)

			default_request_chain_meta_data_entry := new_request_chain_meta_data_entry (null_processor_id)

			from
				i := 1
				create l_processor_meta_data.make_empty (max_scoop_processors_instantiable)
				create request_chain_meta_data.make_filled (default_request_chain_meta_data_entry, max_scoop_processors_instantiable)
				create l_request_chain_meta_data_stack_list.make_empty (max_scoop_processors_instantiable)
			until
				i > Max_scoop_processors_instantiable
			loop
				l_request_chain_meta_data_stack_list.extend (new_request_chain_meta_data_stack_list_entry)
				l_processor_meta_data.extend (new_processor_meta_data_entry)
					--| FIXME: Free semaphore list when application exits
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
			assign_supplier_processor_to_request_chain (root_processor_id, null_processor_id)
			wait_for_request_chain_supplier_processor_locks (root_processor_id)
			l_request_chain_meta_data := request_chain_meta_data [root_processor_id]
			check l_request_chain_meta_data_attached: attached l_request_chain_meta_data end
			l_request_chain_meta_data [request_chain_status_index] := request_chain_status_application

				-- Make root processor as initializing.
			processor_meta_data [root_processor_id].put (processor_status_initializing, processor_status_index)
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

				--| FIXME: Destroy processor semaphore when resources are freed.
			processor_semaphore_list [a_processor_id] := new_semaphore (0)

			(processor_meta_data [a_processor_id]).put (0, current_request_chain_id_index)
			(processor_meta_data [a_processor_id]).put (0, current_request_chain_node_id_index)
			(processor_meta_data [a_processor_id]).put (0, processor_dirty_flag_count_index)
			(processor_meta_data [a_processor_id]).put (0, processor_wait_condition_counter_index)

				-- Reset execution index to `0'
			(processor_meta_data [a_processor_id]).put (0, current_request_node_id_execution_index)
		end

	scoop_processor_loop (a_logical_processor_id: like processor_id_type)
			-- Entry point for all scoop processors, each unique identified by `a_logical_processor_id'.
		local
			l_loop_exit: BOOLEAN
			l_processor_meta_data: like new_processor_meta_data_entry
			l_executing_node_id: like invalid_request_chain_node_id
			l_executing_node_id_cursor: INTEGER_32
			l_request_chain_node_queue: detachable like new_request_chain_node_queue
			l_executing_request_chain_node: detachable like new_request_chain_node_queue_entry
			l_request_chain_node_meta_data_queue: detachable like new_request_chain_node_meta_data_queue
			l_executing_request_chain_node_meta_data: detachable like new_request_chain_node_meta_data_queue_entry
			l_exception_caught: BOOLEAN
			l_orig_sync_count, l_temp_count: INTEGER
			l_wait_counter: NATURAL_32
			l_call_ptr: POINTER
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
				l_processor_meta_data [processor_status_index] = processor_status_redundant
					-- Loop until the processor is marked as surplus to requirements.
			loop
					--| This is needed so that any pending gc cycles are correctly handled
					--| as this is a tight loop without any call to RTGC
				check_for_gc

				if l_processor_meta_data [processor_status_index] >= processor_status_initializing then
						-- SCOOP processor is initializing/initialized so we can check current index

						-- Retrieve execution index
					l_executing_node_id := l_processor_meta_data [current_request_node_id_execution_index]

					l_executing_request_chain_node_meta_data := l_request_chain_node_meta_data_queue [l_executing_node_id]
					if
						l_executing_request_chain_node_meta_data /= Void and then l_executing_request_chain_node_meta_data [request_chain_status_index] /= request_chain_status_uninitialized
							-- We only allow feature application to occur when the chain is correctly set.
					then
							-- We are in a valid feature application position as the request chain has been initialized.
						from
							if a_logical_processor_id = l_executing_request_chain_node_meta_data [request_chain_meta_data_head_pid_index] then
								l_orig_sync_count := {ATOMIC_MEMORY_OPERATIONS}.add_integer_32 (l_executing_request_chain_node_meta_data.item_address (request_chain_sync_counter_index), 0)
									-- We are a head node, set sync count to minus original sync count
								if l_orig_sync_count > 1 then
										-- We only need synchronization if there are tail nodes involved.

										-- Flag `a_logical_processor_id' as waiting.
									processor_wait (a_logical_processor_id, a_logical_processor_id)

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

										-- Flag processor as woken up.
									processor_wake_up (a_logical_processor_id, a_logical_processor_id)

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
										processor_wake_up (l_executing_request_chain_node_meta_data [request_chain_client_pid_index], a_logical_processor_id)
									else
										check request_chain_status_closed: l_temp_count = request_chain_status_closed end
									end
								end
							else
									-- We are a tail node, we wait for head node to set pid count to negative value. (as we are a tail node then there must be at least two processors involved)

									-- Flag `a_logical_processor_id' as waiting.
								processor_wait (a_logical_processor_id, a_logical_processor_id)

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

									-- Flag processor as woken up.
								processor_wake_up (a_logical_processor_id, a_logical_processor_id)

								l_temp_count := {ATOMIC_MEMORY_OPERATIONS}.increment_integer_32 (l_executing_request_chain_node_meta_data.item_address (request_chain_sync_counter_index))
							end

							l_executing_node_id_cursor := 0
							l_wait_counter := 0
							l_loop_exit := False
							l_exception_caught := False
						until
							l_loop_exit
						loop
							l_executing_request_chain_node := l_request_chain_node_queue [l_executing_node_id]
							check l_executing_request_chain_node_attached: attached l_executing_request_chain_node end
							l_temp_count := l_executing_request_chain_node.count
							if l_exception_caught then
									-- If an exception has occurred then we must not continue applying calls and exit immediately.
								l_loop_exit := True
								l_request_chain_node_meta_data_queue [l_executing_node_id] := Void
							elseif l_executing_node_id_cursor < l_temp_count then
								l_call_ptr := l_executing_request_chain_node [l_executing_node_id_cursor]
								if l_call_ptr /= null_pointer then
									l_exception_caught := scoop_command_call_with_exception_check (l_call_ptr)
									if l_exception_caught then
										-- An exception was raised during application of `l_call_ptr'.
										-- We need to flag `a_logical_processor_id' dirty with respect to the client of the chain.

											-- We have caught an assertion violation so we flag the processor as dirty
										flag_processor_dirty (a_logical_processor_id, l_executing_request_chain_node_meta_data, l_executing_request_chain_node, l_executing_node_id_cursor)
									end
									if (l_executing_node_id_cursor + 1) = l_temp_count then
											-- Check for a query if we are at the last index.
										if call_data_sync_pid (l_call_ptr) /= null_processor_id then
											processor_wake_up (call_data_sync_pid (l_call_ptr), a_logical_processor_id)
												-- Reset yielding.
											l_wait_counter := 0
										end
									end
									l_executing_node_id_cursor := l_executing_node_id_cursor + 1
								end
							elseif l_executing_request_chain_node_meta_data [request_chain_status_index] = request_chain_status_closed then
									-- Request chain has been fully closed therefore we can exit if all calls have been applied.
								if l_executing_node_id_cursor >= l_temp_count then
									l_loop_exit := True
									l_request_chain_node_meta_data_queue [l_executing_node_id] := Void
								end
							elseif
								l_executing_request_chain_node_meta_data [request_chain_status_index] = request_chain_status_waiting and then
								a_logical_processor_id = l_executing_request_chain_node_meta_data [request_chain_meta_data_header_size]
							then
									-- The chain status is set to waiting and we are the head pid so we must be a creation routine
									-- Signal client processor to wake up and wait until signalled to continue.
								processor_wake_up (l_executing_request_chain_node_meta_data [request_chain_client_pid_index], a_logical_processor_id)
								processor_wait (a_logical_processor_id, l_executing_request_chain_node_meta_data [request_chain_client_pid_index])

									-- Reset yielding.
								l_wait_counter := 0
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
						from
							l_wait_counter := 0
							l_loop_exit := False
							l_temp_count := {ATOMIC_MEMORY_OPERATIONS}.increment_integer_32 ($idle_processor_count)
						until
							l_loop_exit
						loop
							l_loop_exit := l_request_chain_node_meta_data_queue [l_processor_meta_data [Current_request_node_id_execution_index]] /= Void
							if not l_loop_exit then
								if idle_processor_count /= processor_count then
										-- Make sure that the processor stays in the feature application loop.
									l_processor_meta_data [processor_status_index] := processor_status_initialized
								else
									if l_processor_meta_data [processor_status_index] /= processor_status_redundant then
										l_wait_counter := 0
										l_processor_meta_data [processor_status_index] := processor_status_redundant
									end
										--| FIXME Update exiting code when GC support is available.
									if l_wait_counter > Processor_spin_lock_limit then
										l_loop_exit := True
									end
								end
								processor_is_idle (a_logical_processor_id, l_wait_counter)
								l_wait_counter := l_wait_counter + 1
							else
									-- Make sure the the processor stays in the feature application loop.
								l_processor_meta_data [processor_status_index] := processor_status_initialized
							end
						end
						l_temp_count := {ATOMIC_MEMORY_OPERATIONS}.decrement_integer_32 ($idle_processor_count)
						if l_processor_meta_data [processor_status_index] = processor_status_redundant then
							l_temp_count := {ATOMIC_MEMORY_OPERATIONS}.decrement_integer_32 ($processor_count)
						end
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
			if a_wait_counter > max_yield_counter then
					-- Fully relinquish processor.
				processor_sleep (processor_sleep_quantum)
			end
		end

	deadlock_counter: NATURAL_16
		-- Counter for deadlock detection.

	previous_waiting_processor_count: like waiting_processor_count
		-- Previous number of waiting processors, used for deadlock detection.

	deadlock_detection_limit: NATURAL_16 = 1000
		-- Number of iterations an idle processor

	scoop_command_call_with_exception_check (a_data: like call_data): BOOLEAN
			-- Apply scoop call represented by `a_data'.
			-- Return `True' if an exception was raised.
		do
			if not Result then
				scoop_command_call (a_data)
			end
		rescue
			Result := True
			retry
		end

	scoop_command_call (a_data: like call_data)
			-- Make scoop call from call data `a_data'.
		external
			"C macro use %"eif_scoop.h%""
		alias
			"eif_try_call"
		end

	scoop_command_call_cleanup (a_data: like call_data)
			-- Free scoop call data in `a_data'.
		external
			"C macro use %"eif_scoop.h%""
		alias
			"eif_free_call"
		end

	null_pointer: POINTER
		external
			"C macro use %"eif_scoop.h%""
		alias
			"NULL"
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
				if not a_high_priority then
						-- Make sure processors yield CPU if low priority
					l_wait_counter := processor_spin_lock_limit
				end
			until
				l_exit
			loop
					-- Use `a_resource_type' to determine what kind of resource of `a_requesting_processor' needs from `a_resource_processor'.
					-- Be it exclusive access to request queue, or for access to processor locks for lock passing.
				if not a_high_priority then
						-- Yield before attempting request for low priority attempts.
					processor_yield (a_requesting_processor, l_wait_counter)
				end

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
						processor_yield (a_requesting_processor, l_wait_counter)
						l_wait_counter := l_wait_counter + 1
					else
						-- We don't have the lock and we do not block so we exit and return False.
						Result := resource_lock_unattained
						processor_yield (a_requesting_processor, l_wait_counter)
						l_exit := True
					end
				end
			end
		end

	frozen check_for_gc
			-- Hack needed to force the gc to kick in when code is in a tight loop.
		external
			"C macro use %"eif_scoop.h%""
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
				processor_yield (a_requesting_processor, processor_spin_lock_limit)
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

	scoop_dirty_processor_exception_message: STRING = "SCOOP Processor Dirty Exception"
		-- Exception message when a client processor has logged a call on a supplier processor that raises an exception.

	scoop_processor_deadlock_detected_message: STRING = "SCOOP Processor Deadlock Detected"

	scoop_request_chain_stack_overflow_message: STRING = "SCOOP Request Chain Stack Overflow"

feature {NONE} -- Atomic Access

	processor_count: INTEGER_32
		-- Total number of processors currently available to the system.

	waiting_processor_count: INTEGER_32
		-- Number of processors that are currently block waiting for other processors.

	waiting_semaphore_count: INTEGER_32
		-- Number of processors that are waiting for their semaphore to be signalled.

	idle_processor_count: INTEGER_32
		-- Number of processors that are at the end of their queue.
		-- If equal to processor_count then the system may exit,

feature {NONE} -- Scoop Processor Meta Data

	default_processor_attributes: ISE_SCOOP_PROCESSOR_ATTRIBUTES
			-- Default scoop processor thread attributes.

	routine_type: NATURAL_32 do end
	call_data: POINTER do end
	result_type: POINTER do end

	max_scoop_processors_instantiable: INTEGER_32 = 1536
		-- Total Number of SCOOP Processors that may be instantiated by Pool including Root.

	processor_default_stack_size: INTEGER_32 = 1_048_576
		-- Size in bytes of stack size of processor.

	max_wait_condition_retry_limit: INTEGER_32 = 10000
		-- Maximum number of retries a wait condition may have before raising an exception.

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

	processor_wait (a_client_processor_id, a_supplier_processor_id: like processor_id_type)
			-- Make processor `a_client_processor_id' wait until its semaphore is signalled.
		local
			l_waiting_count, l_waiting_semaphore_count: INTEGER
		do
			l_waiting_count := {ATOMIC_MEMORY_OPERATIONS}.increment_integer_32 ($waiting_processor_count)
			if a_supplier_processor_id /= a_client_processor_id then
				l_waiting_semaphore_count := {ATOMIC_MEMORY_OPERATIONS}.increment_integer_32 ($waiting_semaphore_count)
				if l_waiting_semaphore_count = processor_count then
					raise_scoop_exception (scoop_processor_deadlock_detected_message)
				end
				semaphore_client_wait (processor_semaphore_list [a_client_processor_id])
			end
		end

	processor_wake_up (a_client_processor_id, a_supplier_processor_id: like processor_id_type)
			-- Signal processor `a_client_processor_id' to wake up for `a_supplier_processor_id'
		local
			l_waiting_count, l_waiting_semaphore_count: INTEGER
		do
			if a_client_processor_id /= null_processor_id then
				l_waiting_count := {ATOMIC_MEMORY_OPERATIONS}.decrement_integer_32 ($waiting_processor_count)
				if a_client_processor_id /= a_supplier_processor_id then
					l_waiting_semaphore_count := {ATOMIC_MEMORY_OPERATIONS}.decrement_integer_32 ($waiting_semaphore_count)
					semaphore_supplier_signal (processor_semaphore_list [a_client_processor_id])
				end
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

	semaphore_supplier_signal (a_sem_address: POINTER)
			-- Signal semaphore `a_sem_address'.
		require
			a_sem_address_valid: a_sem_address /= default_pointer
		external
			"C macro use <eif_threads.h>"
		alias
			"eif_thr_sem_post"
		end

	new_processor_meta_data_entry: SPECIAL [INTEGER_32]
			-- New Processor Meta Data Value Entry
		do
			create Result.make_filled (null_processor_id, processor_meta_data_index_count)
		end

	request_chain_meta_data: SPECIAL [like new_request_chain_meta_data_entry]
			-- Holder of Processor Request Chain Meta Data (indexed by logical processor ID)

	request_chain_meta_data_stack_list: SPECIAL [like new_request_chain_meta_data_stack_list_entry]
			-- Holder of Processor Request Chain Meta Data (indexed by logical processor ID)

	new_request_chain_meta_data_stack_list_entry: SPECIAL [detachable like new_request_chain_meta_data_entry]
		do
			create Result.make_filled (Void, request_chain_meta_data_stack_list_entry_size)
		end

	request_chain_meta_data_stack_list_entry_size: NATURAL_8 = 16
		-- Default depth of the request chain meta data stack.

	max_request_chain_depth: INTEGER = 15
		-- Maximum request chain depth.
		-- `request_chain_meta_data_stack_list_entry_size' - 1

	new_request_chain_meta_data_entry (a_client_processor_id: like processor_id_type): SPECIAL [INTEGER_32]
			-- New Request Chain Meta Data
		do
			create Result.make_empty (request_chain_meta_data_default_size)
				-- Add meta data header default values.
			Result.extend (0) -- pid count
			Result.extend (a_client_processor_id)
			Result.extend (invalid_request_chain_id)
			Result.extend (request_chain_status_uninitialized)
			Result.extend (0) -- sync count
			check request_chain_header_set: Result.count = request_chain_meta_data_header_size end
			-- Format = {pid_count, client pid, client pid request chain id, node status, sync count, head_pid, tailx_pid, head request chain node id, tail request chain node id}
		end

	default_request_chain_meta_data_entry: like new_request_chain_meta_data_entry
		-- Default request chain meta data entry.

	request_chain_pid_count_index: NATURAL_8 = 0
	request_chain_client_pid_index: NATURAL_8 = 1
	request_chain_client_pid_request_chain_id_index: NATURAL_8 = 2
	request_chain_status_index: NATURAL_8 = 3
	request_chain_sync_counter_index: NATURAL_8 = 4
			-- Index values for request chain states

	request_chain_status_uninitialized: INTEGER_8 = -1
	request_chain_status_open: INTEGER_8 = 0
	request_chain_status_application: INTEGER_8 = 1
	request_chain_status_waiting: INTEGER_8 = 2
	request_chain_status_closed: INTEGER_8 = 3
	request_chain_status_dirty: INTEGER_8 = 4
		-- Various state constants for a request chain.

	request_chain_meta_data_default_size: INTEGER_32 = 11
		-- meta data header + (3 * supplier PID request chain meta data)
	request_chain_meta_data_header_size: INTEGER_32 = 5
		-- Size of request chain meta data header {pid_count, client pid, client pid request chain id, node status}

	request_chain_meta_data_head_pid_index: INTEGER_32 = 5
		-- Index of head processor id in the request chain.

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

	processor_status_redundant: INTEGER_32 = 0
		-- Processor is redundant.

	processor_status_initializing: INTEGER_32 = 1
		-- Processor is being initialized by executing its creation routine.
	processor_status_initialized: INTEGER_32 = 2
		-- Processor is fully initialized and executing.

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
		-- Lock index used for accessing current request chain node id.

	processor_reference_count_index: INTEGER_32 = 7
		-- Current reference count of the processor

	processor_dirty_flag_count_index: INTEGER_32 = 8
		-- Number of processors that are dirty with respect to `Current'.

	processor_dirty_processor_client_list_lock_index: INTEGER_32 = 9
		-- Lock index used for accessing the dirty processor client list.

	processor_wait_condition_counter_index: INTEGER_32 = 10
		-- Index of the number of times a wait condition has failed.

	processor_meta_data_index_count: INTEGER_32 = 11
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
			elseif a_iteration_number < max_yield_counter then
				processor_cpu_yield
			else
					-- Check for any potential deadlock.
				if
					waiting_processor_count > 0 and then
					waiting_processor_count = previous_waiting_processor_count and then
					(waiting_processor_count + idle_processor_count = processor_count)
				then
					deadlock_counter := deadlock_counter + 1
				else
					deadlock_counter := 0
				end
				previous_waiting_processor_count := waiting_processor_count
				if deadlock_counter > deadlock_detection_limit then
					raise_scoop_exception (scoop_processor_deadlock_detected_message)
				else
					processor_cpu_yield
				end
			end
		end

	processor_spin_lock_limit: NATURAL_32 = 100
		-- Number of iterations to spin lock until yielding.

	max_yield_counter: NATURAL_32 = 10_000
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

feature {NONE} -- Debugger Helpers

	frozen processor_id_from_object (a_object: ANY): like processor_id_type
		external
			"C inline use %"eif_scoop.h%""
		alias
			"RTS_PID($a_object)"
		end

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
			"[
				#ifdef WORKBENCH
					return ((call_data*) $a_call_data)->body_index;
				#endif
			]"
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
