indexing
	description: "Objects that store config datas about four auto hide zones."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_AUTO_HIDE_PANEL_DATA

create
	make

feature {NONE} -- Initlization

	make is
			-- Creation method.
		local
			l_top, l_bottom, l_left, l_right: like internal_panel_data
		do
--			create internal_zone_bottom.make(1)
--			create internal_zone_left.make (1)
--			create internal_zone_right.make (1)
--			create internal_zone_top.make (1)
			create internal_panel_datas.make (4)
			create l_top.make (1)
			create l_bottom.make (1)
			create l_left.make (1)
			create l_right.make (1)
			internal_panel_datas.extend (l_top)
			internal_panel_datas.extend (l_bottom)
			internal_panel_datas.extend (l_left)
			internal_panel_datas.extend (l_right)
		end

feature -- Properties

	top: like internal_panel_data is
			-- Top SD_AUTO_HIDE_PANEL data.
		do
			Result := internal_panel_datas.i_th (1)
		ensure
			not_void: Result /= Void
		end

	bottom: like internal_panel_data is
			-- Bottom SD_AUTO_HIDE_PANEL data.
		do
			Result := internal_panel_datas.i_th (2)
		ensure
			not_void: Result /= Void
		end

	left: like internal_panel_data is
			-- Left SD_AUTO_HIDE_PANEL data.
		do
			Result := internal_panel_datas.i_th (3)
		ensure
			not_void: Result /= Void
		end

	right: like internal_panel_data is
			-- Right SD_AUTO_HIDE_PANEL data.
		do
			Result := internal_panel_datas.i_th (4)
		ensure
			not_void: Result /= Void
		end

	add_zone_group_data (a_direction: INTEGER; a_data: like internal_tab_group) is
			-- Add a group data to `internal_zone_top' or `internal_zone_bottom' or `internal_zone_left' or `internal_zone_right'.
		require
			a_direction_valid: a_direction = {SD_DOCKING_MANAGER}.dock_top or a_direction = {SD_DOCKING_MANAGER}.dock_bottom
				or a_direction = {SD_DOCKING_MANAGER}.dock_left or a_direction = {SD_DOCKING_MANAGER}.dock_right
			not_void: a_data /= Void
		local
			l_data: like internal_panel_data
		do
			inspect
				a_direction
			when {SD_DOCKING_MANAGER}.dock_top then
				l_data := internal_panel_datas.i_th (1)
			when {SD_DOCKING_MANAGER}.dock_bottom then
				l_data := internal_panel_datas.i_th (2)
			when {SD_DOCKING_MANAGER}.dock_left then
				l_data := internal_panel_datas.i_th (3)
			when {SD_DOCKING_MANAGER}.dock_right then
				l_data := internal_panel_datas.i_th (4)
			end
			l_data.extend (a_data)
		ensure
			has:
		end

--	add_zone_top_group_data (a_group_data: like internal_tab_group) is
--			-- Add a group data to `internal_zone_top'.
--		require
--			not_void: a_group_data /= Void
--		do
--			internal_zone_top.extend (a_group_data)
--		ensure
--			added: internal_zone_top.has (a_group_data)
--		end
--
--	add_zone_bottom_group_data (a_group_data: like internal_tab_group) is
--			-- Add a group data to `internal_zone_bottom'.
--		require
--			not_void: a_group_data /= Void
--		do
--			internal_zone_bottom.extend (a_group_data)
--		ensure
--			added: internal_zone_bottom.has (a_group_data)
--		end
--
--	add_zone_left_group_data (a_group_data: like internal_tab_group) is
--			-- Add a group data to `internal_zone_left'.
--		require
--			not_void: a_group_data /= Void
--		do
--			internal_zone_left.extend (a_group_data)
--		ensure
--			added: internal_zone_left.has (a_group_data)
--		end
--
--	add_zone_right_group_data (a_group_data: like internal_tab_group) is
--			-- Add a group data to `internal_zone_right'.
--		require
--			not_void: a_group_data /= Void
--		do
--			internal_zone_right.extend (a_group_data)
--		ensure
--			added: internal_zone_right.has (a_group_data)
--		end

feature {NONE} -- Implementation

	internal_panel_datas: ARRAYED_LIST [like internal_panel_data]
			-- Four auto hide tab stubs area config data. 1st is top one, 2nd is bottom one, 3rd is left one, 4th is right one.

	internal_panel_data: ARRAYED_LIST [like internal_tab_group] is
			--
			-- In tuple, first argument is title of content. second is width/height of zone.
		require
			False
		do
		end

	internal_tab_group: ARRAYED_LIST [TUPLE [STRING, INTEGER, INTEGER, INTEGER]] is
			-- Anchor type
			-- In the Tuple, first argument is SD_CONTENT unique name.
			--               second argument is last_width_height of a SD_AUTO_HIDE_ZONE.
			--               third argument is last_floating_width of a SD_STATE
			--               forth argument is last_floating_height of a SD_STATE

		require
			False
		do
		end

invariant

	internal_panel_datas_not_void: internal_panel_datas /= Void

indexing
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
