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
			name := a_name
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

feature -- Access

	is_valid (a_value: STRING): BOOLEAN is
			-- Is `a_value' valid for use in Current?
		do
			Result := a_value.is_integer
		end

feature -- Properties

	actual_value: INTEGER;
			-- Value represented by Current

	value: STRING is
			-- Value as a `STRING' as represented by Current
		do
			Result := actual_value.out
		end

end -- class INTEGER_RESOURCE
