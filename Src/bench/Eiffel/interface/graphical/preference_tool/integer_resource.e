indexing

	description:
		"A resource value for integer resouorces.";
	date: "$Date$";
	revision: "$Revision$"

class INTEGER_RESOURCE

inherit
	RESOURCE

creation
	make

feature {NONE} -- Initialization

	make (a_name: STRING; an_int: INTEGER) is
			-- Initialize Current
		do
			actual_value := an_int;
			value := an_int.out;
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
			actual_value := value.to_integer
		end;

	set_actual_value (an_int: INTEGER) is
			-- Set `actual_value' to `an_int' and update `value'.
		do
			actual_value := an_int;
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
			Result := a_value.is_integer
		end

feature -- Properties

	actual_value: INTEGER;
			-- Value represented by Current

	default_value: INTEGER;
			-- Default value if resource not found in a resource file

	value: STRING
			-- Value as a `STRING' as represented by Current

end -- class INTEGER_RESOURCE
