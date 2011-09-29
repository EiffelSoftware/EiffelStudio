note
	description: "[
					Microsoft Ribbon makrup XML attribute constants

				]"
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

	popup: STRING = "Popup"

	button_prefix: STRING = "button"

	control_name: STRING = "ControlName"

	image_size: STRING = "ImageSize"

	is_label_visible: STRING = "IsLabelVisible"

	true_value: STRING = "true"

	false_value: STRING = "false"

feature -- Scaling polcy

	group: STRING = "Group"

note
	copyright: "Copyright (c) 1984-2011, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
