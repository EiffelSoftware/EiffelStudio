note
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

	make
			-- Creation method.
		local
			l_top, l_bottom, l_left, l_right: like internal_panel_datum
		do
			create internal_panel_data.make (4)
			create l_top.make (1)
			create l_bottom.make (1)
			create l_left.make (1)
			create l_right.make (1)
			internal_panel_data.extend (l_top)
			internal_panel_data.extend (l_bottom)
			internal_panel_data.extend (l_left)
			internal_panel_data.extend (l_right)
		end

feature -- Properties

	top: like internal_panel_datum
			-- Top SD_AUTO_HIDE_PANEL data.
		do
			Result := internal_panel_data.i_th (1)
		ensure
			not_void: Result /= Void
		end

	bottom: like internal_panel_datum
			-- Bottom SD_AUTO_HIDE_PANEL data.
		do
			Result := internal_panel_data.i_th (2)
		ensure
			not_void: Result /= Void
		end

	left: like internal_panel_datum
			-- Left SD_AUTO_HIDE_PANEL data.
		do
			Result := internal_panel_data.i_th (3)
		ensure
			not_void: Result /= Void
		end

	right: like internal_panel_datum
			-- Right SD_AUTO_HIDE_PANEL data.
		do
			Result := internal_panel_data.i_th (4)
		ensure
			not_void: Result /= Void
		end

	add_zone_group_data (a_direction: INTEGER; a_data: like internal_tab_group)
			-- Add a group data to `internal_zone_top' or `internal_zone_bottom' or `internal_zone_left' or `internal_zone_right'.
		require
			a_direction_valid: a_direction = {SD_ENUMERATION}.top or a_direction = {SD_ENUMERATION}.bottom
				or a_direction = {SD_ENUMERATION}.left or a_direction = {SD_ENUMERATION}.right
			not_void: a_data /= Void
		local
			l_data: like internal_panel_datum
		do
			inspect
				a_direction
			when {SD_ENUMERATION}.top then
				l_data := internal_panel_data.i_th (1)
			when {SD_ENUMERATION}.bottom then
				l_data := internal_panel_data.i_th (2)
			when {SD_ENUMERATION}.left then
				l_data := internal_panel_data.i_th (3)
			when {SD_ENUMERATION}.right then
				l_data := internal_panel_data.i_th (4)
			end
			l_data.extend (a_data)
		ensure
			has:
		end

feature {NONE} -- Implementation

	internal_panel_data: ARRAYED_LIST [like internal_panel_datum]
			-- Four auto hide tab stubs area config data. 1st is top one, 2nd is bottom one, 3rd is left one, 4th is right one.

	internal_panel_datum: ARRAYED_LIST [like internal_tab_group]
			--
			-- In tuple, first argument is title of content. second is width/height of zone.
		require
			False
		do
		end

	internal_tab_group: ARRAYED_LIST [TUPLE [STRING_GENERAL, INTEGER, INTEGER, INTEGER]]
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

	internal_panel_data_not_void: internal_panel_data /= Void

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
