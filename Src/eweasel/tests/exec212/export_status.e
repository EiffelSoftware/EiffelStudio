expanded class
	EXPORT_STATUS

create
	default_create,
	make_from_integer

convert
	make_from_integer ({INTEGER}),
	to_integer: {INTEGER}

feature {NONE} -- Initialization

	make_from_integer (i: INTEGER) is
			-- Initializes instance from integer `i'.
		require
			i_is_member: i >= min_member and i <= max_member
		do
			value := i
		ensure
			value_set: value = i
		end

feature -- Enum Members

	exports_none: INTEGER is 0
			-- Indicates that features are not exported

	exports_some: INTEGER is 1
			-- Indicates that features are exported to a number of clients, but not all

	exports_all: INTEGER is 2
			-- -- Indicates that features are exported

feature -- Access

	min_member: INTEGER is
			-- Minimum value member
		do
			Result := exports_none
		end

	max_member: INTEGER is
			-- Maximum value member
		do
			Result := exports_all
		end

feature -- Conversion

	to_integer: INTEGER is
			-- Converts `Current' to an INTEGER
		do
			Result := value
		ensure
			result_set: Result = value
		end

feature {NONE} -- Implementation

	value: INTEGER
			-- Internal value

invariant
	value_is_member: value >= min_member and value <= max_member

end
