note
	description: "[
			Two-dimensional arrays.
			Indexing of rows and columns starts from 1.
		]"
	author: "Nadia Polikarpova"
	revised_by: "Alexander Kogtenkov"
	model: sequence, column_count
	manual_inv: true
	false_guards: true

class
	V_ARRAY2 [G]

inherit
	V_MUTABLE_SEQUENCE [G]
		rename
			item as flat_item,
			put as flat_put,
			at as flat_at
		redefine
			upper,
			is_equal_,
			is_model_equal
		end

create
	make,
	make_filled

feature {NONE} -- Initialization

	make (n, m: INTEGER)
			-- Create array with `n' rows and `m' columns; set all values to default.
		note
			status: creator
		require
			valid_dimensions: (n = 0 and m = 0) or (n > 0 and m > 0)
		do
			row_count := n
			column_count := m
			create array.make (1, n * m)
			create sequence.constant (({G}).default, n * m)
		ensure
			sequence_domain_definition: sequence.count = n * m
			sequence_definition: sequence.is_constant (({G}).default)
			column_count_definition: column_count = m
			no_observers: observers.is_empty
		end

	make_filled (n, m: INTEGER; v: G)
			-- Create array with `n' rows and `m' columns; set all values to `v'.
		note
			status: creator
		require
			valid_dimensions: (n = 0 and m = 0) or (n > 0 and m > 0)
		do
			row_count := n
			column_count := m
			create array.make_filled (1, n * m, v)
			create sequence.constant (v, n * m)
		ensure
			sequence_domain_definition: sequence.count = n * m
			sequence_definition: sequence.is_constant (v)
			column_count_definition: column_count = m
			no_observers: observers.is_empty
		end

feature -- Initialization

	copy_ (other: like Current)
			-- Initialize by copying all the items of `other'.
		require
			observers_open: across observers as o all o.is_open end
		do
			if other /= Current then
				row_count := other.row_count
				column_count := other.column_count
				other.unwrap
				create array.copy_ (other.array)
				other.wrap
				sequence := other.sequence
			end
		ensure then
			sequence_effect: sequence ~ other.sequence
			column_count_effect: column_count = other.column_count
			observers_open: across observers as o all o.is_open end
			modify_model (["sequence", "column_count"], Current)
			modify_field ("closed", other)
		end

feature -- Access

	item alias "[]" (i, j: INTEGER): G assign put
			-- Item at row `i' and column `j'.
		require
			valid_row: has_row (i)
			valid_column: has_column (j)
		do
			check inv end
			Result := flat_item (flat_index (i, j))
		ensure
			definition: Result = sequence [flat_index (i, j)]
		end

	flat_item (i: INTEGER): G assign flat_put
			-- Item at dlat index `i'.
		do
			check inv end
			Result := array [i]
		end

feature -- Measurement

	row_count: INTEGER
			-- Number of rows.

	column_count: INTEGER
			-- Number of columns.

	count: INTEGER
			-- Number of elements.
		do
			check inv end
			Result := row_count * column_count
		end

	flat_index (i, j: INTEGER): INTEGER
			-- Flat index at row `i' and column `j'.
		note
			status: functional
		require
			1 <= i and i <= row_count
			1 <= j and j <= column_count
		do
			Result := (i - 1) * column_count + j
		end

	row_index (i: INTEGER): INTEGER
			-- Row that corresponds to flat index `i'.
		note
			status: functional
		require
			non_empty: column_count > 0
		do
			Result := (i - 1) // column_count + 1
		end

	column_index (i: INTEGER): INTEGER
			-- Column that corresponds to flat index `i'.
		note
			status: functional
		require
			non_empty: column_count > 0
		do
			Result := (i - 1) \\ column_count + 1
		end

	Lower: INTEGER = 1
			-- Lower flat index.

	upper: INTEGER
			-- Upper flat_index.
		do
			check inv end
			Result := row_count * column_count
		end

feature -- Search

	has_row (i: INTEGER): BOOLEAN
			-- Does array contain row `i'?
		note
			status: functional
		do
			Result := 1 <= i and i <= row_count
		end

	has_column (j: INTEGER): BOOLEAN
			-- Does array contain column `j'?
		note
			status: functional
		do
			Result := 1 <= j and j <= column_count
		end

feature -- Iteration

	flat_at (i: INTEGER): V_ARRAY_ITERATOR [G]
			-- New iterator pointing at flat position `i'.
		note
			status: impure
		do
			check inv end
			create Result.make (Current, i)
		end

feature -- Comparison

	is_equal_ (other: like Current): BOOLEAN
			-- Is array made of the same items as `other'?
			-- (Use reference comparison.)
		do
			if other = Current then
				Result := True
			else
				check inv; other.inv; array.inv; other.array.inv end
				Result := column_count = other.column_count and array.is_equal_ (other.array)
			end
		end

feature -- Replacement

	put (v: G; i, j: INTEGER)
			-- Replace value at row `i' and column `j' with `v'.
		note
			explicit: wrapping
		require
			valid_row: has_row (i)
			valid_column: has_column (j)
			observers_open: across observers as o all o.is_open end
		do
			check inv end
			flat_put (v, flat_index (i, j))
		ensure
			sequence_effect: sequence ~ old sequence.replaced_at (flat_index (i, j), v)
			modify_model ("sequence", Current)
		end

	flat_put (v: G; i: INTEGER)
			-- Replace value at position `i' with `v'.
		do
			array.put (v, i)
			sequence := sequence.replaced_at (i, v)
		end

feature {V_CONTAINER, V_ITERATOR} -- Implemantation

	array: V_ARRAY [G]
			-- Flat representation.

feature -- Specification

	is_model_equal (other: like Current): BOOLEAN
			-- Is the abstract state of `Current' equal to that of `other'?
		note
			status: ghost, functional
		do
			Result := sequence ~ other.sequence and column_count = other.column_count
		end

invariant
	array_exists: array /= Void
	owns_definition: owns ~ create {MML_SET [ANY]}.singleton (array)
	array_lower_definition: array.lower_ = 1
	array_no_observers: array.observers.is_empty
	sequence_implementation: sequence = array.sequence
	lower_definition: lower_ = 1
	column_count_empty: sequence.is_empty implies column_count = 0
	column_count_nonempty: not sequence.is_empty implies column_count > 0
	row_count_definition: row_count * column_count = sequence.count

note
	date: "$Date$"
	revision: "$Revision$"
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
