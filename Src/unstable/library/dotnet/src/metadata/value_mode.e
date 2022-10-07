note
	description: "Mode for the initialized value"
	date: "$Date$"
	revision: "$Revision$"

once class
	VALUE_MODE
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

	instances: ITERABLE [VALUE_MODE]
			-- All known value modes.
		do
			Result := <<
					{VALUE_MODE}.None,
					{VALUE_MODE}.Enum,
					{VALUE_MODE}.Bytes
				>>
		ensure
			is_class: class
		end

end
