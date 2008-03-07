indexing
	description: "Container in top conainter level, contain other SD_ZONEs."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_MULTI_DOCK_AREA

inherit
	EV_CELL

	SD_ACCESS
		undefine
			default_create,
			is_equal,
			copy
		end

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
			l_item: SD_MIDDLE_CONTAINER
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
			-- Save a_widget split position recursively if a_widget is SD_MIDDLE_CONTAINER.
			-- Pre order
			-- Post order is not possible. Because set parent split are split positin will take ecffect to its child.
		require
			a_widget_not_void: a_widget /= Void
		local
			l_split: SD_MIDDLE_CONTAINER
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
			l_split: SD_MIDDLE_CONTAINER
		do
			l_split ?= a_widget
			if l_split /= Void then
				spliters.start
				restore_spliter_position_imp (l_split)
			end
		end

	update_middle_container is
			-- Update all middle containers, if it's minimized then use horizontal/vertical box, otherwise use real spliter area.
		local
			l_item: SD_MIDDLE_CONTAINER
			l_is_all_minimized: BOOLEAN
		do
			if not internal_docking_manager.property.is_opening_config then
				if readable then
					l_item ?= item
					if l_item /= Void then
						l_is_all_minimized := update_middle_container_imp (l_item)
						if l_is_all_minimized then
							-- All zone are minimized, we should do nothing.
						end
					else
						recover_normal_for_only_one
					end
				end
			end
		end

	update_visible is
			-- Update container visible.
		local
			l_item: SD_MIDDLE_CONTAINER
			l_is_all_invisible: BOOLEAN
		do
			if readable then
				l_item ?= item
				if l_item /= Void then
					l_is_all_invisible := update_visible_imp (l_item)
				end
			end
		end

	recover_normal_for_only_one is
			-- If there is only one minimized zone, we restore it.
		local
			l_zone_upper: SD_UPPER_ZONE
		do
			if readable then
				l_zone_upper ?= item
				if l_zone_upper /= Void then
					if l_zone_upper.is_minimized then
						l_zone_upper.on_minimize
					end
				end
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
				Result := internal_docking_manager.query.all_zones_in_widget (item)
			end
		end

	parent_floating_zone: SD_FLOATING_ZONE
			-- If `Current' is in a SD_FLOATING_ZONE, this is parent. Otherwise it should be Void.

	editor_zone_count: INTEGER is
			-- If current have eidtor zone?
		local
			l_zones: like zones
		do
			l_zones := zones
			from
				l_zones.start
			until
				l_zones.after
			loop
				if l_zones.item.type = {SD_ENUMERATION}.editor then
					Result := Result + 1
				end
				l_zones.forth
			end
		end

	editor_parent: EV_CONTAINER is
			-- All editor zones top level parent.
			-- If Result Void means widget structure corrupted.
		require
			has_editor: editor_zone_count > 0 or has_place_holder_zone
		local
			l_zone: SD_ZONE
			l_parent, l_last_parent: EV_CONTAINER
			l_list, l_all_editors: ARRAYED_LIST [SD_ZONE]
		do
			Result := editor_place_holder_parent
			if Result = Void then
				l_all_editors := all_editors
				if l_all_editors.count > 0 then
					from
						l_zone := l_all_editors.first
						l_parent := l_zone.parent
						l_last_parent := l_zone
					until
						l_parent = Void or Result /= Void
					loop
						if l_parent = Current then
							Result := Current
						else
							l_list := internal_docking_manager.query.all_zones_in_widget (l_parent)
							if not is_all_editors (l_list) then
								-- Now we find the top container of all editors
								Result := l_last_parent
							end
							l_last_parent := l_parent
							l_parent := l_parent.parent
						end
					end
				end
			end
		end

	has_place_holder_zone: BOOLEAN is
			-- If place holder zone docking?
		do
			Result := editor_place_holder_parent /= Void
		end

	all_editors: ARRAYED_LIST [SD_ZONE] is
			-- One editor in Current.
		local
			l_zones: like zones
		do
			l_zones := zones
			from
				create Result.make (5)
				l_zones.start
			until
				l_zones.after
			loop
				if l_zones.item.type = {SD_ENUMERATION}.editor then
					Result.extend (l_zones.item)
				end
				l_zones.forth
			end
		ensure
			not_void: Result /= Void
			is_all_editors: is_all_editors (Result)
		end

feature {NONE} -- Implementation

	is_all_editors (a_list: ARRAYED_LIST [SD_ZONE]): BOOLEAN is
			-- If `a_list' all eidtor type zones?
		require
			not_void: a_list /= Void
			at_least_one: a_list.count > 0
		do
			from
				Result := True
				a_list.start
			until
				a_list.after or not Result
			loop
				if a_list.item.content.type /= {SD_ENUMERATION}.editor then
					Result := False
				end
				a_list.forth
			end
		end

	has_editor (a_list: ARRAYED_LIST [SD_ZONE]): BOOLEAN is
			-- If `a_list' has editor type zone?
		require
			not_void: a_list /= Void
			at_least_one: a_list.count > 0
		do
			from
				a_list.start
			until
				a_list.after or Result
			loop
				if a_list.item.content.type = {SD_ENUMERATION}.editor then
					Result := True
				end
				a_list.forth
			end
		end

	is_all_tools (a_list: ARRAYED_LIST [SD_ZONE]): BOOLEAN is
	 		-- If `a_list' all tool type zones?
	 	require
	 		not_void: a_list /= Void
	 		at_least_one: a_list.count > 0
	 	do
	 		from
	 			Result := True
	 			a_list.start
	 		until
	 			a_list.after or not Result
	 		loop
	 			if a_list.item.content.type /= {SD_ENUMERATION}.tool then
	 				Result := False
	 			end
	 			a_list.forth
	 		end
	 	end

	editor_place_holder_parent: EV_CONTAINER is
			-- Editor place holder parent, if exits.
		local
			l_zones: like zones
			l_place_holder: SD_PLACE_HOLDER_ZONE
		do
			from
				l_zones := zones
				l_zones.start
			until
				l_zones.after or l_place_holder /= Void
			loop
				if l_zones.item.content.type = {SD_ENUMERATION}.place_holder then
					l_place_holder ?= l_zones.item
					check not_void: l_place_holder /= Void end
				end
				l_zones.forth
			end
			if l_place_holder /= Void then
				Result := l_place_holder.parent
			end
		end

	set_all_title_bar (a_widget: EV_WIDGET) is
	 		-- Set all SD_ZONE's title bar in `Current'.
	 	require
	 		a_widget_not_void: a_widget /= Void
	 	local
	 		l_title_bar_removeable: SD_TITLE_BAR_REMOVEABLE
	 		l_split_area: SD_MIDDLE_CONTAINER
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
					l_zone.set_focus_color (True)
				else
					l_zone.set_focus_color (False)
				end
			end

	 	end

	update_visible_imp (a_middle_container: SD_MIDDLE_CONTAINER): BOOLEAN is
			-- Postorder traversal
			-- If all contained widgets are invisible container, then Result is True.
			-- Otherwise Result is False.
		require
			not_void: a_middle_container /= Void
			parent_not_void: a_middle_container.parent /= Void
		local
			l_widget: EV_WIDGET
			l_middle_container: SD_MIDDLE_CONTAINER
			l_zone: SD_ZONE
			l_left_all_invisible, l_right_all_invisible: BOOLEAN
			l_parent: SD_MIDDLE_CONTAINER
		do
			-- Update all middle container in first widget.
			l_widget := a_middle_container.first
			l_middle_container ?= l_widget
			l_zone ?= l_widget
			if l_middle_container /= Void and then l_zone = Void then
				l_left_all_invisible := update_visible_imp (l_middle_container)
			else
				check not_void: l_zone /= Void end
				l_left_all_invisible := not l_zone.is_displayed
			end

			-- Update all middle container in second widget.
			l_widget := a_middle_container.second
			l_middle_container ?= l_widget
			l_zone ?= l_widget
			if l_middle_container /= Void and then l_zone = Void then
				l_right_all_invisible := update_visible_imp (l_middle_container)
			else
				check not_void: l_zone /= Void end
				l_right_all_invisible := not l_zone.is_displayed
			end

			Result := l_left_all_invisible and l_right_all_invisible

			l_parent ?= a_middle_container
			if Result then
				-- Current should be a invisible container
				a_middle_container.hide
			else
				-- Current should be a visible container
				a_middle_container.show
			end
		end

	update_middle_container_imp (a_middle_container: SD_MIDDLE_CONTAINER): BOOLEAN is
			-- Postorder traversal
			-- If all contained widgets are minimized container, then Result is True.
			-- Otherwise Result is False.
		require
			not_void: a_middle_container /= Void
			parent_not_void: a_middle_container.parent /= Void
		local
			l_widget: EV_WIDGET
			l_middle_container: SD_MIDDLE_CONTAINER
			l_zone: SD_ZONE
			l_upper_zone_left, l_upper_zone_right: SD_UPPER_ZONE
			l_left_all_minimized, l_right_all_minimized: BOOLEAN
			l_parent: SD_MIDDLE_CONTAINER
			l_is_in_first: BOOLEAN
			l_new_parent: SD_MIDDLE_CONTAINER
		do
			-- Update all middle container in first widget.
			l_widget := a_middle_container.first
			l_middle_container ?= l_widget
			l_zone ?= l_widget
			if l_middle_container /= Void and then l_zone = Void then
				l_left_all_minimized := update_middle_container_imp (l_middle_container)
			else
				check not_void: l_zone /= Void end
				l_upper_zone_left ?= l_zone
				if l_upper_zone_left /= Void and then l_upper_zone_left.is_displayed then
					l_left_all_minimized := l_upper_zone_left.is_minimized
				else
					l_left_all_minimized := not l_zone.is_displayed
				end
			end

			-- Update all middle container in second widget.
			l_widget := a_middle_container.second
			l_middle_container ?= l_widget
			l_zone ?= l_widget
			if l_middle_container /= Void and then l_zone = Void then
				l_right_all_minimized := update_middle_container_imp (l_middle_container)
			else
				check not_void: l_zone /= Void end
				l_upper_zone_right ?= l_zone
				if l_upper_zone_right /= Void and then l_upper_zone_right.is_displayed then
					l_right_all_minimized := l_upper_zone_right.is_minimized
				else
					l_right_all_minimized := not l_zone.is_displayed
				end
			end

			Result := l_left_all_minimized and l_right_all_minimized

			l_parent ?= a_middle_container
			if l_left_all_minimized or l_right_all_minimized then
				-- Current should be a minized container

				if l_parent /= Void then
					l_is_in_first := l_parent.first = a_middle_container

					if not l_parent.is_minimized then
						-- If one child is hidden, then the splitter bar is hidden by EV_VERTICAL_SPLIT_AREA/EV_HORIZONTAL_SPLIT_AREA automatically, we don't need to change it.	
						if l_parent.first.is_displayed and l_parent.second.is_displayed then
							disable_item_expand (change_parent_to_minized_container (l_parent), l_left_all_minimized, l_right_all_minimized)
						end
					else
						-- When `l_parent' is minized container already and a child tool container just hidden, we should update splitter bar visible.
						if l_parent.first.is_displayed and l_parent.second.is_displayed then
							l_parent.set_splitter_visible (True)
						else
							l_parent.set_splitter_visible (False)
						end
					end
				end
			else
				-- Current should be a normal spliter area
				if l_parent /= Void then
					if l_parent.is_minimized and not l_left_all_minimized and not l_right_all_minimized then
						l_new_parent := change_parent_to_normal_container (l_parent)
					end
				end
			end

			check not_void: l_widget /= Void end
			l_parent ?= l_widget.parent
			if l_parent /= Void then
				disable_item_expand (l_parent, l_left_all_minimized, l_right_all_minimized)
			end

		end

	disable_item_expand (a_middle_container: SD_MIDDLE_CONTAINER; a_disable_first, a_disable_second: BOOLEAN) is
			-- Disable item expand.
		require
			not_void: a_middle_container /= Void
			full: a_middle_container.count = 2
		local
			l_h_box: SD_HORIZONTAL_BOX
			l_v_box: SD_VERTICAL_BOX
		do
			l_h_box ?= a_middle_container
			l_v_box ?= a_middle_container
			if a_disable_first then
				if l_h_box /= Void then
					l_h_box.disable_item_expand (a_middle_container.first)
				elseif l_v_box /= Void then
					l_v_box.disable_item_expand (a_middle_container.first)
				end
			else
				if l_h_box /= Void then
					l_h_box.enable_item_expand (a_middle_container.first)
				elseif l_v_box /= Void then
					l_v_box.enable_item_expand (a_middle_container.first)
				end
			end

			if a_disable_second then
				if l_h_box /= Void then
					l_h_box.disable_item_expand (a_middle_container.second)
				elseif l_v_box /= Void then
					l_v_box.disable_item_expand (a_middle_container.second)
				end
			else

				if l_h_box /= Void then
					l_h_box.enable_item_expand (a_middle_container.second)
				elseif l_v_box /= Void then
					l_v_box.enable_item_expand (a_middle_container.second)
				end
			end
		end

	change_parent_to_normal_container (a_middle_container: SD_MIDDLE_CONTAINER): SD_MIDDLE_CONTAINER is
			-- Change `a_middle_container' to normal container.
		require
			not_void: a_middle_container /= Void
			minimized: a_middle_container.is_minimized
		local
			l_v_box: SD_VERTICAL_BOX
			l_h_box: SD_HORIZONTAL_BOX

			l_parent: EV_CONTAINER
			l_first, l_second: EV_WIDGET

			l_parent_middle_container: SD_MIDDLE_CONTAINER
			l_parent_split_position: INTEGER
			l_split_position: INTEGER
		do
			l_parent := a_middle_container.parent
			l_parent_middle_container ?= l_parent
			if l_parent_middle_container /= Void then
				l_parent_split_position := l_parent_middle_container.split_position
			end
			l_first := a_middle_container.first
			l_second := a_middle_container.second

			save_spliter_position (a_middle_container)

			l_v_box ?= a_middle_container
			l_h_box ?= a_middle_container
			if l_v_box /= Void then
				create {SD_VERTICAL_SPLIT_AREA} Result
			else
				check not_void: l_h_box /= Void end
				create {SD_HORIZONTAL_SPLIT_AREA} Result
			end

			l_split_position := a_middle_container.split_position
			l_parent.prune (a_middle_container)
			a_middle_container.wipe_out
			l_parent.extend (Result)
			Result.extend (l_first)
			Result.extend (l_second)

			if l_parent_middle_container /= Void then
				l_parent_middle_container.set_split_position (l_parent_split_position)
			end

			restore_spliter_position (Result)

			if l_split_position >= Result.minimum_split_position and l_split_position <= Result.maximum_split_position then
				Result.set_split_position (l_split_position)
			end
		ensure
			not_void: Result /= Void
			not_minimized: not Result.is_minimized
		end

	change_parent_to_minized_container (a_middle_container: SD_MIDDLE_CONTAINER): SD_MIDDLE_CONTAINER is
			-- Change `a_middle_container' to minimized container.
		require
			not_void: a_middle_container /= Void
			not_minimized: not a_middle_container.is_minimized
		local
			l_v_split: EV_VERTICAL_SPLIT_AREA
			l_h_split: EV_HORIZONTAL_SPLIT_AREA

			l_parent: EV_CONTAINER
			l_first, l_second: EV_WIDGET

			l_parent_middle_container: SD_MIDDLE_CONTAINER
			l_parent_split_position: INTEGER
			l_split_position: INTEGER
		do
			l_parent := a_middle_container.parent
			l_parent_middle_container ?= l_parent
			if l_parent_middle_container /= Void then
				l_parent_split_position := l_parent_middle_container.split_position
			end
			l_first := a_middle_container.first
			l_second := a_middle_container.second

			save_spliter_position (a_middle_container)

			l_v_split ?= a_middle_container
			l_h_split ?= a_middle_container
			if l_v_split /= Void then
				create {SD_VERTICAL_BOX} Result
			else
				check not_void: l_h_split /= Void end
				create {SD_HORIZONTAL_BOX} Result
			end
			l_split_position := a_middle_container.split_position
			l_parent.prune (a_middle_container)
			a_middle_container.wipe_out
			l_parent.extend (Result)
			Result.extend (l_first)
			Result.extend (l_second)

			if l_parent_middle_container /= Void then
				l_parent_middle_container.set_split_position (l_parent_split_position)
			end

			restore_spliter_position (Result)

			Result.set_split_position (l_split_position)

		ensure
			not_void: Result /= Void
			minimized: Result.is_minimized
		end

	remove_empty_split_area_imp (a_split_area: SD_MIDDLE_CONTAINER) is
			-- Remove all empty split area in `inner_container' recursively. Postorder traversal.
			-- The structure is a two-fork tree.
			-- Stop at SD_ZONE level.
		require
			a_split_area_not_void: a_split_area /= Void
			a_split_area_parent_not_void: a_split_area.parent /= Void
		local
			l_widget: EV_WIDGET
			l_split: SD_MIDDLE_CONTAINER
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

	up_spliter_level (a_split_area: SD_MIDDLE_CONTAINER; a_first: BOOLEAN) is
			-- If SD_MIDDLE_CONTAINER not full, then prune it from its parent, insert only one child widget to parent.
		require
			a_split_area_not_void: a_split_area /= Void
		local
			l_widget: EV_WIDGET
			l_widget_split: SD_MIDDLE_CONTAINER
			l_parent: EV_CONTAINER
			l_temp_spliter: SD_MIDDLE_CONTAINER
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

				-- FIXIT: following If cluse is for GTK, on MsWin is not needed.
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

	save_spliter_position_imp (a_spliter: SD_MIDDLE_CONTAINER) is
			-- Save spliter position before prune it.
			-- Post order
		require
			a_spliter_not_void: a_spliter /= Void
		local
			l_left, l_right: SD_MIDDLE_CONTAINER
			l_left_zone, l_right_zone: SD_ZONE
		do
			if a_spliter.full then
				spliters.extend ([a_spliter, a_spliter.split_position])
				debug ("docking")
					io.put_string ("%N SD_MULIT_DOCK_AREA spliter position: save " + a_spliter.split_position.out)
				end
			end

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
		end

	restore_spliter_position_imp (a_spliter: SD_MIDDLE_CONTAINER) is
			-- Restore spliter position. Pre order
		require
			a_spliter_not_void: a_spliter /= Void
		local
			l_left, l_right: SD_MIDDLE_CONTAINER
			l_left_zone, l_right_zone: SD_ZONE
			l_spliter_position: INTEGER
--			l_old_spliter: SD_MIDDLE_CONTAINER -- For check only
		do
			if a_spliter.full then
				l_spliter_position := spliters.item.position
				debug ("docking")
					io.put_string ("%N SD_MULIT_DOCK_AREA spliter position: open " + l_spliter_position.out)
				end
				-- Check
--				l_old_spliter ?= spliters.item [1]
--				check l_old_spliter /= Void and then l_old_spliter = a_spliter end

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
		end

feature {NONE} -- Implementation attributes

	spliters: ARRAYED_LIST [TUPLE [middle: SD_MIDDLE_CONTAINER; position: INTEGER]]
			-- Split areas used for save/restore spliter positions.

	internal_shared: SD_SHARED
			-- All singletons.

	internal_docking_manager: SD_DOCKING_MANAGER;
			-- Docking manager which Current belong to.
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
