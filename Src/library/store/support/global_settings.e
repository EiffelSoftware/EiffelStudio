note
	description: "Global settings for the library."
	date: "$Date$"
	revision: "$Revision$"

class
	GLOBAL_SETTINGS

feature -- Query

	use_extended_types: BOOLEAN
			-- Use extended types? STRING_32 etc.
		do
			Result := use_extended_types_cell.item
		end

	map_zero_null_value: BOOLEAN
			-- Map zero to NULL value for numeric types?
		do
			Result := map_zero_null_value_cell.item
		end

feature -- Status Change

	set_use_extended_types (a_b: BOOLEAN)
			-- Set `use_extended_types' with `a_b'.
		do
			use_extended_types_cell.put (a_b)
		end

	set_map_zero_null_value (a_b: BOOLEAN)
			-- Set `map_zero_null_value' with `a_b'.
		do
			map_zero_null_value_cell.put (a_b)
		end

feature {NONE} -- Implementation

	use_extended_types_cell: CELL [BOOLEAN]
			-- Cell to hold the global value `use_extended_types'.
		once
			create Result.put (False)
		end

	map_zero_null_value_cell: CELL [BOOLEAN]
			-- Cell to hold the global value `map_zero_null_value'.
		once
			create Result.put (True)
		end

end
