--| FIXME to be remade, taking example on COLOR_RESOURCE
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
			make, set_value, is_valid, get_value, xml_trace, registry_name
		end

creation
	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_value: STRING) is
			-- Initialize Current
		do
			name := a_name
			default_value := a_value
			set_value (a_value)
--			if value /= Void and then not value.empty then
--				!! actual_value.make_by_system_name (value)
--				--!! actual_value.make
--				--actual_value.set_name(value)
--				if actual_value.destroyed then
--					io.error.putstring ("Warning: Could not allocate font ")
--					io.error.putstring (value)
--					io.error.putstring (" for resource ")
--					io.error.putstring (name)
--					io.error.new_line
--					actual_value := default_font
--				end
--			end
		end

feature -- Access

	get_value: EV_FONT is
		-- No use
		do
			Result := actual_value
		end

	actual_value: EV_FONT is
			-- Font value
		do
			if not value.empty then
				create Result
--				create Result.make_by_system_name (value)
			else
				Result := Void
			end
		end
--| FIXME
--| Christophe, 11 feb 2000
--| The font resource has to be remade.

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
--			font: EV_FONT
		do
--			if not a_value.empty then
--				create font.make_by_name(a_value)
--				Result := font.destroyed
--			end
			Result := True
		end

	default_font: EV_FONT is
			-- Default value if resource not found in a resource file
		once
			create Result
		end

feature -- Setting

	set_value (new_value: STRING) is
			-- Set `value' to `new_value'.
		do
--			if not new_value.empty then	
--				create actual_value.make_by_system_name(new_value)
--			else
--				actual_value := Void
--			end
			value := new_value
		end

feature -- Output

	xml_trace: STRING is
			-- XML representation of current
		do
			Result := "<TEXT>"
			Result.append (name)
			Result.append ("<FONT>")
			Result.append (value)
			Result.append ("</FONT></TEXT>")
		end

	registry_name: STRING is
			-- name of Current in the registry
		do
			Result := "EIFFON_" + name
		end


end -- class FONT_RESOURCE
