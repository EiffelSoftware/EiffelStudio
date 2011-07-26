note
	description: "Summary description for {ER_XML_TREE_ELEMENT}."
	date: "$Date$"
	revision: "$Revision$"

class
	ER_XML_TREE_ELEMENT

inherit
	XML_ELEMENT

create
	make,
	make_last,
	make_root

feature -- Command

	accept (a_visitor: ER_VISITOR; a_layout_constructor_index: INTEGER)
			--
		require
			not_void: a_visitor /= Void
		do
			if attached name as l_name then
				if l_name.same_string (constants.ribbon_application_menu) then
					a_visitor.visit_ribbon_application_menu (Current, a_layout_constructor_index)
				elseif l_name.same_string (constants.ribbon_tabs) then
					a_visitor.visit_ribbon_tabs (Current, a_layout_constructor_index)
				elseif l_name.same_string (constants.application_commands) then
					a_visitor.visit_application_commands (Current)
				elseif l_name.same_string (constants.context_popup) then
					a_visitor.visit_context_popup (Current, a_layout_constructor_index)
				elseif l_name.same_string (constants.ribbon_helpbutton) then
					a_visitor.visit_help_button (Current, a_layout_constructor_index)
				elseif l_name.same_string (constants.ribbon_quick_access_toolbar) then
					a_visitor.visit_quick_access_toolbar (Current, a_layout_constructor_index)
				elseif l_name.same_string (constants.ribbon_size_definitions) then
					a_visitor.visit_size_definitions (Current)
				elseif l_name.same_string (constants.ribbon_contextual_tabs) then
					a_visitor.visit_contextual_tabs (Current, a_layout_constructor_index)
				end
			end

			from
				start
			until
				after
			loop
				if attached {ER_XML_TREE_ELEMENT} item_for_iteration as l_item then
					l_item.accept (a_visitor, a_layout_constructor_index)
				else
--					check item_not_valid: False end
				end

				forth
			end
		end

feature -- Command

	set_content (a_content: like content)
			--
		do
			content := a_content
		ensure
			set: a_content = content
		end

feature -- Query

	constants: ER_XML_CONSTANTS
			--
		once
			create Result
		end

	content: detachable STRING_32
			-- String contents
end
