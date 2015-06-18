note
	description: "Systems of linear equations represented as a matrix."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	LINEAR_EQUATION_SYSTEM [G -> separate LINEAR_EQUATION]

inherit
	ANY
		redefine
			out
		end

feature {NONE} -- Initialization

	make_zero (a_count: INTEGER)
			-- Create a new, zero-filled linear equation system.
		local
			i: INTEGER
		do
			create equations.make (a_count)

			from
				i := 1
			until
				i > a_count
			loop
				equations.extend (new_equation (a_count + 1))
				i := i + 1
			variant
				a_count + 1 - i
			end
		ensure
			correct_count: count = a_count
		end

	make_random (a_count: INTEGER)
			-- Create a new linear equation system with random values.
		local
			i, k: INTEGER
			random: RANDOM
			time: TIME
		do
			make_zero (a_count)
			create time.make_now
			create random.set_seed (time.seconds)

			from
				i := 1
			until
				i > count
			loop
				from
					k := 1
				until
					k > count + 1
				loop
					set_item (i,k, random.double_item)
					random.forth
					k := k + 1
				end
				i := i + 1
			end
		end

	make_from_array (array: ARRAY [ARRAY [DOUBLE]])
			-- Initialize `Current' with the values in `array'.
		require
			correct_dimensions: array.count = array [1].count - 1
			uniform: across array as cursor all cursor.item.count = array [1].count end
		local
			i, k: INTEGER
		do
			make_zero (array.count)
			from
				i := 1
			until
				i > count
			loop
				from
					k := 1
				until
					k > count + 1
				loop
					set_item (i,k, (array[i])[k])
					k := k + 1
				end
				i := i + 1
			end
		end

feature -- Access

	equations: ARRAYED_LIST [G]
			-- The linear equations in the system.

	count: INTEGER
			-- Number of equations (rows) in the system.
		do
			Result := equations.count
		end

	item (row_index, column_index: INTEGER): DOUBLE
			-- Element at position [row_index, column_index].
		require
			valid_row: 0 < row_index and row_index <= count
			valid_column: 0 < column_index and column_index <= count+1
		deferred
		end

feature -- Status report

	is_singular: BOOLEAN
			-- Is the matrix singular?
			-- Note: Always False unless `solve' is called.

feature -- Basic operations

	set_item (i, k: INTEGER; value: DOUBLE)
			-- Assign `value' to matrix position [i,k].
		deferred
		end

	swap (i, k: INTEGER)
			-- Swap rows i and k.
		do
			equations.go_i_th (i)
			equations.swap (k)
		end

feature -- Advanced operations

	solve
			-- Solve the linear equation system using gaussian elimination.
		deferred
		end

	adjust_rows (pivot: INTEGER)
			-- Search for the row with the biggest absolute value and swap it with `pivot' row.
		local
			max: DOUBLE
			max_index: INTEGER

			k: INTEGER
			l_item: DOUBLE
		do
				-- Find the element with the maximum absolute value.
			from
				k := pivot
				max := 0.0
				max_index := 0
			until
				k > count
			loop
				l_item := item (k, pivot)
				l_item := l_item.abs

				if l_item > max then
					max := l_item
					max_index := k
				end
				k := k + 1
			variant
				count + 1 - k
			end

				-- Swap the two rows.
			if max_index = 0 then
				is_singular := True
			elseif pivot /= max_index then
				swap (pivot, max_index)
			end
		end

feature -- Output

	out: STRING
			-- <Precursor>
		local
			l_item: DOUBLE
			l_str: STRING
			i,k: INTEGER

			formatter: FORMAT_DOUBLE
		do
			from
				i := 1
				create Result.make_empty
				create formatter.make (5,2)
				formatter.right_justify
			until
				i > count
			loop
				from
					k := 1
				until
					k > count + 1
				loop
					l_item := item (i,k)
					l_str := formatter.formatted (l_item)

					Result.append (l_str + "%T")
					k := k + 1
				end
				Result.append ("%N")
				i := i + 1
			end
			if is_singular then
				Result.append ("Note: Matrix was singular!%N")
			end
		end

feature {NONE} -- Implementation

	new_equation (a_count: INTEGER): G
			-- Create a new, zero,filled equation with `a_count' elements.
		deferred
		end

end
