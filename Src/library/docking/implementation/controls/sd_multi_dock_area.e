indexing
	description: "Objects that is the center mulit docking area."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_MULTI_DOCK_AREA

inherit
	EV_CELL

create
	make

feature {NONE} -- Initlization
	make (a_docking_manager: SD_DOCKING_MANAGER) is
			-- Creation method.
		require
			a_docking_manager_not_void: a_docking_manager /= Void
		do
			default_create
			internal_docking_manager := a_docking_manager
			create internal_shared
		ensure
			set: internal_docking_manager = a_docking_manager
		end

feature -- Command

	update_title_bar is
			-- If `Current' parent is a SD_FLOATING_ZONE, update title bar.
		local
			l_zone_title: SD_TITLE_BAR_REMOVEABLE
			l_zone: SD_ZONE
		do
			if parent_floating_zone /= Void then
				parent_floating_zone.update_title_bar
			end
			if readable then
				set_all_title_bar (item)
				l_zone_title ?= item
				l_zone ?= item
				if l_zone_title /= Void and not l_zone.is_maximized then
					l_zone_title.set_show_normal_max (False)
				end
			end
		end

	set_parent_floating_zone (a_floating_zone: SD_FLOATING_ZONE) is
			-- Set `parent_floating_zone'.
		require
			a_floating_zone_not_void: a_floating_zone /= Void
		do
			parent_floating_zone := a_floating_zone
		ensure
			set: parent_floating_zone = a_floating_zone
		end

	remove_empty_split_area is
			-- Remove all empty split area in `inner_container' recursively.
		local
			l_item: EV_SPLIT_AREA
		do
			if readable then
				l_item ?= item
				if l_item /= Void then
					remove_empty_split_area_imp (l_item)
				end
			end
		ensure
			not_has_empty_split_area:
		end

	save_spliter_position (a_widget: EV_WIDGET) is
			-- Save a_widget split position recursively if a_widget is EV_SPLIT_AREA.
		require
			a_widget_not_void: a_widget /= Void
		local
			l_split: EV_SPLIT_AREA
		do
			l_split ?= a_widget
			if l_split /= Void then
				create spliters.make (1)
				save_spliter_position_imp (l_split)
			end
		end

	restore_spliter_position (a_widget: EV_WIDGET) is
			-- Restore a_widget split postion which just saved by save_spliter_position.
		require
			a_widget_not_void: a_widget /= Void
		local
			l_split: EV_SPLIT_AREA
		do
			l_split ?= a_widget
			if l_split /= Void then
				spliters.start
				restore_spliter_position_imp (l_split)
			end
		end

feature -- Query

	has_zone (a_zone: SD_ZONE): BOOLEAN is
			-- Does `a_zone' in `Current' recursively.
		require
			a_zone_not_void: a_zone /= Void
		local
			l_widget: EV_WIDGET
		do
			l_widget ?= a_zone
			check l_widget /= Void end
			Result := has_recursive (l_widget)
		end

	zones: ARRAYED_LIST [SD_ZONE] is
			-- All zones in Current.
		do
			create Result.make (1)
			if readable	then
				zones_recursive (item, Result)
			end
		end

	zones_recursive (a_widget: EV_WIDGET; a_list: like zones) is
			-- Add all zones in `a_widget' to `a_list'.
		require
			a_widget_not_void: a_widget /= Void
			a_list_not_void: a_list /= Void
		local
			l_zone: SD_ZONE
			l_container: EV_SPLIT_AREA
		do
			l_zone ?= a_widget
			l_container ?= a_widget
			if l_zone /= Void then
				a_list.extend (l_zone)
			elseif l_container /= Void then
				zones_recursive (l_container.first, a_list)
				zones_recursive (l_container.second, a_list)
			end
		end

	parent_floating_zone: SD_FLOATING_ZONE
			-- If `Current' is in a SD_FLOATING_ZONE, this is parent. Otherwise it should be Void.

feature {NONE} -- Implementation

	 set_all_title_bar (a_widget: EV_WIDGET) is
	 		-- Set all SD_ZONE's title bar in `Current'.
	 	require
	 		a_widget_not_void: a_widget /= Void
	 	local
	 		l_title_bar_removeable: SD_TITLE_BAR_REMOVEABLE
	 		l_split_area: EV_SPLIT_AREA
	 		l_zone: SD_ZONE
	 	do
			l_split_area ?= a_widget
			if l_split_area /= Void then
				if l_split_area.first /= Void then
					set_all_title_bar (l_split_area.first)
				end
				if l_split_area.second /= Void then
					set_all_title_bar (l_split_area.second)
				end
			end
			l_title_bar_removeable ?= a_widget
			if l_title_bar_removeable /= Void then
				if parent_floating_zone = Void  then
					l_title_bar_removeable.set_show_normal_max (True)
				end

				if parent_floating_zone = Void then
					l_title_bar_removeable.set_show_stick (True)
				else
					l_title_bar_removeable.set_show_stick (False)
				end
			end

			l_zone ?= a_widget
			if l_zone /= Void then
				if internal_docking_manager.property.last_focus_content /= Void and then l_zone.has (internal_docking_manager.property.last_focus_content) then
					l_zone.set_title_bar_selection_color (True)
				else
					l_zone.set_title_bar_selection_color (False)
				end
			end

	 	end

	remove_empty_split_area_imp (a_split_area: EV_SPLIT_AREA) is
			-- Remove all empty split area in `inner_container' recursively. Postorder traversal.
			-- The structure is a two-fork tree.
			-- Stop at SD_ZONE level.
		require
			a_split_area_not_void: a_split_area /= Void
			a_split_area_parent_not_void: a_split_area.parent /= Void
		local
			l_widget: EV_WIDGET
			l_split: EV_SPLIT_AREA
			l_zone: SD_ZONE
		do
			-- Remove all empty area in first widget.
			l_widget := a_split_area.first
			l_split ?= l_widget
			l_zone ?= l_widget
			-- If is a split area.
			if l_split /= Void and then l_zone = Void then
				remove_empty_split_area_imp (l_split)
			end
			-- Remove all empty area in second widget.
			l_widget := a_split_area.second
			l_split ?= l_widget
			l_zone ?= l_widget
			-- If is a split area.
			if l_split /= Void and then l_zone = Void then
				remove_empty_split_area_imp (l_split)
			end

			if a_split_area.is_empty then
				a_split_area.parent.prune (a_split_area)
			elseif a_split_area.second = Void then
				up_spliter_level (a_split_area, True)
			elseif a_split_area.first = Void then
				up_spliter_level (a_split_area, False)
			end
		end

	up_spliter_level (a_split_area: EV_SPLIT_AREA; a_first: BOOLEAN) is
			-- If EV_SPLIT_AREA not full, then prune it from its parent, insert only one child widget to parent.
		require
			a_split_area_not_void: a_split_area /= Void
		local
			l_widget: EV_WIDGET
			l_widget_split: EV_SPLIT_AREA
			l_parent: EV_CONTAINER
			l_temp_spliter: EV_SPLIT_AREA
			l_spliter_position: INTEGER
		do
			if a_first then
				l_widget := a_split_area.first
			else
				l_widget := a_split_area.second
			end

			l_parent := a_split_area.parent
			l_temp_spliter ?= l_parent

			if l_temp_spliter /= Void then
				l_spliter_position := l_temp_spliter.split_position
				debug ("docking")
					io.put_string ("%N SD_MULTI_DOCK_AREA l_spliter_position" + l_spliter_position.out)
				end
			end

			l_widget_split ?= l_widget
			if l_widget_split /= Void then
				save_spliter_position (l_widget_split)
			end

			l_parent.prune (a_split_area)
			a_split_area.prune (l_widget)
			l_parent.extend (l_widget)

			if l_temp_spliter /= Void and l_temp_spliter.full then
				-- There should by only one, because Postorder, so NO recursive needed.
				-- The split area must full, because Postorder recursive.
				
				-- FIXIT: following If cluse if for GTK, on MsWin is not needed.
					if l_spliter_position < l_temp_spliter.minimum_split_position then
						l_spliter_position := l_temp_spliter.minimum_split_position
					end
					if l_spliter_position > l_temp_spliter.maximum_split_position then
						l_spliter_position := l_temp_spliter.maximum_split_position
					end
					l_temp_spliter.set_split_position (l_spliter_position)
			end

			if l_widget_split /= Void then
				restore_spliter_position (l_widget_split)
			end
		ensure
			a_split_area_child_pruned: a_split_area.count = 0
			spliter_level_up_done:
		end

	save_spliter_position_imp (a_spliter: EV_SPLIT_AREA) is
			-- Save spliter position before prune it.
		require
			a_spliter_not_void: a_spliter /= Void
		local
			l_left, l_right: EV_SPLIT_AREA
			l_left_zone, l_right_zone: SD_ZONE
		do
			l_left ?= a_spliter.first
			l_left_zone ?= l_left
			if l_left /= Void and then l_left_zone = Void then
				save_spliter_position_imp (l_left)
			end

			l_right ?= a_spliter.second
			l_right_zone ?= l_right
			if l_right /= Void and then l_right_zone = Void then
				save_spliter_position_imp (l_right)
			end

			if a_spliter.full then
				spliters.extend ([a_spliter, a_spliter.split_position])
				debug ("docking")
					io.put_string ("%N SD_MULIT_DOCK_AREA spliter position: save " + a_spliter.split_position.out)
				end
			end
		end

	restore_spliter_position_imp (a_spliter: EV_SPLIT_AREA) is
			-- Restore spliter position.
		require
			a_spliter_not_void: a_spliter /= Void
		local
			l_left, l_right: EV_SPLIT_AREA
			l_left_zone, l_right_zone: SD_ZONE
			l_spliter_position: INTEGER
			l_old_spliter: EV_SPLIT_AREA
		do
			l_left ?= a_spliter.first
			l_left_zone ?= l_left
			if l_left /= Void and then l_left_zone = Void then
				restore_spliter_position_imp (l_left)
			end

			l_right ?= a_spliter.second
			l_right_zone ?= l_right
			if l_right /= Void and then l_right_zone = Void then
				restore_spliter_position_imp (l_right)
			end

			if a_spliter.full then
				l_spliter_position := spliters.item.integer_item (2)
				debug ("docking")
					io.put_string ("%N SD_MULIT_DOCK_AREA spliter position: open " + l_spliter_position.out)
				end
				-- Check
				l_old_spliter ?= spliters.item [1]
				check l_old_spliter /= Void and then l_old_spliter = a_spliter end

				check a_spliter.full end

				debug ("docking")
					io.put_string ("%N SD_MULIT_DOCK_AREA spliter position: max " + a_spliter.maximum_split_position.out + " min " + a_spliter.minimum_split_position.out)
				end
				if l_spliter_position >= a_spliter.minimum_split_position and l_spliter_position <= a_spliter.maximum_split_position then
					a_spliter.set_split_position (l_spliter_position)
				elseif l_spliter_position >= a_spliter.maximum_split_position then
					a_spliter.set_split_position (a_spliter.maximum_split_position)
				end -- No need to set min_split_position, because default is min_split_position.

				spliters.forth
			end
		end

feature {NONE} -- Implementation attributes

	spliters: ARRAYED_LIST [TUPLE [EV_SPLIT_AREA, INTEGER]]
			-- Split areas used for save/restore spliter positions.

	internal_shared: SD_SHARED
			-- All singletons.

	internal_docking_manager: SD_DOCKING_MANAGER;
			-- Docking manager which Current belong to.
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
