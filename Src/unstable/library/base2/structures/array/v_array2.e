note
	description: "[
		Two-dimensional arrays.
		Indexing of rows and columns starts from 1.
		]"
	author: "Nadia Polikarpova"
	model: matrix

class
	V_ARRAY2 [G]

inherit
	V_MUTABLE_SEQUENCE [G]
		rename
			item as flat_item,
			put as flat_put,
			at as flat_at
		redefine
			flat_put,
			copy,
			is_equal
		end

create
	make,
	make_filled

feature {NONE} -- Initialization

	make (n, m: INTEGER)
			-- Create array with `n' rows and `m' columns; set all values to default.
		require
			valid_dimensions: (n = 0 and m = 0) or (n > 0 and m > 0)
		do
			row_count := n
			column_count := m
			create array.make (1, n * m)
		ensure
			matrix_rows_effect: matrix.domain |=| create {MML_INTERVAL}.from_range (1, n)
			matrix_columns_effect: matrix.range.for_all (agent (r: MML_SEQUENCE [G]; m_: INTEGER): BOOLEAN
				do
					Result := r.domain |=| create {MML_INTERVAL}.from_range (1, m_) and r.is_constant (({G}).default)
				end (?, m))
		end

	make_filled (n, m: INTEGER; v: G)
			-- Create array with `n' rows and `m' columns; set all values to `v'.
		require
			valid_dimensions: (n = 0 and m = 0) or (n > 0 and m > 0)
		do
			row_count := n
			column_count := m
			create array.make_filled (1, n * m, v)
		ensure
			matrix_rows_effect: matrix.domain |=| create {MML_INTERVAL}.from_range (1, n)
			matrix_columns_effect: matrix.range.for_all (agent (r: MML_SEQUENCE [G]; m_: INTEGER; v_: G): BOOLEAN
				do
					Result := r.domain |=| create {MML_INTERVAL}.from_range (1, m_) and r.is_constant (v_)
				end (?, m, v))
		end

feature -- Initialization

	copy (other: like Current)
			-- Initialize by copying all the items of `other'.
		note
			modify: matrix
		do
			if other /= Current then
				row_count := other.row_count
				column_count := other.column_count
				array := other.array.twin
			end
		ensure then
			matrix_effect: matrix |=| other.matrix
		end

feature -- Access

	item alias "[]" (i, j: INTEGER): G assign put
			-- Item at row `i' and column `j'.
		require
			valid_row: has_row (i)
			valid_column: has_column (j)
		do
			Result := flat_item (flat_index (i, j))
		ensure
			definition: Result = (matrix [i]) [j]
		end

	flat_item (i: INTEGER): G assign flat_put
			-- Item at dlat index `i'.
		do
			Result := array [i]
		end

feature -- Measurement

	row_count: INTEGER
			-- Number of rows.

	column_count: INTEGER
			-- Number of columns.

	flat_index (i, j: INTEGER): INTEGER
			-- Flat index at row `i' and column `j'.
		require
			valid_row: has_row (i)
			valid_column: has_column (j)
		do
			Result := (i - 1) * column_count + j
		ensure
			definition: Result = (i - 1) * column_count + j
		end

	row_index (i: INTEGER): INTEGER
			-- Row that corresponds to flat index `i'.
		require
			valid_index: has_index (i)
		do
			Result := (i - 1) // column_count + 1
		ensure
			definition: Result = (i - 1) // column_count + 1
		end

	column_index (i: INTEGER): INTEGER
			-- Column that corresponds to flat index `i'.
		require
			valid_index: has_index (i)
		do
			Result := (i - 1) \\ column_count + 1
		ensure
			definition: Result = (i - 1) \\ column_count + 1
		end

	Lower: INTEGER = 1
			-- Lower flat index.

	upper: INTEGER
			-- Upper flat_index.
		do
			Result := row_count * column_count
		end

feature -- Search

	has_row (i: INTEGER): BOOLEAN
			-- Does array contain row `i'?
		do
			Result := 1 <= i and i <= row_count
		ensure
			definition: Result = (1 <= i and i <= row_count)
		end

	has_column (j: INTEGER): BOOLEAN
			-- Does array contain column `j'?
		do
			Result := 1 <= j and j <= column_count
		ensure
			definition: Result = (1 <= j and j <= column_count)
		end

feature -- Iteration

	flat_at (i: INTEGER): V_ARRAY_ITERATOR [G]
			-- New iterator pointing at flat position `i'.
		do
			create Result.make (Current, i)
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Is array made of the same items as `other'?
			-- (Use reference comparison.)
		do
			if other = Current then
				Result := True
			else
				Result := row_count = other.row_count and array ~ other.array
			end
		ensure then
			definition: Result = (matrix |=| other.matrix)
		end

feature -- Replacement

	put (v: G; i, j: INTEGER)
			-- Replace value at row `i' and column `j' with `v'.
		note
			modify: matrix
		require
			valid_row: has_row (i)
			valid_column: has_column (j)
		do
			flat_put (v, flat_index (i, j))
		ensure
			matrix_effect: matrix |=| old matrix.replaced_at (i, matrix [i].replaced_at (j, v))
		end

	flat_put (v: G; i: INTEGER)
			-- Replace value at position `i' with `v'.
		note
			modify: matrix
		do
			array.put (v, i)
		end

feature {V_CONTAINER, V_ITERATOR} -- Implemantation

	array: V_ARRAY [G]
			-- Flat representation.

feature -- Specification

	matrix: MML_SEQUENCE [MML_SEQUENCE [G]]
			-- Matrix or array elements.
		local
			i, j: INTEGER
			r: MML_SEQUENCE [G]
		do
			from
				i := 1
				create Result
			until
				i > row_count
			loop
				from
					j := 1
					create r
				until
					j > column_count
				loop
					r := r & item (i, j)
					j := j + 1
				end
				Result := Result & r
				i := i + 1
			end
		end

invariant
	row_count_definition: row_count = matrix.count
	column_count_definition_empty: matrix.is_empty implies column_count = 0
	column_count_definition_nonempty: not matrix.is_empty implies column_count = matrix.first.count

	matrix_constraint: matrix.range.for_all (agent (r: MML_SEQUENCE [G]): BOOLEAN
		do
			Result := not r.is_empty and r.count = column_count
		end)

	map_domain_definition: map.domain |=| create {MML_INTERVAL}.from_range (1, row_count * column_count)
	map_definition: map.domain.for_all (agent (i: INTEGER): BOOLEAN
		do
			Result := map [i] = (matrix [row_index (i)])[column_index (i)]
		end)
end
