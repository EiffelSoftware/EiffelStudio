note
	description: "Summary description for {ER_UPDATE_APPLICATION_MENU_INFO_VISITOR}."
	date: "$Date$"
	revision: "$Revision$"

class
	ER_UPDATE_APPLICATION_MENU_INFO_VISITOR

inherit
	ER_VISITOR
		redefine
			visit_ribbon_application_menu
		end

feature -- Command

	visit_ribbon_application_menu (a_ribbon_application_menu: ER_XML_TREE_ELEMENT; a_layout_constructor_index: INTEGER)
			-- <Precursor>
		local
			l_enable_pinning: BOOLEAN
			l_max_count: INTEGER
			 l_ribbon_application_menus: ARRAYED_LIST [EV_TREE_NODE]
		do
			-- Query values from markup XML
			check valid: attached a_ribbon_application_menu.name as l_text and then l_text.same_string ({ER_XML_CONSTANTS}.ribbon_application_menu) end
			from
				a_ribbon_application_menu.start
			until
				a_ribbon_application_menu.after
			loop
				if attached {ER_XML_TREE_ELEMENT} a_ribbon_application_menu.item_for_iteration as l_app_menu and then
					attached l_app_menu.name as l_text and then
					l_text.same_string ({ER_XML_CONSTANTS}.application_menu) then

					-- Find out ApplicationMenu.RecentItems node
					from
						l_app_menu.start
					until
						l_app_menu.after
					loop
						if attached {ER_XML_TREE_ELEMENT} l_app_menu.item_for_iteration as l_app_recent_items and then
							attached l_app_recent_items.name as l_text_app_recent_items and then
							l_text_app_recent_items.same_string ({ER_XML_CONSTANTS}.application_menu_recent_items) then

							-- Find out RecentItems node
							from
								l_app_recent_items.start
							until
								l_app_recent_items.after
							loop
								if attached {ER_XML_TREE_ELEMENT} l_app_recent_items.item_for_iteration as l_recent_items and then
									attached l_recent_items.name as l_text_recent_items and then
									l_text_recent_items.same_string ({ER_XML_CONSTANTS}.recent_items) then
								-- Query info from xml attribute
								from
									l_recent_items.start
								until
									l_recent_items.after
								loop
									if attached {XML_ATTRIBUTE} l_recent_items.item_for_iteration as l_attribute then
										if l_attribute.name.same_string ({ER_XML_ATTRIBUTE_CONSTANTS}.enable_pinning) then
											if l_attribute.value.same_string ("true") then
												l_enable_pinning := True
											elseif l_attribute.value.same_string ("false") then
												l_enable_pinning := False
											else
												check not_possible: False end
											end

										elseif  l_attribute.name.same_string ({ER_XML_ATTRIBUTE_CONSTANTS}.max_count) then
											l_max_count := l_attribute.value.to_integer
										end
									end

									l_recent_items.forth
								end
								l_app_recent_items.forth
							end
						end
					end
					l_app_menu.forth
				end
				a_ribbon_application_menu.forth
			end

			-- Update values to GUI
			l_ribbon_application_menus := shared.layout_constructor_list.i_th(a_layout_constructor_index).all_items_with ({ER_XML_CONSTANTS}.ribbon_application_menu)
			check l_ribbon_application_menus.count <= 1 end
			if l_ribbon_application_menus.valid_index (1) then
				if attached l_ribbon_application_menus.first as l_application_menu then
					if attached {ER_TREE_NODE_APPLICATION_MENU_DATA} l_application_menu.data as l_menu_data then
						l_menu_data.set_enable_pinning (l_enable_pinning)
						l_menu_data.set_max_count (l_max_count)
					end
				end
			end

		end
	end
end
