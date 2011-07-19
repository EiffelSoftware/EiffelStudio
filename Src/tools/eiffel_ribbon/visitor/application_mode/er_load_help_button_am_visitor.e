note
	description: "Summary description for {ER_LOAD_HELP_BUTTON_VISITOR}."
	date: "$Date$"
	revision: "$Revision$"

class
	ER_LOAD_HELP_BUTTON_AM_VISITOR

inherit
	ER_VISITOR
		redefine
			visit_help_button
		end

feature -- Command

	visit_help_button (a_help_button: ER_XML_TREE_ELEMENT; a_layout_constructor_index: INTEGER)
			-- <Precursor>
		local
			l_data: ER_TREE_NODE_HELP_BUTTON_DATA
			l_tree_item: EV_TREE_ITEM
		do
			if attached shared.layout_constructor_list.i_th (1) as l_layout_constructor then
				-- FIXME: multi-window support? But.... only 32 application modes, we have to use application modes to show/hide group/tab also...

				create l_data.make
				from
					a_help_button.start
				until
					a_help_button.after
				loop
					if attached {XML_ELEMENT} a_help_button.item_for_iteration as l_element then
						check l_element.name.same_string (constants.helpbutton) end
						from
							l_element.start
						until
							l_element.after
						loop
							if attached {XML_ATTRIBUTE} l_element.item_for_iteration as l_attribute then
								check l_attribute.name.same_string ({ER_XML_ATTRIBUTE_CONSTANTS}.command_name) end
								l_data.set_command_name (l_attribute.value)
							end
							l_element.forth
						end
					end
					a_help_button.forth
				end

				l_tree_item := l_layout_constructor.tree_item_factory_method (constants.ribbon_helpbutton)
				l_tree_item.set_data (l_data)

				l_layout_constructor.widget.extend (l_tree_item)
			end
		end

end
