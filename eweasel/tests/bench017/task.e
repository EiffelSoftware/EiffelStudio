note
	description: "A task consisting of some operation between matrices."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	TASK

inherit
	HELPER

create
	make

feature {NONE}-- Initialization

	make (operation_count: INTEGER; a_matrix_size: INTEGER)
			-- Initialization for `Current'.
		do
			matrix_size := a_matrix_size
			remaining_operations := operation_count
			create random.make_time
			create history.make (operation_count)
			create start_matrix.make_random (matrix_size)
			create left_matrix.duplicate (start_matrix)
			generate_subtask
		end


feature -- Access

	remaining_operations: INTEGER

feature -- Task description

	left_matrix: SQUARE_MATRIX

	right_matrix: SQUARE_MATRIX

	task_number: INTEGER

feature -- Basic operations

	generate_subtask
			-- Create a new matrix operation to be executed.
		require
			remaining_operations > 0
		do
			task_number := random.new_integer \\ max_task_number
			create right_matrix.make_random (matrix_size)
			history.extend ([task_number, right_matrix])
			remaining_operations := remaining_operations - 1
		rescue
			print ("Error: In rescue.%N")
		end

	validate
			-- Check that the series of operations, currently executed by different processors, yield the same result.
		local
			tuple: TUPLE [task: INTEGER; matrix: SQUARE_MATRIX]
			check_matrix: SQUARE_MATRIX
		do
			across
				history as cursor
			from
				create check_matrix.duplicate (start_matrix)
			loop
				tuple := cursor.item
				execute_task (tuple.task, check_matrix, tuple.matrix)
			end

			if check_matrix /~ left_matrix then
				print ("Error: Matrix different.%N")
			end
		rescue
			print ("Error: In rescue.%N")
		end

feature {NONE} -- Implementation

	matrix_size: INTEGER

	random: SIMPLE_RANDOM

	start_matrix: SQUARE_MATRIX

	history: ARRAYED_LIST [TUPLE [task: INTEGER; matrix: SQUARE_MATRIX]]

end
