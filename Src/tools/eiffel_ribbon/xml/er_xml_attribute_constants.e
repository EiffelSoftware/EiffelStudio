note
	description: "Summary description for {ER_XML_ATTRIBUTE_CONSTANTS}."
	date: "$Date$"
	revision: "$Revision$"

class
	ER_XML_ATTRIBUTE_CONSTANTS

feature -- Query

	name: STRING = "Name"

	command_name: STRING = "CommandName"

	application_mode: STRING = "ApplicationModes"

	size_definition: STRING = "SizeDefinition"

feature -- Dropdown gallery

	text_position: STRING = "TextPosition"

	type: STRING = "Type"

	rows: STRING = "Rows"

	columns: STRING = "Columns"

	gripper: STRING = "Gripper"

end
