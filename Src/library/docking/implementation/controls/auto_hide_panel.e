indexing
	description: "Panels that are hold SD_CONTENT's user widgets and be hided."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_AUTO_HIDE_PANEL

inherit
	SD_HOR_VER_BOX
		redefine
			has
		end

create
	make

feature {NONE} -- Initlization

	make (a_direction: INTEGER; a_docking_manager: SD_DOCKING_MANAGER) is
			-- Creation method. If not vertical style, it'll be horizontal style.
		require
			a_direction_valid: a_direction = {SD_DOCKING_MANAGER}.dock_top or a_direction = {SD_DOCKING_MANAGER}.dock_bottom
				or a_direction = {SD_DOCKING_MANAGER}.dock_left or a_direction = {SD_DOCKING_MANAGER}.dock_right
			a_docking_manager_not_void: a_docking_manager /= Void
		do
			create internal_shared
			internal_docking_manager := a_docking_manager
			if a_direction = {SD_DOCKING_MANAGER}.dock_left or a_direction = {SD_DOCKING_MANAGER}.dock_right then
				init (True)
			else
				init (False)
			end
			internal_direction := a_direction
			create internal_tab_stubs
			internal_tab_stubs.compare_objects
			set_minimum_size (0, 0)
			internal_tab_stubs.add_actions.extend (agent on_add_tab_stub)
			internal_tab_stubs.remove_actions.extend (agent on_pruned_tab_stub)
			create tab_groups

			set_background_color (internal_shared.non_focused_color_lightness)
		ensure
			set: internal_direction = a_direction
			set: internal_docking_manager = a_docking_manager
		end

