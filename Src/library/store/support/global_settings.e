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

	is_decimal_used: BOOLEAN
			-- Is decimal type used?
		do
			Result := is_decimal_used_cell.item
		end

feature -- Decimal

	default_decimal_presicion: INTEGER
			-- Default presicion of decimal. Used when creating tables etc.
		do
			Result := default_decimal_presicion_cell.item
		end

	default_decimal_scale: INTEGER
			-- Default scale of decimal. Used when creating tables etc.
		do
			Result := default_decimal_scale_cell.item
		end

	decimal_creation_function: FUNCTION [TUPLE [digits: STRING_8; sign, precision, scale: INTEGER], ANY]
			-- Function to create decimal
		do
			Result := decimal_creation_function_cell.item
		end

	decimal_factor_function: FUNCTION [ANY, TUPLE [digits: STRING_8; sign, precision, scale: INTEGER]]
			-- Function to get base type to form a decimal from a given ANY object.
		do
			Result := decimal_factor_function_cell.item
		end

	is_decimal_function: FUNCTION [ANY, BOOLEAN]
			-- Fuction to check if an object is a decimal
		do
			Result := is_decimal_function_cell.item
		end

	decimal_output_function: FUNCTION [ANY, STRING_8]
			-- Function to output a decimal for the purpose of building correct SQL statement
		do
			Result := decimal_output_function_cell.item
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

	set_decimal_functions (a_decimal_creation_func: like decimal_creation_function;
							a_is_decimal_func: like is_decimal_function;
							a_decimal_factor_func: like decimal_factor_function;
							a_decimal_output_func: like decimal_output_function
							)
		do
			decimal_creation_function_cell.put (a_decimal_creation_func)
			is_decimal_function_cell.put (a_is_decimal_func)
			decimal_factor_function_cell.put (a_decimal_factor_func)
			decimal_output_function_cell.replace (a_decimal_output_func)
		end

	set_default_decimal_presicion (a_presicsion: INTEGER)
			-- Set `default_decimal_presicion'
		do
			default_decimal_presicion_cell.replace (a_presicsion)
		end

	set_default_decimal_scale (a_scale: INTEGER)
			-- Set `default_decimal_scale'
		do
			default_decimal_scale_cell.replace (a_scale)
		end

	set_is_decimal_used (a_b: BOOLEAN)
			-- Set `is_decimal_used' with `a_b'.
		do
			is_decimal_used_cell.replace (a_b)
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

	is_decimal_used_cell: CELL [BOOLEAN]
			-- Cell to hold the global value `is_decimal_used'.
		once
			create Result.put (False)
		end

	default_decimal_presicion_cell: CELL [INTEGER]
			-- Cell to hold the global value `default_decimal_presicion'.
		once
			create Result.put (19)
		end

	default_decimal_scale_cell: CELL [INTEGER]
			-- Cell to hold the global value `default_scale_presicion'.
		once
			create Result.put (4)
		end

	decimal_creation_function_cell: CELL [FUNCTION [TUPLE [digits: STRING_8; sign, precision, scale: INTEGER], ANY]]
			-- Cell to hold `decimal_creation_function'
		once
			create Result.put (
				agent (a_digits: STRING_8; a_sign, a_precision, a_scale: INTEGER): ANY do Result := 0 end
			)
		end

	is_decimal_function_cell: CELL [FUNCTION [ANY, BOOLEAN]]
			-- Cell to hold `is_decimal_function'
		once
			create Result.put (
				agent (a_obj: ANY): BOOLEAN do end
			)
		end

	decimal_factor_function_cell: CELL [FUNCTION [ANY, TUPLE [digits: STRING_8; sign, precision, scale: INTEGER]]]
			-- Cell to hold `decimal_factor_function'
		once
			create Result.put (
				agent (a_obj: ANY): TUPLE [digits: STRING_8; sign, precision, scale: INTEGER] do Result := ["0", 1, 1, 0] end
			)
		end

	decimal_output_function_cell: CELL [FUNCTION [ANY, STRING_8]]
		once
			create Result.put (
				agent (a_obj: ANY): STRING_8 do Result := "0" end
			)
		end

end
