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

	check_box: STRING = "CheckBox"

	combo_box: STRING = "ComboBox"

	control_group: STRING = "ControlGroup"

feature -- Contract support

	valid (a_string: STRING): BOOLEAN
			--
		do
			if attached a_string as l_string then
				Result := l_string.is_equal (application) or else
					l_string.is_equal (application_commands) or else
					l_string.is_equal (application_views) or else
					l_string.is_equal (ribbon) or else
					l_string.is_equal (ribbon_application_menu) or else
					l_string.is_equal (ribbon_contextual_tabs) or else
					l_string.is_equal (ribbon_helpbutton) or else
					l_string.is_equal (ribbon_quick_access_toolbar) or else
					l_string.is_equal (ribbon_size_definitions) or else
					l_string.is_equal (ribbon_tabs) or else
					l_string.is_equal (command) or else
					l_string.is_equal (group) or else
					l_string.is_equal (tab) or else
					l_string.is_equal (button) or else
					l_string.is_equal (check_box) or else
					l_string.is_equal (combo_box) or else
					l_string.is_equal (control_group)
			end
		end

end
