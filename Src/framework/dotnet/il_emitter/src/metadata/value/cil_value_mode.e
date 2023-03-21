note
	description: "Mode for the initialized value"
	date: "$Date$"
	revision: "$Revision$"

once class
	CIL_VALUE_MODE
create
	None,
	Enum,
	Bytes

feature {NONE} -- Creation

	None
			-- No initialized value
		once end

	Enum
			--  Enumerated value, goes into the constant table
		once end

	Bytes
			-- Byte stream, goes into the sdata
		once end

feature -- Instances

	instances: ITERABLE [CIL_VALUE_MODE]
			-- All known value modes.
		do
			Result := <<
					{CIL_VALUE_MODE}.None,
					{CIL_VALUE_MODE}.Enum,
					{CIL_VALUE_MODE}.Bytes
				>>
		ensure
			is_class: class
		end

end
