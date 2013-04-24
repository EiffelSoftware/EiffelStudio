note
	description: "Smart Docking library widget lists."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_WIDGETS_LISTS

inherit
	IDENTIFIED

feature -- Query

	all_tool_bars: ARRAYED_LIST [SD_GENERIC_TOOL_BAR]
			-- All SD_TOOL_BAR instances.
		local
			l_list: ARRAYED_LIST [INTEGER]
		do
			create Result.make (10)

			l_list := all_tool_bar_ids
			if l_list /= Void then
				from
					l_list.start
				until
					l_list.after
				loop
					if attached {SD_GENERIC_TOOL_BAR} id_object (l_list.item) as l_item then
						Result.extend (l_item)
						l_list.forth
					else
						l_list.remove
					end
				end
			end
		ensure
			not_void: Result /= Void
		end

	all_tool_bar_zones: ARRAYED_LIST [SD_TOOL_BAR_ZONE]
			-- All SD_TOOL_BAR_ZONE instances.
		local
			l_list: ARRAYED_LIST [INTEGER]
		do
			create Result.make (10)

			l_list := all_tool_bar_zone_ids
			if l_list /= Void then
				from
					l_list.start
				until
					l_list.after
				loop
					if attached {SD_TOOL_BAR_ZONE} id_object (l_list.item) as l_item then
						Result.extend (l_item)
						l_list.forth
					else
						l_list.remove
					end
				end
			end
		ensure
			not_void: Result /= Void
		end

	all_title_bars: ARRAYED_LIST [SD_TITLE_BAR]
			-- All SD_TITLE_BAR instances.
		local
			l_list: ARRAYED_LIST [INTEGER]
		do
			create Result.make (10)

			l_list := all_title_bar_ids
			if l_list /= Void then
				from
					l_list.start
				until
					l_list.after
				loop
					if attached {SD_TITLE_BAR} id_object (l_list.item) as l_item then
						Result.extend (l_item)
						l_list.forth
					else
						l_list.remove
					end
				end
			end
		ensure
			not_void: Result /= Void
		end

	all_notebooks: ARRAYED_LIST [SD_NOTEBOOK]
			-- All SD_NOTEBOOK instances.
		local
			l_list: ARRAYED_LIST [INTEGER]
		do
			create Result.make (10)

			l_list := all_notebook_ids
			if l_list /= Void then
				from
					l_list.start
				until
					l_list.after
				loop
					if attached {SD_NOTEBOOK} id_object (l_list.item) as l_item then
						Result.extend (l_item)
						l_list.forth
					else
						l_list.remove
					end
				end
			end
		ensure
			not_void: Result /= Void
		end

	all_auto_hide_panels: ARRAYED_LIST [SD_AUTO_HIDE_PANEL]
			-- All SD_AUTO_HIDE_PANEL instances.
		local
			l_list: ARRAYED_LIST [INTEGER]
		do
			create Result.make (10)

			l_list := all_auto_hide_panel_ids
			if l_list /= Void then
				from
					l_list.start
				until
					l_list.after
				loop
					if attached {SD_AUTO_HIDE_PANEL} id_object (l_list.item) as l_item then
						Result.extend (l_item)
						l_list.forth
					else
						l_list.remove
					end
				end
			end
		ensure
			not_void: Result /= Void
		end

