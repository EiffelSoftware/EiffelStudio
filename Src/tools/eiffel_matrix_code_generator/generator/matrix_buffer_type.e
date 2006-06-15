indexing
	description: "[
		State an scanner token lister will be in after a motion action.
	]"
	date:        "$Date$"
	revision:    "$Revision$"

expanded class
	MATRIX_BUFFER_TYPE

inherit
	HASHABLE

create
	default_create,
	make_from_integer

convert
	make_from_integer ({INTEGER}),
	to_integer: {INTEGER}

feature {NONE} -- Initialization

	make_from_integer (i: INTEGER) is
			-- Initializes instance from integer `i'.
			--
			-- `i': An {INTEGER} value corresponding to a member.
		require
			i_is_value_member: value_member (i)
		do
			value := i
		ensure
			value_set: value = i
		end

feature -- Scanner States

	implementation: INTEGER is 0x0
			-- Implementation buffer

	access: INTEGER is 0x01
			-- Access buffer

feature -- Access

	min_member: INTEGER is
			-- Minimum value member
		do
			Result := implementation
		end

	max_member: INTEGER is
			-- Maximum value member
		do
			Result := access
		end

feature -- HASHABLE Implementation

	hash_code: INTEGER is
			-- Hash code value
		do
			Result := value
		end

feature -- Conversion

	to_integer: INTEGER is
			-- Converts `Current' to an {INTEGER}
		do
			Result := value
		ensure
			result_set: Result = value
		end

feature -- Query

	value_member (i: like value): BOOLEAN is
			-- Does `i' correspond to a value member?
		do
			Result := i = implementation or i = access
		end

feature {NONE} -- Implementation

	value: INTEGER
			-- Internal value

invariant
	value_is_value_member: value_member (value)

end -- class {MATRIX_BUFFER_TYPE}
