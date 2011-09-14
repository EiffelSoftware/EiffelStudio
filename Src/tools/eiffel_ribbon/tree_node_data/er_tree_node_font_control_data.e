note
	description: "[
					Font control tree node data
																				]"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_TREE_NODE_FONT_CONTROL_DATA

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
			command_name_prefix := "font_control_"
			xml_constants := {ER_XML_CONSTANTS}.font_control
			new_unique_command_name
		end

feature -- Command

	set_font_type (a_type: detachable STRING)
			-- Set `font_type' with `a_font_type'
		require
			valid: a_type /= Void implies is_valid (a_type)
		do
			font_type := a_type
		ensure
			set: font_type = a_type
		end

feature -- Query

	font_type: detachable STRING
			-- Color template

	is_valid (a_template: STRING): BOOLEAN
			-- Is `a_template' valid?
		require
			not_void: a_template /= Void
		do
			if a_template.same_string (rich_font) or else
				a_template.same_string (font_with_color) or else
				a_template.same_string (font_only) then
				Result := True
			end
		end

feature -- Enumeration

	rich_font: STRING = "RichFont"
		-- Rich font

	font_with_color: STRING = "FontWithColor"
		-- Font with color

	font_only: STRING = "FontOnly"
		-- Font only
end
