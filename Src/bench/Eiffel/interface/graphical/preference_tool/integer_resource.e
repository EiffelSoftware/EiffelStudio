indexing

	description:
		"A resource value for integer resources.";
	date: "$Date$";
	revision: "$Revision$"

class INTEGER_RESOURCE

inherit
	RESOURCE

creation
	make,
	make_with_values

feature {NONE} -- Initialization

	make_with_values (a_name: STRING; a_value: INTEGER) is
			-- Initialie Current
		do
			name := a_name;
			actual_value := a_value
		end;

	make (a_name: STRING; rt: RESOURCE_TABLE; def_value: INTEGER) is
			-- Initialize Current
		do
			actual_value := rt.get_integer (a_name, def_value);
			default_value := def_value;
			name := a_name
		end

feature -- Access

	default_value, actual_value: INTEGER;
			-- Value represented by Current

	value: STRING is
			-- Value as a `STRING' as represented by Current
		do
			Result := actual_value.out
		end;

	has_changed: BOOLEAN is
			-- Has the resource changed from the default value?
		do
			Result := default_value /= actual_value
		end;

	is_valid (a_value: STRING): BOOLEAN is
			-- Is `a_value' valid for use in Current?
		do
			Result := a_value.is_integer
		end

feature -- Setting

	set_value (new_value: STRING) is
			-- Set `value' to `new_value' and update `actual_value'.
		do
			actual_value := new_value.to_integer;
		end;

	set_actual_value (an_int: INTEGER) is
			-- Set `actual_value' to `an_int' and update `value'.
		do
			actual_value := an_int
		end;

end -- class INTEGER_RESOURCE
