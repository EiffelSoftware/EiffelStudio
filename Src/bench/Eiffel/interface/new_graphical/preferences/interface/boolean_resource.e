indexing
	description	: "A resource value for boolean resources."
	date		: "$Date$"
	revision	: "$Revision$"

class
	BOOLEAN_RESOURCE

inherit
	RESOURCE

creation
	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_value: BOOLEAN) is
			-- Initialize Current.
		do
			name := a_name
			actual_value := a_value
			default_value := a_value
		end

feature -- Access

	default_value, actual_value: BOOLEAN
			-- Value represented by Current

	value: STRING is
			-- Value as a `STRING' as represented by Current
		do
			Result := actual_value.out
		end

	is_valid (a_value: STRING): BOOLEAN is
			-- Is `a_value' valid for use in Current?
		do
			Result := a_value.is_boolean
		end

	has_changed: BOOLEAN is
			-- Has the resource changed from the default value?
		do
			Result := actual_value /= default_value
		end

feature -- Setting

	set_value (new_value: STRING) is
			-- Set `actual_value' according to `new_value'.
		do
			actual_value := new_value.to_boolean
		end

	set_actual_value (a_bool: BOOLEAN) is
			-- Set `actual_value' to `a_bool'.
		do
			actual_value := a_bool
		end

	mark_saved is
		do
			default_value := actual_value
		end

feature -- Output

	xml_trace: STRING is
			-- XML representation of Current
		do
			Result := "<TEXT>"
			Result.append (name)
			Result.append ("<BOOLEAN>")
			Result.append (value)
			Result.append ("</BOOLEAN></TEXT>")
		end

	registry_name: STRING is
			-- name of Current in the registry
		do
			Result := "EIFBOL_" + name
		end


end -- class BOOLEAN_RESOURCE
