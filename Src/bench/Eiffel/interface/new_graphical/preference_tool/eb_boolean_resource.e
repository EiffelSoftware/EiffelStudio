indexing
	description:
		"A resource value for boolean resources."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_BOOLEAN_RESOURCE

inherit
	EB_RESOURCE

creation
	make,
	make_with_values,
	make_from_old

feature {NONE} -- Initialization

	make_with_values (a_name: STRING; a_value: BOOLEAN) is
		-- Initialize Current
		do
			name := a_name
			actual_value := a_value
		end

	make (a_name: STRING; rt: RESOURCE_TABLE; def_value: BOOLEAN) is
			-- Initialize Current.
		do
			actual_value := rt.get_boolean (a_name, def_value)
			default_value := def_value
			name := a_name
		end

feature -- Access

	default_value, actual_value: BOOLEAN
			-- Value represented by Current

	value: STRING is
			-- Value as a `STRING' as represented by Current
		do
			Result := actual_value.out
		end

feature -- Status setting

	is_valid (a_value: STRING): BOOLEAN is
			-- Is `a_value' valid for use in Current?
		do
			Result := a_value.is_boolean
		end

	is_default: BOOLEAN is
			-- Has the resource changed from the default value?
		do
			Result := actual_value /= default_value
		end

	has_changed: BOOLEAN is
			-- Has the resource changed from the old value?
		do
			Result := actual_value /= default_value
		end

feature -- Element change

	set_value (new_value: STRING) is
			-- Set `value' to `new_value' and update `actual_value'.
		do
			actual_value := new_value.to_boolean
		end

	set_actual_value (a_bool: BOOLEAN) is
			-- Set `actual_value' to `a_bool' and update `value'.
		do
			actual_value := a_bool
		end

feature {NONE} -- Obsolete

	make_from_old (old_r: BOOLEAN_RESOURCE) is
		do
			make_with_values (old_r.name, old_r.actual_value)
		end

end -- class EB_BOOLEAN_RESOURCE
