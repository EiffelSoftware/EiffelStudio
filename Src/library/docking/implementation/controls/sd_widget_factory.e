indexing
	description: "Factory with responsibility for create docking library widgets base on different style."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_WIDGET_FACTORY

create {SD_SHARED}
	make

feature {NONE} -- Initlization

	make is
			-- Creation method.
		do
			set_style (style_different)

			create notebook_tab_area_menu_items.make (10)
			create title_bar_area_menu_items.make (10)
		ensure
			default_style_set: internal_style = style_different
		end

feature -- Status setting

	set_style (a_style: INTEGER) is
			-- Set style to one of enumeration at end of this class.
		require
			a_style_valid: style_valid (a_style)
		do
			internal_style := a_style
		ensure
			a_style_set: a_style = internal_style
		end

feature -- Status report

	style_valid (a_style: INTEGER): BOOLEAN is
			-- If `a_style' valid?
		do
			Result := a_style = style_all_same or a_style = style_different
		end

feature -- Factory method.

	title_bar (a_style: INTEGER; a_zone: SD_ZONE): SD_TITLE_BAR is
			-- Title bar.
		require
			a_style_valid: style_valid (a_style)
			a_zone_not_void: a_zone /= Void
		local
			l_auto_hide_zone: SD_AUTO_HIDE_ZONE
			l_docking_zone: SD_DOCKING_ZONE
			l_tab_zone: SD_TAB_ZONE
		do
			if internal_style = style_all_same  then
				create Result.make
			elseif internal_style = style_different then
				l_auto_hide_zone ?= a_zone
				l_docking_zone ?= a_zone
				if l_auto_hide_zone /= Void or l_docking_zone /= Void then
					create Result.make
				end
				l_tab_zone ?= a_zone
				if l_tab_zone /= Void then

					if a_style = {SD_ENUMERATION}.editor then
						Result := create {SD_TITLE_BAR}.make
						Result.hide
					elseif a_style = {SD_ENUMERATION}.tool then
						create Result.make
					end
				end
			end
		ensure
			not_void: Result /= Void
		end

	docking_zone (a_content: SD_CONTENT): SD_DOCKING_ZONE is
			-- Docking zone.
		do
			if internal_style = style_all_same then
				create {SD_DOCKING_ZONE_NORMAL} Result.make (a_content)
			elseif internal_style = style_different then
				if a_content.type = {SD_ENUMERATION}.tool then
					create {SD_DOCKING_ZONE_NORMAL} Result.make (a_content)
				elseif a_content.type = {SD_ENUMERATION}.editor then
					Result := create {SD_DOCKING_ZONE_UPPER}.make (a_content)
				elseif a_content.type = {SD_ENUMERATION}.place_holder then
					Result := create {SD_PLACE_HOLDER_ZONE}.make (a_content)
				end
			end
		end

	tab_zone (a_content: SD_CONTENT): SD_TAB_ZONE is
			-- Tab zone.
		require
			a_content_not_void: a_content /= Void
		do
			if internal_style = style_all_same then
				create Result.make (a_content)
			elseif internal_style = style_different then
			    check style_valid: style_valid (a_content.type) end
				if a_content.type = {SD_ENUMERATION}.tool then
					create Result.make (a_content)
				elseif a_content.type = {SD_ENUMERATION}.editor then
					Result := create {SD_TAB_ZONE_UPPER}.make (a_content)
				end
			end
		ensure
			not_void: Result /= Void
		end

feature -- Menu

	notebook_tab_area_menu_items: ARRAYED_LIST [EV_MENU_ITEM]
			-- Notebook tab area menu items which can be customized by client programmers in {SD_SHARED}.

	title_bar_area_menu_items: ARRAYED_LIST [EV_MENU_ITEM]
			-- Title bar area menu items which can be customized by client programmers in {SD_SHARED}.

	editor_tab_area_menu (a_notebook: SD_NOTEBOOK): EV_MENU
			-- Right click menu for editor tab area.
		require
			not_void: a_notebook /= Void
		local
			l_items: SD_ZONE_MANAGEMENT_MENU
		do
			create Result

			create l_items.make (a_notebook)
			Result.append (l_items.items)

			if not notebook_tab_area_menu_items.is_empty then
				notebook_tab_area_menu_items.do_all (agent (a_item: EV_MENU_ITEM)
														do
															if a_item.parent /= Void then
																a_item.parent.prune (a_item)
															end
														end)
				Result.append (notebook_tab_area_menu_items)
			end
		ensure
			not_void: Result /= Void
		end

	title_area_menu: EV_MENU
			-- Right click menu for {SD_CONTENT}'s title bar area.
		do
			if not title_bar_area_menu_items.is_empty then
				create Result
				title_bar_area_menu_items.do_all (agent (a_item: EV_MENU_ITEM)
														do
															if a_item.parent /= Void then
																a_item.parent.prune (a_item)
															end
														end)
				Result.append (title_bar_area_menu_items)
			end
		end

feature {NONE} -- Implementation

	internal_style: INTEGER
			-- One value from style enumeration.

feature -- Enumeration

	style_all_same: INTEGER is 1
			-- Look and feel which all the same.
	style_different: INTEGER is 2;
			-- Look and feel which different.

invariant

	not_void: title_bar_area_menu_items /= Void
	not_void: notebook_tab_area_menu_items /= Void

indexing
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
