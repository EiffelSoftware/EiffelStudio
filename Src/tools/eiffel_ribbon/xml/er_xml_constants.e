note
	description: "Summary description for {ER_CONSTANTS}."
	date: "$Date$"
	revision: "$Revision$"

class
	ER_XML_CONSTANTS

feature -- Root element

	application: STRING = "Application"

	application_commands: STRING = "Application.Commands"

	application_views: STRING = "Application.Views"

feature -- Query, the value of string is what should be written to XML

	ribbon: STRING = "Ribbon"

	ribbon_application_menu: STRING = "Ribbon.ApplicationMenu"

	ribbon_contextual_tabs: STRING = "Ribbon.ContextualTabs"

	ribbon_helpbutton: STRING = "Ribbon.HelpButton"

	ribbon_quick_access_toolbar: STRING = "Ribbon.QuickAccessToolbar"

	ribbon_size_definitions: STRING = "Ribbon.SizeDefinitions"

	ribbon_tabs: STRING = "Ribbon.Tabs"

	tab: STRING = "Tab"

	group: STRING = "Group"

	tab_scaling_policy: STRING = "Tab.ScalingPolicy"

	command: STRING = "Command"

	context_popup: STRING = "ContextPopup"

feature -- ALl types under group

	button: STRING = "Button"

	toggle_button: STRING = "ToggleButton"

	check_box: STRING = "CheckBox"

	combo_box: STRING = "ComboBox"

	control_group: STRING = "ControlGroup"

feature -- Types under command node

	command_small_images: STRING = "Command.SmallImages"
			--

	command_large_images: STRING = "Command.LargeImages"
			--

	command_label_title: STRING = "Command.LabelTitle"
			--

	string: STRING = "String"

	Image: STRING = "Image"

feature -- Contract support

	valid (a_string: STRING): BOOLEAN
			--
		do
			if attached a_string as l_string then
				Result := l_string.same_string (application) or else
					l_string.same_string (application_commands) or else
					l_string.same_string (application_views) or else
					l_string.same_string (ribbon) or else
					l_string.same_string (ribbon_application_menu) or else
					l_string.same_string (ribbon_contextual_tabs) or else
					l_string.same_string (ribbon_helpbutton) or else
					l_string.same_string (ribbon_quick_access_toolbar) or else
					l_string.same_string (ribbon_size_definitions) or else
					l_string.same_string (ribbon_tabs) or else
					l_string.same_string (command) or else
					l_string.same_string (group) or else
					l_string.same_string (tab) or else
					l_string.same_string (button) or else
					l_string.same_string (check_box) or else
					l_string.same_string (combo_box) or else
					l_string.same_string (control_group) or else
					l_string.same_string (command_label_title) or else
					l_string.same_string (command_small_images) or else
					l_string.same_string (command_large_images) or else
					l_string.same_string (toggle_button)
			end
		end

end
