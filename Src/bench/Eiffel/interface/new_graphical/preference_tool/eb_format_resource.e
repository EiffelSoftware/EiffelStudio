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
	make_default,
	make_with_values

feature {NONE} -- Initialization

	make_with_values (a_name: STRING; a_value: EV_CHARACTER_FORMAT) is
		-- Initialize Current
		do
			name := a_name
			actual_value := a_value
		end

	make_default (a_name: STRING; rt: RESOURCE_TABLE; a_color_name: STRING; a_font_name: STRING) is
			-- Initialize Current
			-- bad implementation: one can mistake color_name and a_color_name
		local
			f: EV_FONT
			c: EV_COLOR
		do
			name := a_name

			create default_value.make
			create f.make_by_system_name (a_font_name)
			default_value.set_font (f)
			c := color_from_table (a_color_name)
			default_value.set_color (c)

			create actual_value.make
			create f.make_by_system_name (rt.get_string (font_name, a_font_name))
			actual_value.set_font (f)
			c := color_from_table (rt.get_string (color_name, a_color_name))
			actual_value.set_color (c)
		end

feature -- Access

	default_value, actual_value: EV_CHARACTER_FORMAT
			-- Value represented by Current

	value: STRING is
			-- Value as a `STRING' as represented by Current
		do
			Result := actual_value.out
		end

	font_name: STRING is
			-- Name associated with font value
		do
			Result := clone (name)
			Result.append (" font")
		end

	color_name: STRING is
			-- Name associated with color value
		do
			Result := clone (name)
			Result.append (" color")
		end

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
			-- Has the resource not changed from the default value?
		do
			Result := actual_value = default_value
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

end -- class EB_FORMAT_RESOURCE
