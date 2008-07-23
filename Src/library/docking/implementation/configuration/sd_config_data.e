indexing
	description: "Objects that represent the data about inner container's structure."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_CONFIG_DATA

create
	make

feature {NONE} -- Initlization
	make is
			-- Creation method.
		do
			create internal_inner_container_data.make (1)
			create internal_auto_hide_zones_data.make
			create tool_bar_data.make (1)
			create maximized_tools.make (1)
			create resizable_items_data.make (1)
			name := ""
		end

feature -- Properties

	name: STRING_32
			-- Name of this layout.

	set_name (a_name: like name) is
			-- Set `name'
		require
			not_void: a_name /= Void
		do
			name := a_name
		ensure
			set: name = a_name
		end

	set_is_docking_locked (a_bool: BOOLEAN) is
			-- Set `is_docking_locked' with `a_bool'
		do
			is_docking_locked := a_bool
		ensure
			set: is_docking_locked = a_bool
		end

	is_docking_locked: BOOLEAN
			-- If tools docking mechanism locked?

	set_is_tool_bar_locked (a_bool: BOOLEAN) is
			--  Set `is_tool_bar_locked' with `a_bool'
		do
			is_tool_bar_locked := a_bool
		ensure
			set: is_tool_bar_locked = a_bool
		end

	is_tool_bar_locked: BOOLEAN
			-- If tool bar manager is locked?

	set_is_editor_docking_locked (a_bool: BOOLEAN) is
			-- Set `is_editor_docking_locked' with `a_bool'
		do
			is_editor_docking_locked := a_bool
		ensure
			set: is_editor_docking_locked = a_bool
		end

	is_editor_docking_locked: BOOLEAN
			-- If editors docking mechanism locked?

	inner_container_data: like internal_inner_container_data is
			-- Value of `internal_inner_container_data'
		do
			Result := internal_inner_container_data
		end

	set_inner_container_data (a_data: like internal_inner_container_data) is
			-- Set `internal_inner_container_data' with `a_data'.
		require
			a_data_not_void: a_data /= Void
		do
			internal_inner_container_data := a_data
		ensure
			a_data_set: a_data = internal_inner_container_data
		end

	auto_hide_panels_data: like internal_auto_hide_zones_data is
			-- Value of `auto_hide_panels_data'
		do
			Result := internal_auto_hide_zones_data
		end

	tool_bar_data: ARRAYED_LIST [SD_TOOL_BAR_DATA]
			-- Four direction tool bar data. 1 is top, 2 is bottom, 3 is left, 4 is right.

	resizable_items_data: ARRAYED_LIST [TUPLE [name: STRING_GENERAL; width: INTEGER]]
			-- Tool bar resizable items data.

	set_resizable_items_data (a_data: like resizable_items_data) is
			-- Set `tool_bar_data' with `a_data'.
		require
			not_void: a_data /= Void
		do
			resizable_items_data := a_data
		ensure
			set: resizable_items_data = a_data
		end

feature -- Data for only one editor zone

	is_one_editor_zone: BOOLEAN
			-- If only one editor zone in Current layout?

	set_is_one_editor_zone (a_bool: BOOLEAN) is
			-- Set `is_one_editor_zone' with `a_bool'
		do
			is_one_editor_zone := a_bool
		ensure
			set: is_one_editor_zone = a_bool
		end

	is_editor_minimized: BOOLEAN
			-- If `is_one_editor_zone', is the only one editor zone minimized?

	set_is_editor_minimized (a_bool: BOOLEAN) is
			-- Set `is_editor_minimized' with `a_bool'
		do
			is_editor_minimized := a_bool
		ensure
			set: is_editor_minimized = a_bool
		end

feature -- Data for maximized.

	maximized_tools: ARRAYED_LIST [STRING_GENERAL]
			-- Maximized tool, count is 0 if no maximized tool.

feature {NONE}  -- Implementation

	internal_inner_container_data: ARRAYED_LIST [SD_INNER_CONTAINER_DATA]
			-- SD_MUTLI_DOCK_AREA layout data.

	internal_auto_hide_zones_data: SD_AUTO_HIDE_PANEL_DATA;
			-- Auto hide zones data.

invariant
	not_void: maximized_tools /= Void
	not_void: resizable_items_data /= Void

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