feature -- Query

	tab_stubs: like internal_tab_stubs is
			-- Tab stubs current holded.
		do
			Result := internal_tab_stubs
		end

	tab_groups: ACTIVE_LIST [like internal_tab_group]
			-- All tab groups.

	has (a_tab: SD_TAB_STUB): BOOLEAN is
			-- If `Current' has a_tab ?
		do
			start
			Result := Precursor {SD_HOR_VER_BOX} (a_tab)
		end

	has_tab (a_content: SD_CONTENT): BOOLEAN is
			-- If `Current' has `a_content'?
		require
			a_content_not_void: a_content /= Void
		do
			from
				tab_stubs.start
			until
				tab_stubs.after or Result
			loop
				Result := tab_stubs.item.content = a_content
				tab_stubs.forth
			end
		end

	is_content_in_group (a_content: SD_CONTENT): BOOLEAN is
			-- If `a_content' in a tab group?
		require
			a_content_not_void: a_content /= Void
		local
			l_group: like internal_tab_group
		do
			from
				tab_groups.start
			until
				tab_groups.after or Result
			loop
				l_group := tab_groups.item
				from
					l_group.start
				until
					l_group.after or Result
				loop
					Result := l_group.item.content = a_content
					l_group.forth
				end
				tab_groups.forth
			end
		end

	tab_by_content (a_content: SD_CONTENT): SD_TAB_STUB is
			-- SD_TAB_STUB which represent `a_content'.
		require
			a_content_not_void: a_content /= Void
			has_tab: has_tab (a_content)
		do
			from
				internal_tab_stubs.start
			until
				internal_tab_stubs.after or Result /= Void
			loop
				if internal_tab_stubs.item.content = a_content then
					Result := internal_tab_stubs.item
				end
				internal_tab_stubs.forth
			end
		ensure
			not_void: Result /= Void
		end

	content_by_tab (a_tab: SD_TAB_STUB): SD_CONTENT is
			-- SD_CONTENT which represent by `a_tab'.
		require
			a_tab_not_void: a_tab /= Void
			has: has (a_tab)
		local
			l_contents: ARRAYED_LIST [SD_CONTENT]
		do
			l_contents := internal_docking_manager.contents
			from
				l_contents.start
			until
				l_contents.after or Result /= Void
			loop
				if l_contents.item = a_tab.content then
					Result := l_contents.item
				end
				l_contents.forth
			end
		end

feature -- Command

	set_tab_group (a_contents: ARRAYED_LIST [SD_CONTENT]) is
			-- Set `a_contents' to a `tab_groups'.
		require
			a_contents_not_void: a_contents /= Void
			a_contents_more_than_one: a_contents.count > 1
		local
			l_tab_group, l_tab_group_prune: ARRAYED_LIST [SD_TAB_STUB]
			l_tab: SD_TAB_STUB
		do
			from
				a_contents.start
			until
				a_contents.after
			loop
				l_tab := tab_by_content (a_contents.item)
				if l_tab_group = Void then
					l_tab_group := tab_group_internal (l_tab)
				else
					l_tab_group_prune := tab_group_internal (l_tab)
					tab_groups.start
					tab_groups.prune (l_tab_group_prune)
					l_tab_group.extend (l_tab)
				end
				a_contents.forth
			end
			update_tab_group
		ensure
			set: contents_tab_group_set (a_contents)
		end

	select_tab_by_content (a_content: SD_CONTENT) is
			-- `select_tab' by `a_content'.
		require
			a_content_not_void: a_content /= Void
			has: has_tab (a_content)
		do
			select_tab (tab_by_content (a_content))
		end

	select_tab (a_tab: SD_TAB_STUB) is
			-- Show tab text with `a_content'.
		require
			a_tab_not_void: a_tab /= Void
			has: has (a_tab)
		local
			l_tab_group: ARRAYED_LIST [SD_TAB_STUB]
		do
			l_tab_group := tab_group_internal (a_tab)
			from
				l_tab_group.start
			until
				l_tab_group.after
			loop
				if l_tab_group.item = a_tab then
					l_tab_group.item.set_show_text (True)
				else
					l_tab_group.item.set_show_text (False)
				end
				l_tab_group.forth
			end
		end

	tab_group (a_tab: SD_TAB_STUB):like internal_tab_group  is
			-- Get the group contain `a_tab'.
		require
			a_tab_not_void: a_tab /= Void
			has: has (a_tab)
		do
			from
				tab_groups.start
			until
				tab_groups.after or Result /= Void
			loop
				tab_groups.item.start
				if tab_groups.item.has (a_tab) then
					Result := tab_groups.item.twin
				end
				tab_groups.forth
			end
		ensure
			not_void: Result /= Void
		end

	set_tab_with_friend (a_tab: SD_TAB_STUB; a_friend: SD_CONTENT) is
			-- Set tab with friend, so they show in a group.
		require
			a_tab_not_void: a_tab /= Void and a_friend /= Void
			has: has (a_tab) and has_tab (a_friend)
		local
			l_tab_group: ARRAYED_LIST [SD_TAB_STUB]
			l_friend: SD_TAB_STUB
		do
			l_friend := tab_by_content (a_friend)
			l_tab_group := tab_group_internal (l_friend)
			if not l_tab_group.has (a_tab) then
				tab_stubs.start
				tab_stubs.prune (a_tab)

				start
				search (l_friend)
				put_right (a_tab)
				disable_item_expand (a_tab)
				l_tab_group.extend (a_tab)
				select_tab (a_tab)
				update_tab_group

				internal_ignore_added_action := True
--				tab_stubs.start
--				tab_stubs.search (l_friend)
--				tab_stubs.put_right (a_tab)
				tab_stubs.extend (a_tab)
				internal_ignore_added_action := False

			end
		end

