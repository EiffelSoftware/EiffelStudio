indexing
	description:
		"A resource value for string resources."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_STRING_RESOURCE

inherit
	EB_RESOURCE

creation
	make,
	make_with_values,
	make_from_old

feature {NONE} -- Initialization

	make_with_values (a_name: STRING; a_value: STRING) is
			-- Initialize Current
		require else
			valid_value: a_value /= Void
		do
			name := a_name
			actual_value := a_value
		end

	make (a_name: STRING; rt: RESOURCE_TABLE; def_value: STRING) is
			-- Initialize Current from rt and def_value
		require else
			valid_value: def_value /= Void
		do
			name := a_name
			actual_value := rt.get_string (a_name, def_value)
			default_value := def_value
		end

feature -- Access

	default_value, actual_value: STRING
			-- Value as a `STRING' as represented by Current

	value: STRING is
		do
			Result := actual_value
		end

feature -- Status report

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

	is_valid (a_value: STRING): BOOLEAN is
			-- Is `a_value' valid for use in Current?
		local
			lexer: RESOURCE_STRING_LEX
			str: STRING
		do
			if not a_value.empty then
				if a_value @ 1 /= '%"' then
					Create str.make (0)
					str.extend ('%"')
					str.append (a_value)
				else
					str := clone (value)
				end
				if str @ str.count /= '%"' then
					str.extend ('%"')
				end
				Create lexer
				Result := lexer.is_value_valid (str)
			else
				Result := True
			end
		end

feature -- Setting

	set_value (new_value: STRING) is
			-- Set `value' to `new_value'.
		do
			actual_value := new_value
		end

	set_actual_value (a_value: STRING) is
			-- Set `actual_value' to `a_value'.
		do
			actual_value := a_value
		end

feature {NONE} -- Obsolete

	make_from_old (old_r: STRING_RESOURCE) is
			-- used for compatibility
		do
			make_with_values (old_r.name, old_r.value)
		end

end -- class EB_STRING_RESOURCE
