indexing

	description:
		"A resource value for string resouorces.";
	date: "$Date$";
	revision: "$Revision$"

class STRING_RESOURCE

inherit
	RESOURCE

creation
	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_string: STRING) is
			-- Initialize Current
		do
			value := a_string;
			name := a_name
		end

feature -- Setting

	set_actual_value, set_value (new_value: STRING) is
			-- Set `value' to `new_value'.
		do
			value := new_value;
		end;

feature -- Access

	is_valid (a_value: STRING): BOOLEAN is
			-- Is `a_value' valid for use in Current?
			--| Always `True'.
		do
			Result := True
		end

feature -- Properties

	default_value: STRING;
			-- Default value if resource not found in a resource file

	actual_value, value: STRING
			-- Value as a `STRING' as represented by Current

end -- class STRING_RESOURCE
