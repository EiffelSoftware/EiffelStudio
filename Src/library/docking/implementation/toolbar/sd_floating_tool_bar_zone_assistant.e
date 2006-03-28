indexing
	description: "Assistants that manage a SD_FLOATING_TOOL_BAR_ZONE position item issues."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_FLOATING_TOOL_BAR_ZONE_ASSISTANT

create
	make

feature {NONE}  -- Initlization

	make (a_floating_zone: SD_FLOATING_TOOL_BAR_ZONE) is
			-- Creation method
		require
			not_void: a_floating_zone /= Void
		do
			zone := a_floating_zone
		ensure
			set: zone = a_floating_zone
		end

feature -- Commands

	position_groups (a_groups_info: SD_TOOL_BAR_GROUP_INFO) is
			-- Position tool_bar items by a_group_info.
		require
			not_void: a_groups_info /= Void
		local
--			l_prof_setting: PROFILING_SETTING
		do
--			create l_prof_setting.make
--			l_prof_setting.start_profiling
			debug ("docking")
				print ("%N=================== SD_FLOATING_TOOL_BAR_ZONE_ASSISTANT position_groups ================")
			end
			position_groups_imp (a_groups_info)
			zone.zone.assistant.last_state.set_floating_group_info (a_groups_info)
--			l_prof_setting.stop_profiling
		end

	to_minmum_size is
			-- To minmum size.
		do
			zone.set_size (zone.minimum_width, zone.minimum_height)
		end

feature {NONE} -- Implementation functions

	position_groups_imp (a_groups_info: SD_TOOL_BAR_GROUP_INFO) is
			-- Position tool_bar items by a_group_info.
		require
			not_void: a_groups_info /= Void
		local
		do
			debug ("docking")
				print ("%N SD_FLOATING_TOOL_BAR_ZONE_ASSISTANT position_groups_imp")
			end
			reset_all_items_wrap
			from
				a_groups_info.start
			until
				a_groups_info.after
			loop
				debug ("docking")
					print ("%N SD_FLOATING_TOOL_BAR_ZONE_ASSISTANT position_groups_imp 2")
				end
				if not a_groups_info.has_sub_info then
					position_top_level_items (a_groups_info.item)
				else
					position_sub_level_items (a_groups_info.sub_grouping.item (a_groups_info.index), a_groups_info.index)
				end
				a_groups_info.forth
			end
			zone.tool_bar.compute_minmum_size
			to_minmum_size
		end

	position_top_level_items (a_group_indexs: ARRAYED_LIST [INTEGER]) is
			-- Position tool bar items' groups.
		require
			not_void: a_group_indexs /= Void
		local
			l_group: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			l_last_item: SD_TOOL_BAR_ITEM
			l_separator: SD_TOOL_BAR_SEPARATOR
		do
			from
				a_group_indexs.start
			until
				a_group_indexs.after
			loop
				l_group := zone.content.group (a_group_indexs.item)
				l_last_item := l_group.last
				a_group_indexs.forth
			end
			if l_last_item /= Void then
				l_separator := Void
				-- There should be a separator behind, otherwise this is the last tool bar item.
				l_separator := zone.content.seperator_after_item (l_last_item)
				if l_separator /= Void then
					l_separator.set_wrap (True)
				else
				end
			end
		end

	position_sub_level_items (a_sub_info: SD_TOOL_BAR_GROUP_INFO; a_group_index: INTEGER) is
			-- Position group items.
		require
			not_void: a_sub_info /= Void
		local
			l_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			l_last_item: SD_TOOL_BAR_ITEM
			l_separator: SD_TOOL_BAR_SEPARATOR
		do
			l_items := zone.content.group (a_group_index)
			from
				a_sub_info.start
			until
				a_sub_info.after
			loop
				l_last_item := l_items.i_th (a_sub_info.item.last)

				l_separator := Void
				l_separator := zone.content.seperator_after_item (l_last_item)
				if l_separator = Void then
					l_last_item.set_wrap (True)
				else
					l_separator.set_wrap (True)
				end
				a_sub_info.forth
			end

		end

	reset_all_items_wrap is
			-- Reset items to wrap state.
		local
			l_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
		do
			l_items := zone.content.items
			from
				l_items.start
			until
				l_items.after
			loop
				l_items.item.set_wrap (False)
				l_items.forth
			end
		end

feature {NONE} -- Implementation attributes

	last_resize: PROCEDURE [SD_FLOATING_TOOL_BAR_ZONE_ASSISTANT, TUPLE]
			-- Last resize idle action.

	zone: SD_FLOATING_TOOL_BAR_ZONE
			-- Floating zone which items positioned by Current.

invariant
	not_void: zone /= Void

end
