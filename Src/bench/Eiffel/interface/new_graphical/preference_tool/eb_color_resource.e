indexing 
	description:
		"A resource value for color resources."
	date: "$Date$"
	revision: "$Revision$"
 
class
	EB_COLOR_RESOURCE
 
inherit
	EB_RESOURCE

	EB_COLOR_TABLE
		undefine
			is_equal
		end
 
creation
	make,
	make_from_string,
	make_with_values,
	make_from_old

feature {NONE} -- Initialization

	make_with_values (a_name: STRING; a_value: EV_COLOR) is
			-- Initialize Current
		require else
			value_non_void: a_value /= Void
		do
			name := a_name
			actual_value := a_value
		end

	make_from_string (a_name: STRING; a_string: STRING) is
			-- Initialize Current
		require
			name_non_void: a_name /= Void
			string_non_void: a_string /= Void
		do
			name := a_name

			actual_value := color_from_table (a_string)
		end
 
	make (a_name: STRING; rt: RESOURCE_TABLE; def_value: EV_COLOR) is
			-- Initialize Current
		do
			make_from_string (a_name, rt.get_string (a_name, def_value.name))
			default_value := def_value
		end

feature -- Access

	default_value, actual_value: EV_COLOR
			-- Color value of resource

	value: STRING is

		do
			Result := actual_value.name
		end

	is_valid (a_string: STRING): BOOLEAN is
		do
			Result := True
		end
		-- To be implemented

--	valid_actual_value: EV_COLOR is
--			-- Non void color value
--		do
--			Result := actual_value
--			if Result = Void then
--				Result := default_color
--			end
--		ensure
--			valid_result: Result /= Void
--		end

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

feature -- Element Change

	set_value (new_value: STRING) is
			-- Set `value' to `new_value'.
		do
			Create actual_value.make
			if not new_value.empty then
				actual_value.set_name (new_value)
			end
		end

	set_actual_value (a_color: EV_COLOR) is
			-- Set `value' to `new_value'.
		do
			actual_value := a_color
		end

feature {NONE} -- Obsolete

	make_from_old (old_r: COLOR_RESOURCE) is
		do
			make_from_string (old_r.name, old_r.value)
		end

end -- class EB_COLOR_RESOURCE
