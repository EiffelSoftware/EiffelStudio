indexing

	description:
		"A resource value for string resources."
	date: "$Date$"
	revision: "$Revision$"

class
	STRING_RESOURCE

inherit
	RESOURCE

creation
	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_value: STRING) is
			-- Initialize Current
		require
			valid_name: a_name /= Void
			valid_value: a_value /= Void
		do
			name := a_name
			value := a_value
			default_value := a_value
		end

feature -- Access

	default_value, value: STRING
			-- Value as a `STRING' as represented by Current

	has_changed: BOOLEAN is
			-- Has the resource changed from the default value?
		do
			Result := not equal (default_value, value)
		end

feature -- Setting

	set_value (new_value: STRING) is
			-- Set `value' to `new_value'.
		do
			value := new_value
		end

	mark_saved is
		do
			default_value := value
		end

feature -- Access

	is_valid (a_value: STRING): BOOLEAN is
			-- Is `a_value' valid for use in Current?
		local
--			lexer: RESOURCE_STRING_LEX
			str: STRING
		do
--			if not a_value.empty then
--				if a_value @ 1 /= '%"' then
--					!! str.make (0)
--					str.extend ('%"')
--					str.append (a_value)
--				else
--					str := clone (value)
--				end
--				if str @ str.count /= '%"' then
--					str.extend ('%"')
--				end
--				!! lexer
--				Result := lexer.is_value_valid (str)
--			else
				Result := True
--			end
		end

feature -- Output

	xml_trace: STRING is
			-- XML representation of current
		do
			Result := "<TEXT>"
			Result.append (name)
			Result.append ("<STRING>")
			Result.append (value)
			Result.append ("</STRING></TEXT>")
		end

	registry_name: STRING is
			-- name of Current in the registry
		do
			Result := name
		end


end -- class STRING_RESOURCE
