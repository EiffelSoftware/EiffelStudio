note
	description: "Version of STRING for use in verification."
	model: sequence

frozen class
	V_STRING

inherit
	V_HASHABLE
		redefine out end

create
	make_from_string,
	make_from_v_string,
	init

convert
	make_from_string ({STRING})

feature {NONE} -- Initialization

	make_from_string (a_string: STRING)
			-- Initialize with `a_string'.
		note
			status: creator
			status: skip
		do
			internal_string := a_string
		end

	make_from_v_string (a_string: V_STRING)
			-- Initialize with `a_string'.
		note
			status: creator
			status: skip
			explicit: contracts
		require
			a_string_not_void: a_string /= Void
		do
			internal_string := a_string.out
		ensure
			same_string: sequence = a_string.sequence
			default_is_wrapped: is_wrapped
		end

	init (a_sequence: MML_SEQUENCE [CHARACTER])
			-- Initialize with `a_sequence'.
		note
			status: ghost, creator
			status: skip
		do
			sequence := a_sequence
			check is_executable: False then end
		ensure
			same_string: sequence = a_sequence
		end

feature -- Access

	count: INTEGER
			-- Lenght of string.
		note
			status: skip
		require
			reads (Current)
		do
			Result := internal_string.count
		ensure
			definition: Result = sequence.count
		end

	item alias "[]" (i: INTEGER): CHARACTER
			-- Character at position `i'.
		note
			status: skip
		require
			1 <= i and i <= sequence.count
			reads (Current)
		do
			Result := internal_string.item (i)
		ensure
			definition: Result = sequence.item (i)
		end

	substring (i, j: INTEGER): V_STRING
			-- Substring from `i' to `j' (included).
		note
			status: skip
		require
			1 <= i and i <= j+1 and j <= sequence.count
			reads (Current)
		do
			Result := internal_string.substring (i, j)
		ensure
			is_fresh: Result.is_fresh
			definition: Result.sequence = sequence.interval (i, j)
		end

feature -- Status report

	is_empty: BOOLEAN
			-- Is string empty?
		note
			status: skip
		require
			reads (Current)
		do
			Result := internal_string.is_empty
		ensure
			definition: Result = sequence.is_empty
		end

feature -- Element change

	append (other: V_STRING)
			-- Append `other' to string.
		note
			explicit: contracts
			status: skip
		require
			other_not_void: other /= Void
		do
			internal_string.append (other.out)
		ensure
			definition: sequence = old sequence + other.sequence
		end

	multiply (n: INTEGER)
			-- Multiply content of this string `n' times.
		note
			status: skip
		require
			n >= 1
		do
			internal_string.multiply (n)
		ensure
			length: sequence.count = old sequence.count * n
			front_same: sequence.front (old sequence.count) = old sequence
		end

	prepend (other: V_STRING)
			-- Prepend `other' to this string.
		note
			status: skip
		require
			other_not_void: other /= Void
		do
			internal_string.prepend (other.out)
		ensure
			definition: sequence = other.sequence + old sequence
		end

	put (c: CHARACTER; i: INTEGER)
			-- Set character at position `i' to `c'.
		note
			status: skip
		require
			i_in_bounds: 1 <= i and i <= sequence.count
		do
			internal_string.put (c, i)
		ensure
			definition: sequence = old sequence.replaced_at (i, c)
		end

feature -- Removal

	remove (i: INTEGER)
			-- Remove character at position `i'.
		note
			status: skip
		require
			i_in_bounds: 1 <= i and i <= sequence.count
		do
			internal_string.remove (i)
		ensure
			definition: sequence = old sequence.removed_at (i)
		end

	remove_tail (n: INTEGER)
			-- Remove last `n' characters.
		note
			status: skip
		require
			n_not_negative: n >= 0
		do
			internal_string.remove_tail (n)
		end

	remove_head (n: INTEGER)
			-- Remove first `n' characters.
		note
			status: skip
		require
			n_not_negative: n >= 0
		do
			internal_string.remove_head (n)
		end

feature -- Operations

	plus alias "+" (other: V_STRING): V_STRING
			-- Concatenate string and `other'.
		note
			status: impure
			explicit: contracts
			status: skip
		require
			other_not_void: other /= Void
			closed: closed
		do
			Result := internal_string + other.out
		ensure
			fresh: Result.is_fresh
			wrapped: Result.is_wrapped
			definition: Result.sequence = sequence + other.sequence
			modify ([])
		end

feature -- Hashing

	hash_code: INTEGER
			-- Hash code.
		note
			status: skip
		do
			Result := internal_string.hash_code
		end

feature -- Specification

	sequence: MML_SEQUENCE [CHARACTER]
			-- Sequence of elements.
		note
			status: ghost
		attribute
			check is_executable: False then end
		end

	hash_code_: INTEGER
			-- Hash code in terms of abstract state.
		note
			explicit: contracts
			status: ghost
		do
			Result := 1
		end

	is_model_equal (other: like Current): BOOLEAN
			-- Is the abstract state of `Current' equal to that of `other'?
		note
			status: ghost
			explicit: contracts
		do
			Result := sequence = other.sequence
		ensure then
			definition: Result = (sequence = other.sequence)
		end

	lemma_transitive (x: like Current; ys: MML_SET [like Current])
			-- Property that follows from transitivity of `is_model_equal'.
		note
			status: lemma
		do
		end

feature -- Conversion

	out: STRING
			-- String representation.
		do
			Result := internal_string
		end

feature {NONE} -- Implementation

	internal_string: STRING
			-- Internal string.

invariant
	internal_string_not_void: internal_string /= Void

note
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
