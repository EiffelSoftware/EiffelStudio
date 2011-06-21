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

feature -- Dropdown color picker

	color_template: STRING = "ColorTemplate"

feature -- Font control

	font_type: STRING = "FontType"

feature -- In ribbon gallery

	max_rows: STRING = "MaxRows"

	max_columns: STRING = "MaxColumns"

feature -- Recent items

	enable_pinning: STRING = "EnablePinning"

	max_count: STRING = "MaxCount"

feature -- Context maps

	context_menu: STRING = "ContextMenu"

	mini_toolbar: STRING = "MiniToolbar"

feature -- Size definition

	size: STRING = "Size"

	large: STRING = "Large"

	medium: STRING = "Medium"

	small: STRING = "Small"

	button_prefix: STRING = "button"

	control_name: STRING = "ControlName"

	image_size: STRING = "ImageSize"

	is_label_visible: STRING = "IsLabelVisible"

	true_value: STRING = "true"

	false_value: STRING = "false"

end