feature -- Command is

	add_tool_bar (a_tool_bar: SD_GENERIC_TOOL_BAR)
			-- Add `a_tool_bar''s object id.
		require
			not_void: a_tool_bar /= Void
		do
			all_tool_bar_ids.extend (a_tool_bar.object_id)
		ensure
			has: all_tool_bars.has (a_tool_bar)
		end

	prune_tool_bar (a_tool_bar: SD_GENERIC_TOOL_BAR)
			-- Prune `a_tool_bar''s object id.
		require
			not_void: a_tool_bar /= Void
		do
			all_tool_bar_ids.prune_all (a_tool_bar.object_id)
		ensure
			not_has: not all_tool_bars.has (a_tool_bar)
		end

	add_tool_bar_zone (a_tool_bar_zone: SD_TOOL_BAR_ZONE)
			-- Add `a_tool_bar_zone''s object id.
		require
			not_void: a_tool_bar_zone /= Void
		do
			all_tool_bar_zone_ids.extend (a_tool_bar_zone.object_id)
		ensure
			has: all_tool_bar_zones.has (a_tool_bar_zone)
		end

	prune_tool_bar_zone (a_tool_bar_zone: SD_TOOL_BAR_ZONE)
			-- Prune `a_tool_bar_zone''s id.
		require
			not_void: a_tool_bar_zone /= Void
		do
			all_tool_bar_zone_ids.prune_all (a_tool_bar_zone.object_id)
		ensure
			not_has: not all_tool_bar_zones.has (a_tool_bar_zone)
		end

	add_title_bar (a_title_bar: SD_TITLE_BAR)
			-- Add `a_title_bar''s object id.
		require
			not_void: a_title_bar /= Void
		do
			all_title_bar_ids.extend (a_title_bar.object_id)
		ensure
			has: all_title_bars.has (a_title_bar)
		end

	prune_title_bar (a_title_bar: SD_TITLE_BAR)
			-- Prune `a_title_bar''s id.
		require
			not_void: a_title_bar /= Void
		do
			all_title_bar_ids.prune_all (a_title_bar.object_id)
		ensure
			not_has: not all_title_bars.has (a_title_bar)
		end

	add_notebook (a_notebook: SD_NOTEBOOK)
			-- Add `a_notebook'' object id.
		require
			not_void: a_notebook /= Void
		do
			all_notebook_ids.extend (a_notebook.object_id)
		ensure
			has: all_notebooks.has (a_notebook)
		end

	prune_notebook (a_notebook: SD_NOTEBOOK)
			-- Prune `a_notebook''s object id.
		require
			not_void: a_notebook /= Void
		do
			all_notebook_ids.prune_all (a_notebook.object_id)
		ensure
			not_has: not all_notebooks.has (a_notebook)
		end

	add_auto_hide_panel (a_auto_hide_panel: SD_AUTO_HIDE_PANEL)
			-- Add `a_auto_hide_panel''s object id.
		require
			not_void: a_auto_hide_panel /= Void
		do
			all_auto_hide_panel_ids.extend (a_auto_hide_panel.object_id)
		ensure
			has: all_auto_hide_panels.has (a_auto_hide_panel)
		end

	prune_auto_hide_panel (a_auto_hide_panel: SD_AUTO_HIDE_PANEL)
			-- Prune `a_auto_hide_panel''s object id.
		require
			not_void: a_auto_hide_panel /= Void
		do
			all_auto_hide_panel_ids.prune_all (a_auto_hide_panel.object_id)
		ensure
			not_has: not all_auto_hide_panels.has (a_auto_hide_panel)
		end

feature {NONE} -- Implementation

	all_tool_bar_ids:	ARRAYED_LIST [INTEGER]
			-- Singleton for `all_tool_bars''s object id.
		once
			create Result.make (10)
		end

	all_tool_bar_zone_ids: ARRAYED_LIST [INTEGER]
			-- Singleton for `all_tool_bar_zones''s object id.
		once
			create Result.make (10)
		end

	all_title_bar_ids: ARRAYED_LIST [INTEGER]
			-- Signleton for `all_title_bars'' object id.
		once
			create Result.make (10)
		end

	all_notebook_ids: ARRAYED_LIST [INTEGER]
			-- Singleton for `all_notebooks''s object id.
		once
			create Result.make (10)
		end

	all_auto_hide_panel_ids: ARRAYED_LIST [INTEGER]
			-- Singleton for `all_auto_hide_panels'' object id.
		once
			create Result.make (4)
		end

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
