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
			name := a_name
		end

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

feature -- Access

	is_valid (a_value: STRING): BOOLEAN is
			-- Is `a_value' valid for use in Current?
		do
			Result := a_value.is_boolean
		end

feature -- Properties

	actual_value: BOOLEAN
			-- Value represented by Current

	value: STRING is
			-- Value as a `STRING' as represented by Current
		do
			Result := actual_value.out
		end

end -- class BOOLEAN_RESOURCE
