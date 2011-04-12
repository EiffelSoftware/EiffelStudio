note
	description: "Summary description for {ER_TREE_NODE_DROP_DOWN_COLOR_PICKER_DATA}."
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
			--
		require
			valid: a_color /= Void implies valid (a_color)
		do
			color_template := a_color
		ensure
			set: color_template = a_color
		end

feature -- Query

	color_template: detachable STRING
			-- Color template

	valid (a_template: STRING): BOOLEAN
			--
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

	theme_colors: STRING = "ThemeColors"

	highlight_colors: STRING = "HighlightColors"

end
