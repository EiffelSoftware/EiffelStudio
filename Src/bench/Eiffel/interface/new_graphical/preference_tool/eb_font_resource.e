indexing
	description:
		"A resource value for font resources."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FONT_RESOURCE

inherit
	EB_RESOURCE
		redefine
			set_value, is_valid
		end

creation
	make,
	make_from_string,
	make_with_values,
	make_from_old

feature {NONE} -- Initialization

	make_with_values (a_name: STRING; a_font: EV_FONT) is
		-- Initialize Current
	do
		name := a_name
		actual_value := a_font
	end

	make_from_string (a_name: STRING; a_string: STRING) is
		-- Initialize Current
	do
		name := a_name
		Create actual_value.make_by_system_name (a_string)
	end

	make (a_name: STRING; rt: RESOURCE_TABLE; def_value: EV_FONT) is
			-- Initialize Current
		do
			name := a_name
			default_value := def_value
			Create actual_value.make_by_name (rt.get_string (a_name, def_value.name))
--			if not actual_value.is_valid then
--				io.error.putstring ("Warning: Could not allocate font ")
--				io.error.putstring (value)
--				io.error.putstring (" for resource ")
--				io.error.putstring (name)
--				io.error.new_line
--				actual_value := default_font
--			end
		end

feature -- Access

	default_value, actual_value: EV_FONT
			-- Font value

	value: STRING is
		do
			Result := actual_value.name
		end

--	valid_actual_value: EV_FONT is
--			-- A non void font value
--		do
--			Result := actual_value
--			if Result = Void then
--				Result := default_font
--			end
--		ensure
--			valid_result: Result /= Void
--		end

	default_font: EV_FONT is
			-- Default value if resource not found in a resource file
		once
			!! Result.make
			Result.set_name ("fixed")
		end

feature -- Status report

	is_valid (a_value: STRING): BOOLEAN is
			-- Is `a_value' valid for use in Current?
			--| Always `True'.
		local
			font: FONT
		do
			if not a_value.empty then
				!! font.make
				font.set_name (a_value)
				Result := font.is_font_valid
			else
				Result := True
			end
		end

	is_default: BOOLEAN is
			-- Has the resource changed from the default value?
		do
			Result := not equal (default_value, actual_value)
		end

	has_changed: BOOLEAN is
			-- Has the resource changed from the default value?
		do
			Result := not equal (default_value, actual_value)
		end

feature -- Status Setting

	set_value (new_value: STRING) is
			-- Set `value' to `new_value'.
		do
			if not new_value.empty then	
				!! actual_value.make
				actual_value.set_name (new_value)
			else
				actual_value := Void
			end
		end

	set_actual_value (a_font: EV_FONT) is
			-- Set `value' to `new_value'.
		do
			actual_value := a_font
		end

feature {NONE} -- Obsolete

	make_from_old (old_r: FONT_RESOURCE) is
		do
			make_from_string (old_r.name, old_r.value)
		end

end -- class EB_FONT_RESOURCE
