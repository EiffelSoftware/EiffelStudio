indexing

	description:
		"A resource value for boolean resources.";
	date: "$Date$";
	revision: "$Revision$"

class BOOLEAN_RESOURCE

inherit
	RESOURCE

creation
	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_bool: BOOLEAN) is
			-- Initialize Current.
		do
			actual_value := a_bool;
			value := a_bool.out;
			name := a_name
		end

feature -- Setting

	set_value (new_value: STRING) is
			-- Set `value' to `new_value' and update `actual_value'.
		do
			value := new_value;
			update_actual_value
		end;

	update_actual_value is
			-- Update `actual_value', using `value'.
		require
			is_valid_value: is_valid (value)
		do
			actual_value := value.to_boolean
		end;

	set_actual_value (a_bool: BOOLEAN) is
			-- Set `actual_value' to `a_bool' and update `value'.
		do
			actual_value := a_bool;
			update_value
		end;

	update_value is
			-- Update `value', using `actual_value'.
		do
			value := actual_value.out
		end

feature -- Access

	is_valid (a_value: STRING): BOOLEAN is
			-- Is `a_value' valid for use in Current?
		do
			Result := a_value.is_boolean
		end

feature -- Properties

	actual_value: BOOLEAN
			-- Value represented by Current

	default_value: BOOLEAN
			-- Default value if resource not found in a resource file

	value: STRING
			-- Value as a `STRING' as represented by Current

end -- class BOOLEAN_RESOURCE
