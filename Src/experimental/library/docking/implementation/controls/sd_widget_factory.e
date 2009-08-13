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
		local
			l_result: detachable like title_bar
		do
			if internal_style = style_all_same  then
				create l_result.make
			elseif internal_style = style_different then
				if a_zone_type = {SD_ENUMERATION}.auto_hide or a_zone_type = {SD_ENUMERATION}.docking then
					create l_result.make
				end
				if a_zone_type = {SD_ENUMERATION}.tab then
					if a_style = {SD_ENUMERATION}.editor then
						l_result := create {SD_TITLE_BAR}.make
						l_result.hide
					elseif a_style = {SD_ENUMERATION}.tool then
						create l_result.make
					end
				end
			end
			check l_result /= Void end  -- Implied by only two kind of styles
			Result := l_result
		ensure
			not_void: Result /= Void
		end

	docking_zone (a_content: SD_CONTENT): SD_DOCKING_ZONE
			-- Docking zone
		local
			l_result: detachable like docking_zone
			l_place_holder_zone: SD_PLACE_HOLDER_ZONE
		do
			if internal_style = style_all_same then
				create {SD_DOCKING_ZONE_NORMAL} l_result.make (a_content)
			else
				check internal_style = style_different end -- Implied by only two kinds of styles
				if a_content.type = {SD_ENUMERATION}.tool then
					create {SD_DOCKING_ZONE_NORMAL} l_result.make (a_content)
				elseif a_content.type = {SD_ENUMERATION}.editor then
					l_result := create {SD_DOCKING_ZONE_UPPER}.make (a_content)
				elseif a_content.type = {SD_ENUMERATION}.place_holder then
					create l_place_holder_zone.make (a_content)
					l_place_holder_zone.set_docking_manager (a_content.docking_manager)
					l_result := l_place_holder_zone
				end
			end

			check l_result /= Void end -- Implied by kinds of zones are fixed
			Result := l_result
		end

	tab_zone (a_content: SD_CONTENT): SD_TAB_ZONE
			-- Tab zone
		require
			a_content_not_void: a_content /= Void
		local
			l_result: detachable like tab_zone
		do
			if internal_style = style_all_same then
				create l_result.make (a_content)
			elseif internal_style = style_different then
			    check style_valid: style_valid (a_content.type) end
				if a_content.type = {SD_ENUMERATION}.tool then
					create l_result.make (a_content)
				elseif a_content.type = {SD_ENUMERATION}.editor then
					l_result := create {SD_TAB_ZONE_UPPER}.make (a_content)
				end
			end

			check l_result /= Void end -- Implied by only two kinds of type and styles
			Result := l_result
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
		local
			l_items: SD_ZONE_MANAGEMENT_MENU
			l_shared: SD_SHARED
			l_content: detachable SD_CONTENT
			l_agent: detachable FUNCTION [ANY, TUPLE [SD_CONTENT], ARRAYED_LIST [EV_MENU_ITEM]]
		do
			create Result

			create l_items.make (a_notebook)
			Result.append (l_items.items)

			create l_shared
			l_agent := l_shared.notebook_tab_area_menu_items_agent
			if l_agent /= Void then
				l_content := a_notebook.selected_item
				if l_content /= Void then
					l_agent.call ([l_content])
					if attached l_agent.last_result as l_result then
						Result.append (l_result)
					end
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
			l_content: SD_CONTENT
			l_shared: SD_SHARED
			l_zone: detachable SD_ZONE
			l_agent: detachable FUNCTION [ANY, TUPLE [SD_CONTENT], ARRAYED_LIST [EV_MENU_ITEM]]
			l_result: detachable like title_area_menu
		do
			create l_shared
			l_agent := l_shared.title_bar_area_menu_items_agent
			if l_agent /= Void then
				l_zone := zone_under_pointer_of_all_managers
				if l_zone /= Void then
					l_content := l_zone.content
					l_agent.call ([l_content])
				end

				if attached l_agent.last_result then
					create l_result
					l_result.append (l_result)
				else
					check something_wrong_in_agent: False end -- Implied by design of `title_bar_area_menu_items_agent'
				end
			elseif not title_bar_area_menu_items.is_empty then
				create l_result
				title_bar_area_menu_items.do_all (agent (a_item: EV_MENU_ITEM)
														do
															if attached a_item.parent as l_parent then
																l_parent.prune (a_item)
															end
														end)
				l_result.append (title_bar_area_menu_items)
			end

			check l_result /= Void end -- Implied by previous if clause
			Result := l_result
		end

feature {NONE} -- Implementation

	zone_under_pointer_of_all_managers: detachable SD_ZONE
			-- Find {SD_ZONE} under current pointer position
		local
			l_list: ARRAYED_LIST [SD_DOCKING_MANAGER]
			l_item: SD_DOCKING_MANAGER
			l_shared: SD_SHARED
		do
			from
				create l_shared
				l_list := l_shared.docking_manager_list
				l_list.start
			until
				l_list.after or Result /= Void
			loop
				l_item := l_list.item

				Result := l_item.query.zone_under_pointer

				l_list.forth
			end
		end

	internal_style: INTEGER
			-- One value from style enumeration

feature -- Enumeration

	style_all_same: INTEGER = 1
			-- Look and feel which all the same
	style_different: INTEGER = 2;
			-- Look and feel which different

invariant

	not_void: title_bar_area_menu_items /= Void
	not_void: notebook_tab_area_menu_items /= Void

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"






end
