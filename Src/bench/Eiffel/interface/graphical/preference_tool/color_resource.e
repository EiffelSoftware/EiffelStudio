indexing
 
	description:
		"A resource value for color resources.";
	date: "$Date$";
	revision: "$Revision$"
 
class COLOR_RESOURCE
 
inherit
	STRING_RESOURCE
		redefine
			set_value, make, make_with_values
		end
 
creation
	make,
	make_with_values

feature {NONE} -- Initialization

	make_with_values (a_name: STRING; a_value: STRING) is
			-- Initialie Current
		do
			name := a_name;
			value := a_value;
			if a_value /= Void then
				set_value (a_value)
			end
		end;
 
	make (a_name: STRING; rt: RESOURCE_TABLE; def_value: STRING) is
			-- Initialize Current
		do
			default_value := def_value;
			make_with_values (a_name, rt.get_string (a_name, def_value));
		end

feature -- Access

	actual_value: COLOR
			-- Color value of resource

	valid_actual_value: COLOR is
			-- Non void color value
		do
			Result := actual_value;	
			if Result = Void then
				Result := default_color
			end
		ensure
			valid_result: Result /= Void
		end;

	default_color: COLOR is
			-- Default color
		once
			!! Result.make
			Result.set_name ("black")
		end;

feature -- Status setting

	set_value (new_value: STRING) is
			-- Set `value' to `new_value'.
		do
			value := new_value;
			if new_value.is_empty then
				actual_value := Void
			else
				!! actual_value.make;
				actual_value.set_name (new_value)
			end
		end;

end -- class COLOR_RESOURCE
