note
	description: "Factory with responsibility for create docking library widgets base on different style."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_WIDGET_FACTORY

inherit
	SD_ACCESS

create {SD_SHARED}
	make

feature {NONE} -- Initlization

	make
			-- Creation method
		do
			set_style (style_different)

			create notebook_tab_area_menu_items.make (10)
			create title_bar_area_menu_items.make (10)
		ensure
			default_style_set: internal_style = style_different
		end

feature -- Status setting

	set_style (a_style: INTEGER)
			-- Set style to one of enumeration at end of this class
		require
			a_style_valid: style_valid (a_style)
		do
			internal_style := a_style
		ensure
			a_style_set: a_style = internal_style
		end

feature -- Status report

	style_valid (a_style: INTEGER): BOOLEAN
			-- If `a_style' valid?
		do
			Result := a_style = style_all_same or a_style = style_different
		end

feature -- Factory method

	title_bar (a_style: INTEGER; a_zone_type: INTEGER): SD_TITLE_BAR
			-- Title bar
		require
			a_style_valid: style_valid (a_style)
			a_type_valid: a_zone_type = {SD_ENUMERATION}.docking or a_zone_type = {SD_ENUMERATION}.auto_hide or a_zone_type = {SD_ENUMERATION}.tab
		do
			if internal_style = style_different then
				if a_zone_type = {SD_ENUMERATION}.tab then
					if a_style = {SD_ENUMERATION}.editor then
						create {SD_TITLE_BAR} Result.make
						Result.hide
					else
						check
							from_precondition_a_style_valid: a_style = {SD_ENUMERATION}.tool
						end
						create Result.make
					end
				else
					check from_precondition_a_type_valid:
						a_zone_type = {SD_ENUMERATION}.auto_hide or a_zone_type = {SD_ENUMERATION}.docking
					end
					create Result.make
				end
			else
				check valid_internal_style: internal_style = style_all_same end
				create Result.make
			end
		ensure
			not_void: Result /= Void
		end

	docking_zone (a_content: SD_CONTENT): SD_DOCKING_ZONE
			-- Docking zone.
		local
			l_place_holder_zone: SD_PLACE_HOLDER_ZONE
		do
			if internal_style = style_all_same then
				create {SD_DOCKING_ZONE_NORMAL} Result.make (a_content)
			else
				check internal_style = style_different end -- Implied by only two kinds of styles
				if a_content.type = {SD_ENUMERATION}.tool then
					create {SD_DOCKING_ZONE_NORMAL} Result.make (a_content)
				elseif a_content.type = {SD_ENUMERATION}.editor then
					create {SD_DOCKING_ZONE_UPPER} Result.make (a_content)
				else
					check a_content.type = {SD_ENUMERATION}.place_holder end
					create l_place_holder_zone.make (a_content, a_content.docking_manager)
					if a_content.is_docking_manager_attached then
						l_place_holder_zone.set_docking_manager (a_content.docking_manager)
					end
					Result := l_place_holder_zone
				end
			end
		end

	tab_zone (a_content: SD_CONTENT): SD_TAB_ZONE
			-- Tab zone
		require
			a_content_not_void: a_content /= Void
		do
			if internal_style = style_different then
			    check style_valid: style_valid (a_content.type) end
				if a_content.type = {SD_ENUMERATION}.editor then
					create {SD_TAB_ZONE_UPPER} Result.make (a_content)
				else
					check a_content.type = {SD_ENUMERATION}.tool end
					create Result.make (a_content)
				end
			else
				check internal_style = style_all_same end
				create Result.make (a_content)
			end
		ensure
			not_void: Result /= Void
		end

feature -- Menu

	notebook_tab_area_menu_items: ARRAYED_LIST [EV_MENU_ITEM]
			-- Notebook tab area menu items which can be customized by client programmers in {SD_SHARED}

	title_bar_area_menu_items: ARRAYED_LIST [EV_MENU_ITEM]
			-- Title bar area menu items which can be customized by client programmers in {SD_SHARED}

	editor_tab_area_menu (a_notebook: SD_NOTEBOOK): EV_MENU
			-- Right click menu for editor tab area
		require
			not_void: a_notebook /= Void
		do
			create Result

			Result.append ((create {SD_ZONE_MANAGEMENT_MENU}.make (a_notebook)).items)

			if attached (create {SD_SHARED}).notebook_tab_area_menu_items_agent as l_agent then
				if attached a_notebook.selected_item as l_content then
					Result.append (l_agent (l_content))
				end
			elseif not notebook_tab_area_menu_items.is_empty then
				notebook_tab_area_menu_items.do_all (agent (a_item: EV_MENU_ITEM)
														do
															if attached a_item.parent as l_parent then
																l_parent.prune (a_item)
															end
														end)
				Result.append (notebook_tab_area_menu_items)
			end
		ensure
			not_void: Result /= Void
		end

	title_area_menu: EV_MENU
			-- Right click menu for {SD_CONTENT}'s title bar area
		local
			l_shared: SD_SHARED
			l_zone: detachable SD_ZONE
		do
			create Result
			create l_shared
			if attached l_shared.title_bar_area_menu_items_agent as l_agent then
				l_zone := zone_under_pointer_of_all_managers
				if l_zone /= Void and then l_zone.has_content then
					Result.append (l_agent (l_zone.content))
				end
			elseif not title_bar_area_menu_items.is_empty then
				title_bar_area_menu_items.do_all (agent (a_item: EV_MENU_ITEM)
														do
															if attached a_item.parent as l_parent then
																l_parent.prune (a_item)
															end
														end)
				Result.append (title_bar_area_menu_items)
			end
		end

feature {NONE} -- Implementation

	zone_under_pointer_of_all_managers: detachable SD_ZONE
			-- Find {SD_ZONE} under current pointer position.
		local
			l_list: ARRAYED_LIST [SD_DOCKING_MANAGER]
		do
			from
				l_list := (create {SD_SHARED}).docking_manager_list
				l_list.start
			until
				l_list.after or Result /= Void
			loop
				Result := l_list.item.query.zone_under_pointer
				l_list.forth
			end
		end

	internal_style: INTEGER
			-- One value from style enumeration.

feature -- Enumeration

	style_all_same: INTEGER = 1
			-- Look and feel which all the same.

	style_different: INTEGER = 2;
			-- Look and feel which different.

invariant

	not_void: title_bar_area_menu_items /= Void
	not_void: notebook_tab_area_menu_items /= Void

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2018, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
