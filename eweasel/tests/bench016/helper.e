note
	description: "Shared features for the stress test."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	HELPER

feature -- Constants

	Multiplication: INTEGER = 0

	Addition: INTEGER = 1

	Subtraction: INTEGER = 2

	Elementwise_multiplication: INTEGER = 3

	Max_task_number: INTEGER = 4

feature -- Task execution

	execute_task (job: INTEGER; left, right: separate SQUARE_MATRIX)
		do
			inspect job
			when Multiplication then
				multiply (left, right)
			when Addition then
				plus (left, right)
			when Subtraction then
				minus (left, right)
			when Elementwise_multiplication then
				elementwise_multiply (left, right)
			else
				print ("Error: Unknown task type.%N")
			end
		end

feature {NONE} -- Matrix operations

	multiply (left, right: separate SQUARE_MATRIX)
			-- Compute the matrix product (`left' * `right') and store the result in `left'.
		require
			left.size = right.size
		local
			i, j, k, size: INTEGER
			sum: DOUBLE
			tmp: SQUARE_MATRIX
		do
				-- Compute the sum of (left*right) in a temporary matrix.
			size := left.size
			create tmp.make_random (size)

			from
				i := 0
			until
				i >= size
			loop
				from
					j := 0
				until
					j >= size
				loop
					from
						sum := 0.0
						k := 0
					until
						k >= size
					loop
						sum := sum + (matrix_item (left, i, k) * matrix_item (right, k,j))
						k := k + 1
					end
					tmp.put (i, j, sum)
					j := j + 1
				end
				i := i + 1
			end

				-- Store the result in `right'.
			from
				i := 0
			until
				i >= size
			loop
				from
					j := 0
				until
					j >= size
				loop
					matrix_put (left, i, j, tmp.item (i, j))
					j := j + 1
				end
				i := i + 1
			end
		end

	plus (left, right: separate SQUARE_MATRIX)
			-- Compute the matrix sum (`left' + `right') and store the result in `left'.
		require
			left.size = right.size
		local
			i, j, size: INTEGER
			res: DOUBLE
		do
			size := left.size
			from
				i := 0
			until
				i >= size
			loop
				from
					j := 0
				until
					j >= size
				loop
					res := matrix_item (left, i,j) + matrix_item (right, i, j)
					matrix_put (left, i, j, res)
					j := j + 1
				end
				i := i + 1
			end
		end

	minus (left, right: separate SQUARE_MATRIX)
			-- Compute the matrix sum (`left' - `right') and store the result in `left'.
		require
			left.size = right.size
		local
			i, j, size: INTEGER
			res: DOUBLE
		do
			size := left.size
			from
				i := 0
			until
				i >= size
			loop
				from
					j := 0
				until
					j >= size
				loop
					res := matrix_item (left, i,j) - matrix_item (right, i, j)
					matrix_put (left, i, j, res)
					j := j + 1
				end
				i := i + 1
			end
		end

	elementwise_multiply (left, right: separate SQUARE_MATRIX)
			-- Compute the elementwise matrix product (`left' .* `right') and store the result in `left'.
		require
			left.size = right.size
		local
			i, j, size: INTEGER
			res: DOUBLE
		do
			size := left.size
			from
				i := 0
			until
				i >= size
			loop
				from
					j := 0
				until
					j >= size
				loop
					res := matrix_item (left, i,j) * matrix_item (right, i, j)
					matrix_put (left, i, j, res)
					j := j + 1
				end
				i := i + 1
			end
		end

feature {NONE} -- SCOOP access features

	matrix_item (other: separate SQUARE_MATRIX; x,y: INTEGER): DOUBLE
		do
			Result := other.item (x,y)
		end

	matrix_put (other: separate SQUARE_MATRIX; x,y: INTEGER; val: DOUBLE)
		do
			other.put (x,y,val)
		end
end
