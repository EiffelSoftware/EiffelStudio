note
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

	SD_DOCKING_MANAGER_HOLDER
		undefine
			default_create,
			is_equal,
			copy
		end

create
	make

feature {NONE} -- Initlization

	make (a_docking_manager: SD_DOCKING_MANAGER)
			-- Associate new object with `a_docking_manager'.
		do
			docking_manager := a_docking_manager
			create internal_shared
			create all_spliters_data.make_equal (5)
			default_create
		end

feature -- Command

	update_title_bar
			-- If `Current' parent is a SD_FLOATING_ZONE, update title bar.
		do
			if attached parent_floating_zone as l_floating_zone then
				l_floating_zone.update_title_bar
			end
			if readable then
				set_all_title_bar (item)
				if
					(attached {SD_TITLE_BAR_REMOVEABLE} item as l_zone_title and
					attached {SD_ZONE} item as l_zone) and then
					not l_zone.is_maximized
				then
					l_zone_title.set_show_normal_max (False)
				end
			end
		end

	set_parent_floating_zone (a_floating_zone: SD_FLOATING_ZONE)
			-- Set `parent_floating_zone'.
		require
			a_floating_zone_not_void: a_floating_zone /= Void
		do
			parent_floating_zone := a_floating_zone
		ensure
			set: parent_floating_zone = a_floating_zone
		end

	remove_empty_split_area
			-- Remove all empty split area in `inner_container' recursively.
		do
			if
				readable and then
				attached {SD_MIDDLE_CONTAINER} item as l_item
			then
				remove_empty_split_area_imp (l_item)
			end
		ensure
			not_has_empty_split_area:
		end

	save_spliter_position (a_widget: EV_WIDGET; a_data_name: READABLE_STRING_32)
			-- Save a_widget split position recursively if a_widget is SD_MIDDLE_CONTAINER.
			-- Pre order.
			-- Post order is not possible. Because set parent split are split positin will take ecffect to its child.
		require
			a_widget_not_void: a_widget /= Void
			not_empty: a_data_name /= Void and then not a_data_name.is_empty
		local
			l_data: like spliters_data
		do
			if attached {SD_MIDDLE_CONTAINER} a_widget as l_split then
				create l_data.make (1)
				all_spliters_data.put (l_data, a_data_name)
				save_spliter_position_imp (l_split, l_data)
			end
		ensure
			data_saved: attached {SD_MIDDLE_CONTAINER} a_widget as lt_widget implies has_spliter_data (a_data_name)
		end

	restore_spliter_position (a_widget: EV_WIDGET; a_data_name: READABLE_STRING_32)
			-- Restore a_widget split postion which saved by save_spliter_position
			-- `a_data_name' is the name when calling `save_spliter_position'.
		require
			a_widget_not_void: a_widget /= Void
			not_empty: a_data_name /= Void and then not a_data_name.is_empty
			data_saved: attached {SD_MIDDLE_CONTAINER} a_widget as lt_widget implies has_spliter_data (a_data_name)
		do
			if attached {SD_MIDDLE_CONTAINER} a_widget as l_split then
				if attached all_spliters_data.item (a_data_name) as l_data then
					l_data.start
					restore_spliter_position_imp (l_split, l_data)
					-- Remove data with `a_name'
					all_spliters_data.remove (a_data_name)
				else
					check
						from_precondition_data_saved: False
					end
				end
			end
		ensure
			data_cleared: attached {SD_MIDDLE_CONTAINER} a_widget as lt_widget_2 implies not has_spliter_data (a_data_name)
		end

	update_middle_container
			-- Update all middle containers, if it's minimized then use horizontal/vertical box, otherwise use real spliter area.
		do
			if
				not docking_manager.property.is_opening_config and then
				readable
			then
				if attached {SD_MIDDLE_CONTAINER} item as l_item then
					update_middle_container_imp (l_item).do_nothing
				else
					recover_normal_for_only_one
				end
			end
		end

	update_visible
			-- Update container visible.
		do
			if
				readable and then
				attached {SD_MIDDLE_CONTAINER} item as l_item
			then
				update_visible_imp (l_item).do_nothing
			end
		end

	recover_normal_for_only_one
			-- If there is only one minimized zone, we restore it.
		do
			if
				readable and then
				attached {SD_UPPER_ZONE} item as l_zone_upper and then
				l_zone_upper.is_minimized
			then
				l_zone_upper.on_minimize
			end
		end

feature -- Query

	has_zone (a_zone: SD_ZONE): BOOLEAN
			-- Does `a_zone' in `Current' recursively.
		require
			a_zone_not_void: a_zone /= Void
		do
			Result := attached {EV_WIDGET} a_zone as l_widget and then has_recursive (l_widget)
		end

	zones: ARRAYED_LIST [SD_ZONE]
			-- All zones in Current.
		do
			create Result.make (1)
			if readable	then
				Result := docking_manager.query.all_zones_in_widget (item)
			end
		end

	parent_floating_zone: detachable SD_FLOATING_ZONE
			-- If `Current' is in a SD_FLOATING_ZONE, this is parent. Otherwise it should be Void.

	editor_zone_count: INTEGER
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

	editor_parent: detachable EV_CONTAINER
			-- All editor zones top level parent.
			-- If Result Void means widget structure corrupted.
		require
--TODO			has_editor: editor_zone_count > 0 or has_place_holder_zone
		local
			l_zone: SD_ZONE
			l_parent, l_last_parent: EV_CONTAINER
			l_list, l_all_editors: ARRAYED_LIST [SD_ZONE]
		do
			if has_place_holder_zone then
				Result := editor_place_holder
			else
				l_all_editors := all_editors
				if l_all_editors.count > 0 then
					from
						l_zone := l_all_editors.first
						if attached {EV_WIDGET} l_zone as lt_widget then
							l_parent := lt_widget.parent
						else
							check not_possible: False end
						end

						if attached {EV_CONTAINER} l_zone as l_container then
							l_last_parent := l_container
						end
					until
						l_parent = Void or Result /= Void
					loop
						if l_parent = Current then
							Result := Current
						else
							l_list := docking_manager.query.all_zones_in_widget (l_parent)
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

	has_place_holder_zone: BOOLEAN
			-- If place holder zone docking?
		do
			Result := editor_place_holder_parent /= Void
		end

	all_editors: ARRAYED_LIST [SD_ZONE]
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

	has_spliter_data (a_name: READABLE_STRING_32): BOOLEAN
			-- Does `all_spliters_data' has data which key is `a_name'?
		require
			not_empty: a_name /= Void and then not a_name.is_empty
		do
			Result := all_spliters_data.has (a_name)
		end

