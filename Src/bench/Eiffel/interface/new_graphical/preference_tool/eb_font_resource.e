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
	make_default

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
			create actual_value.make_by_system_name (a_string)
		end

	make (a_name: STRING; rt: RESOURCE_TABLE; def_value: EV_FONT) is
			-- Initialize Current
		do
			name := a_name
			default_value := def_value
			create actual_value.make_by_system_name (rt.get_string (a_name, def_value.name))
		end

	make_default (a_name: STRING; rt: RESOURCE_TABLE; def_name: STRING) is
			-- Initialize Current
		local
			dv: EV_FONT
		do
			create dv.make_by_system_name (def_name)
			make (a_name, rt, dv)
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
			-- Oops! creates borber effect. to be redone.
		local
			font: EV_FONT
		do
			if not a_value.empty then
				create font.make
				font.set_name (a_value)
				Result := True
			else
				Result := True
			end
		end

	is_default: BOOLEAN is
			-- Has the resource not changed from the default value?
		do
			Result := equal (default_string_value, value)
		end

feature -- Status Setting

	set_value (new_value: STRING) is
			-- Set `value' to `new_value'.
		do
			if not new_value.empty then	
				create actual_value.make
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

end -- class EB_FONT_RESOURCE
