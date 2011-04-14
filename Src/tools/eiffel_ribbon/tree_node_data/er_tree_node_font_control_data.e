note
	description: "Summary description for {ER_TREE_NODE_FONT_CONTROL_DATA}."
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
			--
		require
			valid: a_type /= Void implies valid (a_type)
		do
			font_type := a_type
		ensure
			set: font_type = a_type
		end

feature -- Query

	font_type: detachable STRING
			-- Color template

	valid (a_template: STRING): BOOLEAN
			--
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

	font_with_color: STRING = "FontWithColor"

	font_only: STRING = "FontOnly"

end
