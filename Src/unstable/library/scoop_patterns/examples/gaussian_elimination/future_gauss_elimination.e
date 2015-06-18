note
	description: "A system of linear equations that uses the future pattern for gaussian elimination."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	FUTURE_GAUSS_ELIMINATION

inherit
	LINEAR_EQUATION_SYSTEM [LINEAR_EQUATION]

create
	make_random, make_from_array

feature -- Access

	item (row_index, column_index: INTEGER): DOUBLE
			-- <Precursor>
		do
			Result := equations [row_index].i_th (column_index)
		end

feature -- Basic operations

	set_item (i, k: INTEGER; value: DOUBLE)
			-- Assign `value' to matrix position [i,k].
		do
			equations [i].put_i_th (value, k)
		end

feature -- Advanced operations

	solve
			-- Solve the system of linear equations using gaussian elimination.
		local
			worker_pool: separate CP_TASK_WORKER_POOL
			executor: CP_FUTURE_EXECUTOR_PROXY [LINEAR_EQUATION, CP_STATIC_TYPE_IMPORTER [LINEAR_EQUATION]]
			promises: ARRAYED_QUEUE [CP_RESULT_PROMISE_PROXY [LINEAR_EQUATION, CP_STATIC_TYPE_IMPORTER [LINEAR_EQUATION]]]

			task: ROW_SUBTRACTION_TASK
			pivot: INTEGER
			k: INTEGER
		do
				-- Initialize the worker pool.
			create worker_pool.make (50, 4)
			create executor.make (worker_pool)

			create promises.make (count)

			from
				pivot := 1
			until
				pivot > count or is_singular
			loop
					-- The pivot should not be zero.
					-- Swap rows if necessary.
				adjust_rows (pivot)

					-- Check if there is a non-zero pivot.
				if not is_singular then

						-- Start all futures.
					from
						k := pivot + 1
					until
						k > count
					loop
						create task.make (equations [pivot], equations [k], pivot)
						promises.put (executor.put_and_get_result_promise (task))
						k := k + 1
					end

						-- Write back the results.
					from
						k := pivot + 1
					until
						k > count
					loop
							-- May block if the result is not yet available.
						check attached promises.item.item as l_item then
							equations [k] := l_item
						end
						promises.remove
						k := k + 1
					end
				end

				pivot := pivot + 1
			variant
				count + 1 - pivot
			end

				-- Stop the worker pool such that the application can terminate.
			executor.stop
		end

feature {NONE} -- Implementation

	new_equation (a_count: INTEGER): LINEAR_EQUATION
			-- <Precursor>
		do
			create Result.make_filled (a_count)
		end

end
