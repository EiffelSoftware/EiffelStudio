note
	description: "[
					Drop down color picker tree node data
																				]"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_TREE_NODE_DROP_DOWN_COLOR_PICKER_DATA

inherit
	ER_TREE_NODE_BUTTON_DATA
		redefine
			make
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Creation method
		do
			command_name_prefix := "drop_down_color_picker_"
			xml_constants := {ER_XML_CONSTANTS}.drop_down_color_picker
			new_unique_command_name
		end

feature -- Command

	set_color_template (a_color: detachable STRING)
			-- Set `color_template' with `a_color'
		require
			valid: a_color /= Void implies is_valid (a_color)
		do
			color_template := a_color
		ensure
			set: color_template = a_color
		end

feature -- Query

	color_template: detachable STRING
			-- Color template

	is_valid (a_template: STRING): BOOLEAN
			-- Is `a_template' valid?
		require
			not_void: a_template /= Void
		do
			if a_template.same_string (standard_colors) or else
				a_template.same_string (theme_colors) or else
				a_template.same_string (highlight_colors) then
				Result := True
			end
		end

feature -- Enumeration

	standard_colors: STRING = "StandardColors"
			-- Standard colors

	theme_colors: STRING = "ThemeColors"
			-- Theme colors

	highlight_colors: STRING = "HighlightColors"
			-- Highlight colors
end
