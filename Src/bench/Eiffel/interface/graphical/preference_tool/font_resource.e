indexing

	description:
		"A resource value for string resouorces.";
	date: "$Date$";
	revision: "$Revision$"

class FONT_RESOURCE

inherit
	RESOURCE

creation
	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_string: STRING) is
			-- Initialize Current
		do
			name := a_name
			if a_string /= Void and then not a_string.empty then
				!! actual_value.make
				actual_value.set_name (a_string);
				if not actual_value.is_font_valid then
					io.error.putstring ("Warning: Could not allocate font ")
					io.error.putstring (a_string)
					io.error.putstring (" for resource ")
					io.error.putstring (name)
					io.error.new_line
					actual_value := default_value
				end
			end
		end

feature -- Setting

	set_value (new_value: STRING) is
			-- Set `value' to `new_value'.
		do
			if new_value = Void or else new_value.empty then	
				!! actual_value.make;
				actual_value.set_name (new_value)
			else
				actual_value := Void
			end
		end;

feature -- Access

	is_valid (a_value: STRING): BOOLEAN is
			-- Is `a_value' valid for use in Current?
			--| Always `True'.
		local
			font: FONT
		do
			if a_value /= Void and then not a_value.empty then
				!! font.make;
				font.set_name (a_value);
				Result := font.is_font_valid
			else
				Result := True
			end
		end

feature -- Properties

	default_value: FONT is
			-- Default value if resource not found in a resource file
		once
			!! Result.make
			Result.set_name ("fixed")
		end

	value: STRING is
			-- Value as a `STRING' as represented by Current
		do
			if actual_value /= Void then
				Result := actual_value.name
			end
		end

	actual_value: FONT
			-- Font value

end -- class FONT_RESOURCE
