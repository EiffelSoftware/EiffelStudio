indexing

	description:
		"A resource value for string resources."
	date: "$Date$"
	revision: "$Revision$"

class
	FONT_RESOURCE

inherit
	STRING_RESOURCE
		redefine
			make, set_value, is_valid, get_value
		end

creation
	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_value: STRING) is
			-- Initialize Current
		do
			name := a_name
			default_value := a_value
			value := a_value
			if value /= Void and then not value.empty then
				!! actual_value.make_by_system_name (value)
				--!! actual_value.make
				--actual_value.set_name(value)
				if actual_value.destroyed then
					io.error.putstring ("Warning: Could not allocate font ")
					io.error.putstring (value)
					io.error.putstring (" for resource ")
					io.error.putstring (name)
					io.error.new_line
					actual_value := default_font
				end
			end
		end

feature -- Access

	get_value: EV_FONT is
		-- No use
		do
			Result := actual_value
		end

	actual_value: EV_FONT
			-- Font value

	valid_actual_value: EV_FONT is
			-- A non void font value
		do
			Result := actual_value
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
			font: EV_FONT
		do
			if not a_value.empty then
				create font.make_by_name(a_value)
				Result := font.destroyed
			end
		end

	default_font: EV_FONT is
			-- Default value if resource not found in a resource file
		once
			create Result.make_by_name("fixed")
		end

feature -- Setting

	set_value (new_value: STRING) is
			-- Set `value' to `new_value'.
		do
			if not new_value.empty then	
				create actual_value.make_by_system_name(new_value)
			else
				actual_value := Void
			end
			value := new_value
		end

end -- class FONT_RESOURCE
