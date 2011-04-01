note
	description: "Summary description for {ER_SPLIT_BUTTON_GALLERY_INFO_VISITOR}."
	date: "$Date$"
	revision: "$Revision$"

class
	ER_SPLIT_BUTTON_GALLERY_INFO_VISITOR

inherit
	ER_VISITOR
		redefine
			visit_ribbon_tabs
		end

feature -- Command

	visit_ribbon_tabs (a_ribbon_tabs: ER_XML_TREE_ELEMENT)
				--
		do
			visit_split_button_gallery_recursive (a_ribbon_tabs)
		end

	visit_split_button_gallery_recursive (a_node: XML_ELEMENT)
			--
		local
			l_cmd_id: STRING
			l_vision_nodes: ARRAYED_LIST [EV_TREE_NODE]
			l_data: detachable ER_TREE_NODE_SPLIT_BUTTON_GALLERY_DATA
		do
			if a_node.name.same_string (constants.split_button_gallery) then
				from
					a_node.start
				until
					a_node.after
				loop
					if attached {XML_ATTRIBUTE} a_node.item_for_iteration as l_atrribute then
						if l_atrribute.name.same_string (constants_attribute.command_name) then
							l_cmd_id := l_atrribute.value
							l_vision_nodes := shared.layout_constructor_list.first.all_items_with_command_name_in_all_constructors (l_cmd_id)
							check only_one: l_vision_nodes.count = 1 end
							if attached  l_vision_nodes.first as l_first then
								l_first.wipe_out
								if attached {ER_TREE_NODE_SPLIT_BUTTON_GALLERY_DATA} l_first.data as l_data_tmp then
									l_data := l_data_tmp
								end
							end
						else
							-- maybe `Type' attribute
						end
					elseif attached {ER_XML_TREE_ELEMENT} a_node.item_for_iteration as l_sub_node and then l_data /= Void then
						if l_sub_node.name.same_string (constants.split_button_gallery_menu_layout) then
							fill_data_with_split_button_gallery_sub_node (l_data, l_sub_node)
						end
					end
					a_node.forth
				end
			else
				from
					a_node.start
				until
					a_node.after
				loop
					if attached {XML_ELEMENT} a_node.item_for_iteration as l_node then
						visit_split_button_gallery_recursive (l_node)
					end

					a_node.forth
				end
			end
		end

	fill_data_with_split_button_gallery_sub_node (a_data: ER_TREE_NODE_SPLIT_BUTTON_GALLERY_DATA; a_drop_down_gallery_menu_layout: ER_XML_TREE_ELEMENT)
			--
		require
			not_void: a_data /= Void
			not_void: a_drop_down_gallery_menu_layout /= Void
			valid: a_drop_down_gallery_menu_layout.name.same_string (constants.split_button_gallery_menu_layout)
		do
			from
				a_drop_down_gallery_menu_layout.start
			until
				a_drop_down_gallery_menu_layout.after
			loop
				-- Find `FlowMenuLayout' sub node
				if attached {ER_XML_TREE_ELEMENT} a_drop_down_gallery_menu_layout.item_for_iteration as l_sub_node then
					if l_sub_node.name.same_string (constants.flow_menu_layout) then
						from
							l_sub_node.start
						until
							l_sub_node.after
						loop
							if attached {XML_ATTRIBUTE} l_sub_node.item_for_iteration as l_attribute then
								if l_attribute.name.same_string (constants_attribute.rows) then
									a_data.set_rows (l_attribute.value.to_integer)
								elseif l_attribute.name.same_string (constants_attribute.columns) then
									a_data.set_columns (l_attribute.value.to_integer)
								end
							end

							l_sub_node.forth
						end
					end
				end
				a_drop_down_gallery_menu_layout.forth
			end
		end
end