feature {NONE} -- Implementation

	is_all_editors (a_list: ARRAYED_LIST [SD_ZONE]): BOOLEAN
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
				if
					a_list.item.has_content and then
					a_list.item.content.type /= {SD_ENUMERATION}.editor
				then
					Result := False
				end
				a_list.forth
			end
		end

	has_editor (a_list: ARRAYED_LIST [SD_ZONE]): BOOLEAN
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
				if
					a_list.item.has_content and then
					a_list.item.content.type = {SD_ENUMERATION}.editor
				then
					Result := True
				end
				a_list.forth
			end
		end

	is_all_tools (a_list: ARRAYED_LIST [SD_ZONE]): BOOLEAN
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
	 			if
	 				a_list.item.has_content and then
	 				a_list.item.content.type /= {SD_ENUMERATION}.tool
	 			then
	 				Result := False
	 			end
	 			a_list.forth
	 		end
	 	end

	editor_place_holder_parent: detachable EV_CONTAINER
			-- Editor place holder parent, if exists.
		do
			if attached editor_place_holder as l_place_holder then
				Result := l_place_holder.parent
			end
		end

	editor_place_holder: detachable SD_PLACE_HOLDER_ZONE
			-- Find editor place holder zone in `zones'.
		local
			l_zones: like zones
			z: SD_ZONE
		do
			from
				l_zones := zones
				l_zones.start
			until
				l_zones.after or Result /= Void
			loop
				z := l_zones.item
				if
					z.has_content and then
					z.content.type = {SD_ENUMERATION}.place_holder and then
					attached {like editor_place_holder} z as r
				then
					Result := r
				end
				l_zones.forth
			end
		ensure
			not_void_if_exists: has_place_holder_zone implies Result /= Void
		end

	set_all_title_bar (a_widget: EV_WIDGET)
	 		-- Set all SD_ZONE's title bar in `Current'.
	 	require
	 		a_widget_not_void: a_widget /= Void
	 	do
			if attached {SD_MIDDLE_CONTAINER} a_widget as l_split_area then
				if attached l_split_area.first as l_first then
					set_all_title_bar (l_first)
				end
				if attached l_split_area.second as l_second then
					set_all_title_bar (l_second)
				end
			end
			if attached {SD_TITLE_BAR_REMOVEABLE} a_widget as l_title_bar_removeable then
				if parent_floating_zone = Void then
					l_title_bar_removeable.set_show_normal_max (True)
				end

				if parent_floating_zone = Void then
					l_title_bar_removeable.set_show_stick (True)
				else
					l_title_bar_removeable.set_show_stick (False)
				end
			end

			if attached {SD_ZONE} a_widget as l_zone then
				if attached docking_manager.property.last_focus_content as l_content and then l_zone.has (l_content) then
					l_zone.set_focus_color (True)
				else
					l_zone.set_focus_color (False)
				end
			end

	 	end

	update_visible_imp (a_middle_container: SD_MIDDLE_CONTAINER): BOOLEAN
			-- Postorder traversal.
			-- If all contained widgets are invisible container, then Result is True.
			-- Otherwise Result is False.
		require
			not_void: a_middle_container /= Void
			parent_not_void: a_middle_container.parent /= Void
		local
			l_widget: detachable EV_WIDGET
			l_left_all_invisible, l_right_all_invisible: BOOLEAN
		do
			-- Update all middle container in first widget
			l_widget := a_middle_container.first
			if attached {SD_ZONE} l_widget as l_zone then
				if attached {EV_WIDGET} l_zone as lt_widget then
					l_left_all_invisible := not lt_widget.is_displayed
				end
			elseif attached {SD_MIDDLE_CONTAINER} l_widget as l_middle_container then
				l_left_all_invisible := update_visible_imp (l_middle_container)
			else
				check not_possible: False end
			end

			-- Update all middle container in second widget
			l_widget := a_middle_container.second

			if attached {SD_ZONE} l_widget as l_zone then
				if attached {EV_WIDGET} l_zone as lt_widget then
					l_right_all_invisible := not lt_widget.is_displayed
				end
			elseif attached {SD_MIDDLE_CONTAINER} l_widget as l_middle_container then
				l_right_all_invisible := update_visible_imp (l_middle_container)
			else
				check not_possible: False end
			end

			Result := l_left_all_invisible and l_right_all_invisible

			if Result then
				-- Current should be a invisible container
				a_middle_container.hide
			else
				-- Current should be a visible container
				a_middle_container.show
			end
		end

	update_middle_container_imp (a_middle_container: SD_MIDDLE_CONTAINER): BOOLEAN
			-- Postorder traversal.
			-- If all contained widgets are minimized container, then Result is True.
			-- Otherwise Result is False.
		require
			not_void: a_middle_container /= Void
			parent_not_void: a_middle_container.parent /= Void
		local
			l_widget: EV_WIDGET
			l_left_all_minimized, l_right_all_minimized: BOOLEAN
		do
				-- Update all middle container in first widget.
			l_widget := a_middle_container.first
			if
				attached {SD_MIDDLE_CONTAINER} l_widget as l_middle_container and
				not attached {SD_ZONE} l_widget
			then
				l_left_all_minimized := update_middle_container_imp (l_middle_container)
			else
				if attached {SD_UPPER_ZONE} l_widget as l_upper_zone_left and then l_upper_zone_left.is_displayed then
					l_left_all_minimized := l_upper_zone_left.is_minimized
				else
					if l_widget /= Void then
						l_left_all_minimized := not l_widget.is_displayed
					else
						check not_possible: False end
					end
				end
			end

			-- Update all middle container in second widget
			l_widget := a_middle_container.second
			if l_widget = Void then
				check has_second: False end
			else
				if
					attached {SD_MIDDLE_CONTAINER} l_widget as l_middle_container and then
					not attached {SD_ZONE} l_widget
				then
					l_right_all_minimized := update_middle_container_imp (l_middle_container)
				else
					if attached {SD_UPPER_ZONE} l_widget as l_upper_zone_right then
						if l_widget.is_displayed then
							l_right_all_minimized := l_upper_zone_right.is_minimized
						end
					else
						l_right_all_minimized := not l_widget.is_displayed
					end
				end

				Result := l_left_all_minimized and l_right_all_minimized

				if attached a_middle_container as l_parent then
					if l_left_all_minimized or l_right_all_minimized then
						-- Current should be a minimized container
						if attached l_parent.first as l_first and attached l_parent.second as l_second then
							if not l_parent.is_minimized then
								-- If one child is hidden, then the splitter bar is hidden by EV_VERTICAL_SPLIT_AREA/EV_HORIZONTAL_SPLIT_AREA automatically, we don't need to change it.	
								if l_first.is_displayed and l_second.is_displayed then
									disable_item_expand (change_parent_to_minimized_container (l_parent), l_left_all_minimized, l_right_all_minimized)
								end
							else
								-- When `l_parent' is minimized container already and a child tool container just hidden, we should update splitter bar visible.
								if l_first.is_displayed and l_second.is_displayed then
									l_parent.set_splitter_visible (True)
								else
									l_parent.set_splitter_visible (False)
								end
							end
						else
							check False end -- Implied by `l_parent.first = a_middle_container' and docking widgets are full-two-fork-tree structure
						end
					else
						-- Current should be a normal spliter area
						if l_parent.is_minimized and not l_left_all_minimized and not l_right_all_minimized then
							change_parent_to_normal_container (l_parent).do_nothing
						end
					end
				end

				if attached {SD_MIDDLE_CONTAINER} l_widget.parent as l_parent then
					disable_item_expand (l_parent, l_left_all_minimized, l_right_all_minimized)
				end
			end
		end

	disable_item_expand (a_middle_container: SD_MIDDLE_CONTAINER; a_disable_first, a_disable_second: BOOLEAN)
			-- Disable item expand.
		require
			not_void: a_middle_container /= Void
			full: a_middle_container.count = 2
		local
			l_first,l_second: detachable EV_WIDGET
		do
			l_first := a_middle_container.first
			l_second := a_middle_container.second
			if attached {SD_HORIZONTAL_BOX} a_middle_container as l_h_box then
				if l_first /= Void then
					if a_disable_first then
						l_h_box.disable_item_expand (l_first)
					else
						l_h_box.enable_item_expand (l_first)
					end
				end
				if l_second /= Void then
					if a_disable_second then
						l_h_box.disable_item_expand (l_second)
					else
						l_h_box.enable_item_expand (l_second)
					end
				end
			elseif attached {SD_VERTICAL_BOX} a_middle_container as l_v_box then
				if l_first /= Void then
					if a_disable_first then
						l_v_box.disable_item_expand (l_first)
					else
						l_v_box.enable_item_expand (l_first)
					end
				end
				if l_second /= Void then
					if a_disable_second then
						l_v_box.disable_item_expand (l_second)
					else
						l_v_box.enable_item_expand (l_second)
					end
				end
			end
		end

	change_parent_to_normal_container (a_middle_container: SD_MIDDLE_CONTAINER): SD_MIDDLE_CONTAINER
			-- Change `a_middle_container' to normal container.
		require
			not_void: a_middle_container /= Void
			minimized: a_middle_container.is_minimized
		local
			l_parent: detachable EV_CONTAINER
			l_first, l_second: detachable EV_WIDGET
			l_parent_middle_container: detachable SD_MIDDLE_CONTAINER

			l_parent_split_position: INTEGER
			l_split_position: INTEGER
		do
			l_parent := a_middle_container.parent
			if attached {SD_MIDDLE_CONTAINER} l_parent as p then
				l_parent_middle_container := p
				l_parent_split_position := l_parent_middle_container.split_position
			end
			l_first := a_middle_container.first
			l_second := a_middle_container.second

			save_spliter_position (a_middle_container, generating_type.name_32 + {STRING_32} ".change_parent_to_normal_container")

			if attached {SD_VERTICAL_BOX} a_middle_container then
				create {SD_VERTICAL_SPLIT_AREA} Result
			else
				check is_horizontal_box: attached {SD_HORIZONTAL_BOX} a_middle_container end
				create {SD_HORIZONTAL_SPLIT_AREA} Result
			end

			l_split_position := a_middle_container.split_position
			if attached l_parent then
				l_parent.prune (a_middle_container)
			end
			a_middle_container.wipe_out
			if attached l_parent then
				l_parent.extend (Result)
			end
			if attached l_first then
				Result.extend (l_first)
			end
			if attached l_second then
				Result.extend (l_second)
			end

			if l_parent_middle_container /= Void then
				l_parent_middle_container.set_split_position (l_parent_split_position)
			end

			restore_spliter_position (Result, generating_type.name_32 + {STRING_32} ".change_parent_to_normal_container")

			if l_split_position >= Result.minimum_split_position and l_split_position <= Result.maximum_split_position then
				Result.set_split_position (l_split_position)
			end
		ensure
			not_void: Result /= Void
			not_minimized: not Result.is_minimized
		end

	change_parent_to_minimized_container (a_middle_container: SD_MIDDLE_CONTAINER): SD_MIDDLE_CONTAINER
			-- Change `a_middle_container' to minimized container
		require
			not_void: a_middle_container /= Void
			not_minimized: not a_middle_container.is_minimized
		local
			l_parent: detachable EV_CONTAINER
			l_first, l_second: detachable EV_WIDGET
			l_parent_middle_container: detachable SD_MIDDLE_CONTAINER

			l_parent_split_position: INTEGER
			l_split_position: INTEGER
		do
			l_parent := a_middle_container.parent
			if attached {SD_MIDDLE_CONTAINER} l_parent as p then
				l_parent_middle_container := p
				l_parent_split_position := p.split_position
			end
			l_first := a_middle_container.first
			l_second := a_middle_container.second

			save_spliter_position (a_middle_container, generating_type.name_32 + {STRING_32} ".change_parent_to_minimized_container")

			if attached {EV_VERTICAL_SPLIT_AREA} a_middle_container then
				create {SD_VERTICAL_BOX} Result.make
			else
				check is_horizontal_box: attached {EV_HORIZONTAL_SPLIT_AREA} a_middle_container end
				create {SD_HORIZONTAL_BOX} Result.make
			end
			l_split_position := a_middle_container.split_position
			if l_parent /= Void then
				-- Implied by current is displaying in main window
				l_parent.prune (a_middle_container)
				a_middle_container.wipe_out
				l_parent.extend (Result)
			end
			if
				l_first /= Void and	-- Implied by current is displaying in main window
				l_second /= Void -- Implied by current is displaying in main window
			then
				Result.extend (l_first)
				Result.extend (l_second)
			end

			if l_parent_middle_container /= Void then
				l_parent_middle_container.set_split_position (l_parent_split_position)
			end

			restore_spliter_position (Result, generating_type.name_32 + {STRING_32} ".change_parent_to_minimized_container")

			Result.set_split_position (l_split_position)

		ensure
			not_void: Result /= Void
			minimized: Result.is_minimized
		end

	remove_empty_split_area_imp (a_split_area: SD_MIDDLE_CONTAINER)
			-- Remove all empty split area in `inner_container' recursively, postorder traversal.
			-- The structure is a two-fork tree.
			-- Stop at SD_ZONE level.
		require
			a_split_area_not_void: a_split_area /= Void
			a_split_area_parent_not_void: a_split_area.parent /= Void
		local
			l_widget: detachable EV_WIDGET
		do
			-- Remove all empty area in first widget
			l_widget := a_split_area.first

			if
				attached {SD_MIDDLE_CONTAINER} l_widget as l_split and then
				not attached {SD_ZONE} l_widget
			then
				-- If is a split area
				remove_empty_split_area_imp (l_split)
			end

			-- Remove all empty area in second widget
			l_widget := a_split_area.second
			if
				attached {SD_MIDDLE_CONTAINER} l_widget as l_split and then
				not attached {SD_ZONE} l_widget
			then
				-- If is a split area
				remove_empty_split_area_imp (l_split)
			end

			if a_split_area.is_empty then
				if attached a_split_area.parent as l_parent then
					-- Implied by `a_split_area' is displayed in main window
					l_parent.prune (a_split_area)
				else
					check split_area_parent_attached: False end
				end
			elseif a_split_area.second = Void then
				up_spliter_level (a_split_area, True)
			elseif a_split_area.first = Void then
				up_spliter_level (a_split_area, False)
			end
		end

	up_spliter_level (a_split_area: SD_MIDDLE_CONTAINER; a_first: BOOLEAN)
			-- If SD_MIDDLE_CONTAINER not full, then prune it from its parent, insert only one child widget to parent.
		require
			a_split_area_not_void: a_split_area /= Void
		local
			l_widget: detachable EV_WIDGET
			l_widget_split: detachable SD_MIDDLE_CONTAINER
			l_parent: detachable EV_CONTAINER
			l_temp_spliter: detachable SD_MIDDLE_CONTAINER
			l_spliter_position: INTEGER
		do
			if a_first then
				l_widget := a_split_area.first
			else
				l_widget := a_split_area.second
			end
			l_parent := a_split_area.parent

			if
				l_widget /= Void and  -- Implied by dockng widget structure is full-two-fork-tree
				l_parent /= Void      -- Implied by `a_split_area' is displaying in main window
			then
				if attached {SD_MIDDLE_CONTAINER} l_parent as s then
					l_temp_spliter := s
					l_spliter_position := l_temp_spliter.split_position
					debug ("docking")
						io.put_string ("%N SD_MULTI_DOCK_AREA l_spliter_position" + l_spliter_position.out)
					end
				end

				if attached {SD_MIDDLE_CONTAINER} l_widget as w then
					l_widget_split := w
					save_spliter_position (l_widget_split, generating_type.name_32 + {STRING_32} ".up_spliter_level")
				end

				l_parent.prune (a_split_area)
				a_split_area.prune (l_widget)
				l_parent.extend (l_widget)

				if l_temp_spliter /= Void and then l_temp_spliter.full then
					-- There should by only one, because Postorder, so NO recursive needed
					-- The split area must full, because Postorder recursive

					-- FIXIT: following if clause is used for GTK, on MsWin it's not needed
					if l_spliter_position < l_temp_spliter.minimum_split_position then
						l_spliter_position := l_temp_spliter.minimum_split_position
					end
					if l_spliter_position > l_temp_spliter.maximum_split_position then
						l_spliter_position := l_temp_spliter.maximum_split_position
					end
					l_temp_spliter.set_split_position (l_spliter_position)
				end

				if l_widget_split /= Void then
					restore_spliter_position (l_widget_split, generating_type.name_32 + {STRING_32} ".up_spliter_level")
				end
			end
		ensure
			a_split_area_child_pruned: a_split_area.count = 0
			spliter_level_up_done:
		end

	save_spliter_position_imp (a_spliter: SD_MIDDLE_CONTAINER; a_data: like spliters_data)
			-- Save spliter position before prune it.
			-- Post order.
		require
			a_spliter_not_void: a_spliter /= Void
			not_void: a_data /= Void
		do
			if a_spliter.full then
				a_data.extend (a_spliter.split_position)
				debug ("docking")
					io.put_string ("%N SD_MULIT_DOCK_AREA spliter position: save " + a_spliter.split_position.out)
				end
			end

			if (attached {SD_MIDDLE_CONTAINER} a_spliter.first as l_left) and then (not attached {SD_ZONE} l_left) then
				save_spliter_position_imp (l_left, a_data)
			end

			if (attached {SD_MIDDLE_CONTAINER} a_spliter.second as l_right) and then (not attached {SD_ZONE} l_right) then
				save_spliter_position_imp (l_right, a_data)
			end
		end

	restore_spliter_position_imp (a_spliter: SD_MIDDLE_CONTAINER; a_data: like spliters_data)
			-- Restore spliter position, pre order.
		require
			a_spliter_not_void: a_spliter /= Void
			not_void: a_data /= Void
		local
			l_spliter_position: INTEGER
		do
			if a_spliter.full then
				l_spliter_position := a_data.item
				debug ("docking")
					io.put_string ("%N SD_MULIT_DOCK_AREA spliter position: open " + l_spliter_position.out)
				end

				check a_spliter.full end

				debug ("docking")
					io.put_string ("%N SD_MULIT_DOCK_AREA spliter position: max " + a_spliter.maximum_split_position.out + " min " + a_spliter.minimum_split_position.out)
				end
				if l_spliter_position >= a_spliter.minimum_split_position and l_spliter_position <= a_spliter.maximum_split_position then
					a_spliter.set_split_position (l_spliter_position)
				elseif l_spliter_position >= a_spliter.maximum_split_position then
					a_spliter.set_split_position (a_spliter.maximum_split_position)
				end -- No need to set min_split_position, because default is min_split_position

				a_data.forth
			end

			if
				attached {SD_MIDDLE_CONTAINER} a_spliter.first as l_left and then
				not attached {SD_ZONE} l_left
			then
				restore_spliter_position_imp (l_left, a_data)
			end

			if
				attached {SD_MIDDLE_CONTAINER} a_spliter.second as l_right and then
				not attached {SD_ZONE} l_right
			then
				restore_spliter_position_imp (l_right, a_data)
			end
		end

feature {NONE} -- Implementation attributes

	all_spliters_data: STRING_TABLE [ARRAYED_LIST [INTEGER]]
			-- All spliters data.
			-- First argument is real type.
			-- Second argument is data name which is used for finding data when `restore_spliter_data'.

	spliters_data: ARRAYED_LIST [INTEGER]
			-- Split bars' positions saved which used for save/restore spliter positions.
		require
			not_called: False
		do
			check
				from_precondition: False
			then
			end
		end

	internal_shared: SD_SHARED
			-- All singletons.

;note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