feature -- States report

	contents_tab_group_set (a_contents: ARRAYED_LIST [SD_CONTENT]): BOOLEAN is
			-- If `a_contents' tab group set?
		require
			a_contents_not_void: a_contents /= Void
		local
			l_tab: SD_TAB_STUB
		do
			a_contents.start
			l_tab := tab_by_content (a_contents.item)
			Result := tab_group (l_tab).count = a_contents.count
		end

feature {NONE} -- Implementation functions.

	tab_group_max_size (a_tab_group: ARRAYED_LIST [SD_TAB_STUB]): INTEGER is
			-- Tab group max size.
		require
			a_tab_group_not_void: a_tab_group /= Void
			has: tab_groups.has (a_tab_group)
		do
			from
				a_tab_group.start
			until
				a_tab_group.after
			loop
				if Result <= a_tab_group.item.text_width then
					Result := a_tab_group.item.text_width
				end
				a_tab_group.forth
			end
		end

	update_tab_group is
			-- Update tab stubs layout by tab group.
		do
			from
				create tab_groups_max_size.make (1)
				tab_groups.start
			until
				tab_groups.after
			loop
				-- Remove stub seperator by group
				update_one_tab_group (tab_groups.item)
				tab_groups_max_size.extend (tab_group_max_size (tab_groups.item))
				tab_groups.forth
			end
			update_tab_group_max_size
		end

	update_one_tab_group (a_tab_group: ARRAYED_LIST [SD_TAB_STUB]) is
			-- Only leave one text show in a group.
		require
			a_tab_group_not_void: a_tab_group /= Void
		local
			l_seperator: SD_AUTO_HIDE_SEPERATOR
		do
			from
				a_tab_group.start
			until
				a_tab_group.after
			loop
				if a_tab_group.index /= a_tab_group.count then
					a_tab_group.item.set_show_text (False)
				end
				start
				search (a_tab_group.item)
				check found: not after end
				if a_tab_group.index /= a_tab_group.count then
					-- Remove seperator
					forth
					l_seperator ?= item
					if l_seperator /= Void then
						prune_all (l_seperator)
					end
				end
				a_tab_group.forth
			end
		ensure
			only_one_tab_have_text:
		end

	update_tab_group_max_size is
			-- Update tab group max size.
		local
			l_tab_group: ARRAYED_LIST [SD_TAB_STUB]
		do
			from
				tab_groups.start
				tab_groups_max_size.start
			until
				tab_groups.after
			loop
				l_tab_group := tab_groups.item
				from
					l_tab_group.start
				until
					l_tab_group.after
				loop
					l_tab_group.item.set_text_size (tab_groups_max_size.item)
					update_separators (l_tab_group.index = 1, l_tab_group.index = l_tab_group.count, l_tab_group.item)
					l_tab_group.forth
				end

				tab_groups.forth
				tab_groups_max_size.forth
			end
		end

	update_separators (a_first, a_last: BOOLEAN; a_tab: SD_TAB_STUB) is
			-- Update separetor
		do
			if a_first then
				if is_vertical then
					a_tab.set_draw_separator_top (True)
				else
					a_tab.set_draw_separator_left (True)
				end
			end
			inspect
				internal_direction
			when {SD_DOCKING_MANAGER}.dock_top then
				a_tab.set_draw_separator_right (False)
			when {SD_DOCKING_MANAGER}.dock_bottom then
				a_tab.set_draw_separator_right (False)
			when {SD_DOCKING_MANAGER}.dock_left then
				a_tab.set_draw_separator_bottom (False)
			when {SD_DOCKING_MANAGER}.dock_right then
				a_tab.set_draw_separator_bottom (False)
			end
			if a_last then
				if is_vertical then
					a_tab.set_draw_separator_bottom (True)
				else
					a_tab.set_draw_separator_right (True)
				end
			end
		end

	on_add_tab_stub (a_stub: SD_TAB_STUB) is
			-- Handle insert a tab stub event.
		require
			a_stub_not_void: a_stub /= Void
		local
			l_spacer: SD_AUTO_HIDE_SEPERATOR
			l_tab_group: ARRAYED_LIST [SD_TAB_STUB]
			l_helper: SD_COLOR_HELPER
		do
			if not internal_ignore_added_action then
				a_stub.set_auto_hide_panel (Current)
				extend (a_stub)
				disable_item_expand (a_stub)
				create l_tab_group.make (1)
				l_tab_group.extend (a_stub)
				tab_groups.extend (l_tab_group)

				-- Add spacer.
				create l_spacer
				l_spacer.set_minimum_size (spacer_size, spacer_size)
				create l_helper
				l_spacer.set_background_color (background_color)
				extend (l_spacer)
				disable_item_expand (l_spacer)

				if count /= 0 then
					if internal_vertical_style then
						set_minimum_width (internal_shared.auto_hide_panel_size)
					else
						set_minimum_height (internal_shared.auto_hide_panel_size)
					end
					internal_docking_manager.main_container.set_gap (internal_direction, True)
					internal_docking_manager.command.resize
				end
			end
		ensure
			added_stub_and_space: not internal_ignore_added_action implies old count = count - 2 and has (a_stub)
		end

	on_pruned_tab_stub (a_stub: SD_TAB_STUB) is
			-- Handle prune a tab sutb event.
		require
			a_stub_not_void: a_stub /= Void
			has: has (a_stub)
		local
			l_seperator: SD_AUTO_HIDE_SEPERATOR
			l_tab_group: ARRAYED_LIST [SD_TAB_STUB]
		do

			-- Update Tab group
			l_tab_group := tab_group_internal (a_stub)
			l_tab_group.start
			l_tab_group.prune (a_stub)
			if l_tab_group.count = 0 then
				tab_groups.start
				tab_groups.prune (l_tab_group)
			else
				if not l_tab_group.valid_index (l_tab_group.index) then
					l_tab_group.back
				end
				select_tab (l_tab_group.item)
			end

			start
			search (a_stub)
			check not off end
			-- Remove spacer.
			if not off then
				remove
			end
			if l_tab_group.count = 0 then
				check a_spacer_or_a_tab_behind: not after end
				l_seperator ?= item
				if l_seperator /= Void then
					remove
				end
			end

			if count = 0 then
				if internal_vertical_style then
					set_minimum_width (0)
				else
					set_minimum_height (0)
				end
				internal_docking_manager.main_container.set_gap (internal_direction, False)
				internal_docking_manager.command.resize
			end

		ensure
			removed: not has (a_stub)
		end

	tab_group_internal (a_tab: SD_TAB_STUB):like internal_tab_group  is
			-- Get the group contain `a_tab'.
		require
			a_tab_not_void: a_tab /= Void
			has_tab: has (a_tab)
		do
			from
				tab_groups.start
			until
				tab_groups.after or Result /= Void
			loop
				tab_groups.item.start
				if tab_groups.item.has (a_tab) then
					Result := tab_groups.item
				end
				tab_groups.forth
			end

		ensure
			not_void: Result /= Void
		end

feature {NONE} -- Impelementation attributes.

	tab_groups_max_size: ARRAYED_LIST [INTEGER]
			-- Max size of correspond tab group.

	internal_tab_stubs: ACTIVE_LIST [SD_TAB_STUB]
			-- All tab stubs.

	spacer_size: INTEGER is 10
			-- Spacer size.

	internal_shared: SD_SHARED
			-- All singletons

	internal_tab_group: ARRAYED_LIST [SD_TAB_STUB] is
			-- Tab group which stay together without seperator. This is used for type signature.
		require
			False
		do
		end

	internal_direction: INTEGER
			-- Direction.

	internal_ignore_added_action: BOOLEAN
			-- Ignore add action?

	internal_docking_manager: SD_DOCKING_MANAGER
			-- Docking manager manage Current.

invariant

	internal_shared_not_void: internal_shared /= Void
	internal_tab_stubs_not_void: internal_tab_stubs /= Void
	tab_groups_not_void: tab_groups /= Void

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
