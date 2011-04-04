note
	description: "Summary description for {ER_UPDATE_CONTEXT_POPUPS_VISITOR}."
	date: "$Date$"
	revision: "$Revision$"

class
	ER_UPDATE_CONTEXT_POPUP_VISITOR

inherit
	ER_VISITOR
		redefine
			visit_context_popup
		end

feature -- Command

	visit_context_popup (a_context_popups: ER_XML_TREE_ELEMENT)
			-- <Precursor>
		local
			l_tree_item: EV_TREE_ITEM
			l_helper: ER_LOAD_VISION_TREE_VISITOR
		do
			if attached shared.layout_constructor_list.i_th (1) as l_layout_constructor then
				l_tree_item := l_layout_constructor.tree_item_factory_method (a_context_popups.name)
				-- Add root "Context Popup" node to first layout constructor
				l_layout_constructor.widget.extend (l_tree_item)

				-- Query values from markup XML
				check valid: attached a_context_popups.name as l_text and then l_text.same_string ({ER_XML_CONSTANTS}.context_popup) end

				from
					create l_helper
					a_context_popups.start
				until
					a_context_popups.after
				loop
					if attached {ER_XML_TREE_ELEMENT} a_context_popups.item_for_iteration as l_item then
						if l_item.name.same_string ({ER_XML_CONSTANTS}.context_popup_mini_toolbars) or else
						l_item.name.same_string ({ER_XML_CONSTANTS}.context_popup_context_menus) then
							l_helper.create_vision_tree_recursive (l_tree_item, l_item)
						elseif l_item.name.same_string ({ER_XML_CONSTANTS}.context_popup_context_maps) then
							-- Handle context maps here
						else
							check not_possible: False end
						end
					end

					a_context_popups.forth
				end

				l_layout_constructor.expand_tree
			end
		end

end
