indexing

	description:
		"A resource value for string resouorces.";
	date: "$Date$";
	revision: "$Revision$"

class FONT_RESOURCE

inherit
	STRING_RESOURCE
		redefine
			make, set_value, is_valid, make_with_values
		end

creation
	make,
	make_with_values

feature {NONE} -- Initialization

    make_with_values (a_name: STRING; a_value: STRING) is
            -- Initialie Current
        do
            name := a_name;
            value := a_value
        end;

	make (a_name: STRING; rt: RESOURCE_TABLE; def_value: STRING) is
			-- Initialize Current
		do
			name := a_name
			default_value := def_value;
			value := rt.get_string (a_name, def_value);
			if value /= Void and then not value.is_empty then
				!! actual_value.make
				actual_value.set_name (value);
				if not actual_value.is_font_valid then
					io.error.putstring ("Warning: Could not allocate font ")
					io.error.putstring (value)
					io.error.putstring (" for resource ")
					io.error.putstring (name)
					io.error.new_line
					actual_value := default_font;
				end;
				value := actual_value.name
			end
		end

feature -- Access

	actual_value: FONT
			-- Font value

	valid_actual_value: FONT is
			-- A non void font value
		do
			Result := actual_value;
			if Result = Void then
				Result := default_font
			end
		ensure
			valid_result: Result /= Void
		end;

	is_valid (a_value: STRING): BOOLEAN is
			-- Is `a_value' valid for use in Current?
			--| Always `True'.
		local
			font: FONT
		do
			if not a_value.is_empty then
				!! font.make;
				font.set_name (a_value);
				Result := font.is_font_valid
			else
				Result := True
			end
		end

	default_font: FONT is
			-- Default value if resource not found in a resource file
		once
			!! Result.make
			Result.set_name ("fixed")
		end

feature -- Setting

	set_value (new_value: STRING) is
			-- Set `value' to `new_value'.
		do
			if not new_value.is_empty then	
				!! actual_value.make;
				actual_value.set_name (new_value)
			else
				actual_value := Void
			end
			value := new_value
		end;

end -- class FONT_RESOURCE
