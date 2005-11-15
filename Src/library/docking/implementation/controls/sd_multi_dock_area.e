indexing
	description: "Objects that is the center mulit docking area."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_MULTI_DOCK_AREA

inherit
	EV_CELL

create
	make

feature {NONE} -- Initlization
	make is
			--
		do
			default_create
		end

feature -- Command

	update_title_bar is
			-- If `Current' parent is a SD_FLOATING_ZONE, update title bar.
		do
			if internal_parent_floating_zone /= Void then
				internal_parent_floating_zone.update_title_bar
			else
				set_all_title_bar (item)
			end
		end

	set_parent_floating_zone (a_floating_zone: SD_FLOATING_ZONE) is
			--
		require
			a_floating_zone_not_void: a_floating_zone /= Void
		do
			internal_parent_floating_zone := a_floating_zone
		ensure
			set: internal_parent_floating_zone = a_floating_zone
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
		end

	save_spliter_position (a_spliter: EV_SPLIT_AREA) is
			--
		require
			a_spliter_not_void: a_spliter /= Void
		do
			create spliters.make (1)
			save_spliter_position_imp (a_spliter)
		end

	restore_spliter_position (a_spliter: EV_SPLIT_AREA) is
			--
		require
			a_spliter_not_void: a_spliter /= Void
		do
			spliters.start
			restore_spliter_position_imp (a_spliter)
		end

	has_zone (a_zone: SD_ZONE): BOOLEAN is
			--
		require
			a_zone_not_void: a_zone /= Void
		local
--			l_zone: SD_ZONE
--			l_split_area: EV_SPLIT_AREA
			l_widget: EV_WIDGET
		do
--			if readable then
--				l_zone ?= item
--				if l_zone /= Void then
--					if l_zone = a_zone then
--						Result := True
--					end
--				else
--					l_split_area ?= item
--					check l_split_area /= Void end
--					Result := has_zone_internal (a_zone, l_split_area)
--				end
--			end
			l_widget ?= a_zone
			check l_widget /= Void end
			Result := has_recursive (l_widget)
		end

feature {NONE} -- Implementation

	 set_all_title_bar (a_widget: EV_WIDGET) is
	 		--
	 	local
	 		l_zone: SD_TITLE_BAR_REMOVEABLE
	 		l_split_area: EV_SPLIT_AREA
	 	do
			l_split_area ?= a_widget
			if l_split_area /= Void then
				set_all_title_bar (l_split_area.first)
				set_all_title_bar (l_split_area.second)
			end
			l_zone ?= a_widget
			if l_zone /= Void then
				l_zone.set_title_bar (True)
			end
	 	end

--	has_zone_internal (a_zone: SD_ZONE; a_split_area: EV_SPLIT_AREA): BOOLEAN is
--			--
--		require
--			a_zone_not_void: a_zone /= Void
--			a_split_area_not_void: a_split_area /= Void
--		local
--			l_zone: SD_ZONE
--			l_split_area: EV_SPLIT_AREA
--		do
--			l_zone ?= a_split_area.first
--			if l_zone /= Void then
--				Result := l_zone = a_zone
--			else
--				l_split_area ?= a_split_area.first
--				if l_split_area /= Void then
--					Result := has_zone_internal (a_zone, l_split_area)
--				end
--			end
--
--			if not Result then
--				l_zone := Void
--				l_zone ?= a_split_area.second
--				if l_zone /= Void then
--					Result := l_zone = a_zone
--				else
--					l_split_area := Void
--					l_split_area ?= a_split_area.second
--					if l_split_area /= Void then
--						Result := has_zone_internal (a_zone, l_split_area)
--					end
--				end
--			end
--
--		end

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
			-- If EV_SPLIT_AREA not full, then prune it from its parent, insert only one item to parent.
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
				debug ("larry")
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
--				-- There should by only one, because Postorder, so NO recursive needed.
--				-- The split area must full, because Postorder recursive.
					l_temp_spliter.set_split_position (l_spliter_position)
			end

			if l_widget_split /= Void then
				restore_spliter_position (l_widget_split)
			end


		end

	save_spliter_position_imp (a_spliter: EV_SPLIT_AREA) is
			-- Save spliter position before prune it.
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
				debug ("larry")
					io.put_string ("%N SD_MULIT_DOCK_AREA spliter position: save " + a_spliter.split_position.out)
				end
			end

		end

	restore_spliter_position_imp (a_spliter: EV_SPLIT_AREA) is
			-- Restore spliter position.
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
				debug ("larry")
					io.put_string ("%N SD_MULIT_DOCK_AREA spliter position: open " + l_spliter_position.out)
				end
				-- Check
				l_old_spliter ?= spliters.item [1]
				check l_old_spliter /= Void and then l_old_spliter = a_spliter end

--				if l_spliter_position < a_spliter.minimum_split_position then
--					l_spliter_position := a_spliter.minimum_split_position
--				end
--				if l_spliter_position > a_spliter.maximum_split_position then
--					l_spliter_position := a_spliter.maximum_split_position
--				end
				check a_spliter.full end

				debug ("larry")
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

	spliters: ARRAYED_LIST [TUPLE [EV_SPLIT_AREA, INTEGER]]
			-- Split areas used for save/restore spliter positions.

	internal_parent_floating_zone: SD_FLOATING_ZONE
			-- If `Current' is in a SD_FLOATING_ZONE, this is parent. Otherwise it should be Void.
end
