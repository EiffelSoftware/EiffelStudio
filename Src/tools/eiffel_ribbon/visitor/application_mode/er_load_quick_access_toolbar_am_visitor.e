note
	description: "Summary description for {ER_LOAD_QUICK_ACCESS_TOOLBAR_VISITOR}."
	date: "$Date$"
	revision: "$Revision$"

class
	ER_LOAD_QUICK_ACCESS_TOOLBAR_AM_VISITOR

inherit
	ER_VISITOR
		redefine
			visit_quick_access_toolbar
		end

feature -- Command

	visit_quick_access_toolbar (a_quick_access_toolbar: ER_XML_TREE_ELEMENT; a_layout_constructor_index: INTEGER)
			-- <Precursor>
		local
			l_data: ER_TREE_NODE_QUICK_ACCESS_TOOLBAR_DATA
			l_tree_item: EV_TREE_ITEM
			l_helper: ER_LOAD_VISION_TREE_VISITOR
		do
			if attached shared.layout_constructor_list.i_th (1) as l_layout_constructor then
				-- FIXME: multi-window support? But.... only 32 application modes, we have to use application modes to show/hide group/tab also...

				create l_data.make
				l_tree_item := l_layout_constructor.tree_item_factory_method (constants.ribbon_quick_access_toolbar)

				from
					create l_helper
					a_quick_access_toolbar.start
				until
					a_quick_access_toolbar.after
				loop
					if attached {XML_ELEMENT} a_quick_access_toolbar.item_for_iteration as l_element then
						if l_element.name.same_string (constants.quick_access_toolbar) then
							from
								l_element.start
							until
								l_element.after
							loop
								if attached {XML_ATTRIBUTE} l_element.item_for_iteration as l_attribute then
									if l_attribute.name.same_string ({ER_XML_ATTRIBUTE_CONSTANTS}.command_name) then
										l_data.set_command_name (l_attribute.value)
									else
										check invalid_tag: False end
									end
								elseif attached {XML_ELEMENT}l_element.item_for_iteration as l_sub_element and then
									l_sub_element.name.same_string (constants.quick_access_toolbar_application_defaults) then

									from
										l_sub_element.start
									until
										l_sub_element.after
									loop
										l_helper.create_vision_tree_recursive (l_tree_item, l_sub_element.item_for_iteration)
										l_sub_element.forth
									end
								end
								l_element.forth
							end
						end
					end
					a_quick_access_toolbar.forth
				end

				l_tree_item.set_data (l_data)

				l_layout_constructor.widget.extend (l_tree_item)
				l_layout_constructor.expand_tree
			end
		end

end
