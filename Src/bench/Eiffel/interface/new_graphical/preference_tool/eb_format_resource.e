indexing
	description:
		"A resource value for format resources"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FORMAT_RESOURCE

inherit
	EB_RESOURCE

	EB_COLOR_TABLE
		undefine
			is_equal
		end

creation
	make_from_olds

feature {NONE} -- Initialization

	make_with_values (a_name: STRING; a_value: EV_CHARACTER_FORMAT) is
		-- Initialize Current
		do
			name := a_name
			actual_value := a_value
		end

feature -- Access

	default_value, actual_value: EV_CHARACTER_FORMAT
			-- Value represented by Current

	value: STRING is
			-- Value as a `STRING' as represented by Current
		do
			Result := actual_value.out
		end

	font_name: STRING
			-- Name associated with font value
			-- to be changed later form an attribute to a feature

	color_name: STRING
			-- Name associated with color value
			-- to be changed later form an attribute to a feature

	font_resource: EB_FONT_RESOURCE is
		do
			Create Result.make_with_values (font_name, actual_value.font)
		end

	color_resource: EB_COLOR_RESOURCE is
		do
			Create Result.make_with_values (color_name, actual_value.color)
		end

feature -- Status setting

	is_valid (a_value: STRING): BOOLEAN is
			-- Is `a_value' valid for use in Current?
		do
			Result := False
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
		end

	set_actual_value (a_format: EV_CHARACTER_FORMAT) is
			-- Set `actual_value' to `a_format' and update `value'.
		do
			actual_value := a_format
		end

feature {NONE} -- Obsolete

	make_from_olds (a_name: STRING; old_f: FONT_RESOURCE; old_c: COLOR_RESOURCE) is
		local
			cf: EV_CHARACTER_FORMAT
			f: EV_FONT
		do
			Create cf.make
			Create f.make_by_system_name (old_f.value)
			cf.set_font (f)
			cf.set_color (color_from_table (old_c.value))
			font_name := old_f.name
			color_name := old_c.name
			make_with_values (a_name, cf)
		end

	make_from_old (old_r: RESOURCE) is
		do
		end

end -- class EB_FORMAT_RESOURCE
