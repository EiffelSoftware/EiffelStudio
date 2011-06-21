note
	description: "Summary description for {ER_VISITOR}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ER_VISITOR

feature -- Visitor commands

	visit_application_commands (a_commands: ER_XML_TREE_ELEMENT)
			--
		require
			not_void: a_commands /= Void
			valid: is_node_with_text (a_commands, constants.application_commands)
		do

		end

	visit_ribbon_tabs (a_ribbon_tabs: ER_XML_TREE_ELEMENT)
			--
		require
			not_void: a_ribbon_tabs /= Void
			valid: is_node_with_text (a_ribbon_tabs, constants.ribbon_tabs)
		do

		end

	visit_ribbon_application_menu (a_ribbon_application_menu: ER_XML_TREE_ELEMENT)
			--
		require
			not_void: a_ribbon_application_menu /= Void
			valid: is_node_with_text (a_ribbon_application_menu, constants.ribbon_application_menu)
		do

		end

	visit_context_popup (a_conotext_popups: ER_XML_TREE_ELEMENT)
			--
		require
			not_void: a_conotext_popups /= Void
			valid: is_node_with_text (a_conotext_popups, constants.context_popup)
		do

		end

	visit_help_button (a_help_button: ER_XML_TREE_ELEMENT)
			--
		require
			not_void: a_help_button /= Void
			valid: is_node_with_text (a_help_button, constants.ribbon_helpbutton)
		do

		end

	visit_quick_access_toolbar (a_quick_access_toolbar: ER_XML_TREE_ELEMENT)
			--
		require
			not_void: a_quick_access_toolbar /= Void
			valid: is_node_with_text (a_quick_access_toolbar, constants.ribbon_quick_access_toolbar)
		do

		end

	visit_size_definitions (a_ribbon_size_definitions: ER_XML_TREE_ELEMENT)
			--
		require
			not_void: a_ribbon_size_definitions /= Void
			valid: is_node_with_text (a_ribbon_size_definitions, constants.ribbon_size_definitions)
		do
			
		end

feature -- Query

	is_node_with_text (a_xml_node: ER_XML_TREE_ELEMENT; a_text: STRING): BOOLEAN
			--
		require
			not_void: a_xml_node /= Void
			not_void: a_text /= Void
		do
			if attached a_xml_node.name as l_name then
				Result := l_name.same_string (a_text)
			end
		end

	constants: ER_XML_CONSTANTS
			--
		once
			create Result
		end

	constants_attribute: ER_XML_ATTRIBUTE_CONSTANTS
			--
		once
			create Result
		end

	shared: ER_SHARED_SINGLETON
			--
		once
			create Result
		end
end
