indexing

	description:
		"A resource value for boolean resources.";
	date: "$Date$";
	revision: "$Revision$"

class BOOLEAN_RESOURCE

inherit
	RESOURCE

creation
	make,
	make_with_values

feature {NONE} -- Initialization

	make_with_values (a_name: STRING; a_value: BOOLEAN) is
		-- Initialie Current
		do
			name := a_name;
			actual_value := a_value
		end;

	make (a_name: STRING; rt: RESOURCE_TABLE; def_value: BOOLEAN) is
			-- Initialize Current.
		do
			actual_value := rt.get_boolean (a_name, def_value);
			default_value := def_value;
			name := a_name
		end

feature -- Access

	default_value, actual_value: BOOLEAN
			-- Value represented by Current

	value: STRING is
			-- Value as a `STRING' as represented by Current
		do
			Result := actual_value.out
		end

	is_valid (a_value: STRING): BOOLEAN is
			-- Is `a_value' valid for use in Current?
		do
			Result := a_value.is_boolean
		end;

	has_changed: BOOLEAN is
			-- Has the resource changed from the default value?
		do
			Result := actual_value /= default_value
		end;

feature -- Setting

	set_value (new_value: STRING) is
			-- Set `value' to `new_value' and update `actual_value'.
		do
			actual_value := new_value.to_boolean;
		end;

	set_actual_value (a_bool: BOOLEAN) is
			-- Set `actual_value' to `a_bool' and update `value'.
		do
			actual_value := a_bool;
		end;

end -- class BOOLEAN_RESOURCE
