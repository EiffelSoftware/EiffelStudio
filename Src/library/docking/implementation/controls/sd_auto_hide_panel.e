note
	description: "[
			Panels that are hold SD_ZONE which are hidden at four 
			side of main window area.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_AUTO_HIDE_PANEL

inherit
	SD_HOR_VER_BOX
		export
			{ANY} object_id
		redefine
			has,
			set_background_color,
			destroy
		end

	SD_WIDGETS_LISTS
		undefine
			default_create,
			is_equal,
			copy
		end

	SD_ACCESS
		undefine
			default_create,
			is_equal,
			copy
		end

create {SD_DOCKING_MANAGER}
	make

feature {NONE} -- Initlization

	make (a_direction: INTEGER)
			-- Creation method. If not vertical style, it'll be horizontal style
		require
			a_direction_valid: a_direction = {SD_ENUMERATION}.top or a_direction = {SD_ENUMERATION}.bottom
				or a_direction = {SD_ENUMERATION}.left or a_direction = {SD_ENUMERATION}.right
		do
			create internal_shared
			create internal_tab_stubs
			internal_tab_stubs.compare_objects
			create tab_groups
			create tab_groups_max_size.make (8)
			if a_direction = {SD_ENUMERATION}.left or a_direction = {SD_ENUMERATION}.right then
				init (True)
			else
				init (False)
			end
			internal_direction := a_direction
			set_minimum_size (0, 0)
			internal_tab_stubs.add_actions.extend (agent on_add_tab_stub)
			internal_tab_stubs.remove_actions.extend (agent on_pruned_tab_stub)

			set_background_color (internal_shared.non_focused_color_lightness)

			add_auto_hide_panel (Current)
		ensure
			set: internal_direction = a_direction
		end

feature -- Query

	tab_stubs: like internal_tab_stubs
			-- Tab stubs current holded
		do
			Result := internal_tab_stubs
		end

	tab_groups: ACTIVE_LIST [like internal_tab_group]
			-- All tab groups

	has (a_tab: SD_TAB_STUB): BOOLEAN
			-- If `Current' has a_tab?
		do
			start
			Result := Precursor {SD_HOR_VER_BOX} (a_tab)
		end

	has_tab (a_content: SD_CONTENT): BOOLEAN
			-- If `Current' has `a_content'?
		require
			a_content_not_void: a_content /= Void
		local
			l_tab_stubs: like tab_stubs
		do
			from
				l_tab_stubs := tab_stubs
				l_tab_stubs.start
			until
				l_tab_stubs.after or Result
			loop
				Result := l_tab_stubs.item.content = a_content
				l_tab_stubs.forth
			end
		end

	is_content_in_group (a_content: SD_CONTENT): BOOLEAN
			-- If `a_content' in a tab group?
		require
			a_content_not_void: a_content /= Void
		local
			l_group: like internal_tab_group
			l_tab_groups: like tab_groups
		do
			from
				l_tab_groups := tab_groups
				l_tab_groups.start
			until
				l_tab_groups.after or Result
			loop
				l_group := l_tab_groups.item
				from
					l_group.start
				until
					l_group.after or Result
				loop
					Result := l_group.item.content = a_content
					l_group.forth
				end
				l_tab_groups.forth
			end
		end

	tab_by_content (a_content: SD_CONTENT): detachable SD_TAB_STUB
			-- SD_TAB_STUB which represent `a_content'
		require
			a_content_not_void: a_content /= Void
			has_tab: has_tab (a_content)
		do
			across
				internal_tab_stubs as c
			until
				attached Result
			loop
				if c.content = a_content then
					Result := c
				end
			end
		ensure
			not_void: Result /= Void
		end

	content_by_tab (a_tab: SD_TAB_STUB): detachable SD_CONTENT
			-- SD_CONTENT which represent by `a_tab'.
		require
			a_tab_not_void: a_tab /= Void
--TODO			has: has (a_tab)
		do
			if attached docking_manager as m then
				across
					m.contents as c
				until
					attached Result
				loop
					if c = a_tab.content then
						Result := c
					end
				end
			end
		end

feature -- Command

	set_tab_group (a_contents: LIST [SD_CONTENT])
			-- Set `a_contents' to a `tab_groups'
		require
			a_contents_not_void: a_contents /= Void
			a_contents_more_than_one: a_contents.count > 1
		local
			l_tab_group: detachable ARRAYED_LIST [SD_TAB_STUB]
			l_tab_groups: like tab_groups
		do
			from
				a_contents.start
				l_tab_groups := tab_groups
			until
				a_contents.after
			loop
				if
					attached tab_by_content (a_contents.item) as l_tab and then
					attached tab_group_internal (l_tab) as g
				then
					if l_tab_group = Void then
						l_tab_group := g
					else
						l_tab_groups.start
						l_tab_groups.prune (g)
						l_tab_group.extend (l_tab)
					end
				end
				a_contents.forth
			end
			update_tab_group
		ensure
			set: contents_tab_group_set (a_contents)
		end

	select_tab_by_content (a_content: SD_CONTENT)
			-- `select_tab' by `a_content'
		require
			a_content_not_void: a_content /= Void
			has: has_tab (a_content)
		do
			if attached tab_by_content (a_content) as t then
				select_tab (t)
			else
				check from_precondition_has: False end
			end
		end

	select_tab (a_tab: SD_TAB_STUB)
			-- Show tab text with `a_content'
		require
			a_tab_not_void: a_tab /= Void
			has: has (a_tab)
		do
			if attached tab_group_internal (a_tab) as l_tab_group then
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
			else
				check from_precondition_has: False end
			end
		end

	tab_group (a_tab: SD_TAB_STUB): detachable like internal_tab_group
			-- Get the group contain `a_tab'.
		require
			a_tab_not_void: a_tab /= Void
			has: has (a_tab)
		do
			across
				tab_groups as c
			until
				attached Result
			loop
				if c.has (a_tab) then
					Result := c.twin
				end
			end
		ensure
			not_void: Result /= Void
		end

	set_tab_with_friend (a_tab: SD_TAB_STUB; a_friend: SD_CONTENT)
			-- Set tab with friend, so they show in a group.
		require
			a_tab_not_void: a_tab /= Void and a_friend /= Void
			has: has (a_tab) and has_tab (a_friend)
		do
			if
				attached tab_by_content (a_friend) as l_friend and then
				attached tab_group_internal (l_friend) as l_tab_group and then
				not l_tab_group.has (a_tab)
			then
				tab_stubs.start
				tab_stubs.prune (a_tab)

				start
				search (l_friend)
				put_right (a_tab)
				disable_item_expand (a_tab)

					-- Tab stubs' order in the EV_BOX must same as the tab stubs' order in `l_tab_group'.
					-- Otherwise, it will cause bug#13240.
				l_tab_group.start
				l_tab_group.search (l_friend)
				l_tab_group.put_right (a_tab)

				select_tab (a_tab)
				update_tab_group

				internal_ignore_added_action := True
				tab_stubs.extend (a_tab)
				internal_ignore_added_action := False
			end
		end

	update_tab_group
			-- Update tab stubs layout by tab group
		local
			l_tab_groups: like tab_groups
			l_tab_groups_max_size: like tab_groups_max_size
		do
			from
				l_tab_groups := tab_groups
				l_tab_groups_max_size := tab_groups_max_size
				l_tab_groups_max_size.wipe_out
				l_tab_groups.start
			until
				l_tab_groups.after
			loop
					-- Remove stub separator by group
				update_one_tab_group (l_tab_groups.item)
				l_tab_groups_max_size.extend (tab_group_max_size (l_tab_groups.item))
				l_tab_groups.forth
			end
			update_tab_group_max_size
		end

	set_background_color (a_color: EV_COLOR)
			-- <Precursor>
		do
			from
				start
			until
				after
			loop
				if attached {SD_AUTO_HIDE_SEPARATOR} item as l_spacer then
					l_spacer.set_background_color (a_color)
				end
				forth
			end
			Precursor {SD_HOR_VER_BOX} (a_color)
		end

	update_size
			-- Update sizes based on font size.
		do
			if attached docking_manager as m then
				if count = 0 then
					if internal_vertical_style then
						set_minimum_width (0)
					else
						set_minimum_height (0)
					end
					m.main_container.set_gap (internal_direction, False)
				else
					if internal_vertical_style then
						set_minimum_width (internal_shared.auto_hide_panel_size)
					else
						set_minimum_height (internal_shared.auto_hide_panel_size)
					end
					m.main_container.set_gap (internal_direction, True)
				end
				m.command.resize (True)
			end
		end

	destroy
			-- <Precursor>
		do
			docking_manager := Void
			prune_auto_hide_panel (Current)
			Precursor {SD_HOR_VER_BOX}
		end

feature {SD_DOCKING_MANAGER} -- Modification

	set_docking_manager (m: SD_DOCKING_MANAGER)
			-- Set `docking_manager' to `m'.
		do
			docking_manager := m
		ensure
			docking_manager_set: docking_manager = m
		end

feature -- States report

	contents_tab_group_set (a_contents: LIST [SD_CONTENT]): BOOLEAN
			-- If `a_contents' tab group set?
		require
			a_contents_not_void: a_contents /= Void
		do
			if
				not a_contents.is_empty and then
				attached tab_by_content (a_contents.first) as l_tab
			then
				Result := attached tab_group (l_tab) as g and then g.count = a_contents.count
			end
		end

feature {NONE} -- Implementation functions

	tab_group_max_size (a_tab_group: ARRAYED_LIST [SD_TAB_STUB]): INTEGER
			-- Tab group max size
		require
			a_tab_group_not_void: a_tab_group /= Void
			has: tab_groups.has (a_tab_group)
		local
			w: INTEGER
		do
			from
				a_tab_group.start
			until
				a_tab_group.after
			loop
				w := a_tab_group.item.text_width
				if Result <= w then
					Result := w
				end
				a_tab_group.forth
			end
		end

	update_one_tab_group (a_tab_group: ARRAYED_LIST [SD_TAB_STUB])
			-- Only leave one text show in a group
		require
			a_tab_group_not_void: a_tab_group /= Void
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
						-- Remove separator
					forth
					if attached {SD_AUTO_HIDE_SEPARATOR} item as l_separator then
						prune_all (l_separator)
					end
				end
				a_tab_group.forth
			end
		ensure
			only_one_tab_have_text:
		end

	update_tab_group_max_size
			-- Update tab group max size
		local
			l_tab_group: LIST [SD_TAB_STUB]
			l_tab_groups: like tab_groups
			l_tab_groups_max_size: like tab_groups_max_size
		do
			from
				l_tab_groups := tab_groups
				l_tab_groups.start
				l_tab_groups_max_size := tab_groups_max_size
				l_tab_groups_max_size.start
			until
				l_tab_groups.after
			loop
				l_tab_group := l_tab_groups.item
				from
					l_tab_group.start
				until
					l_tab_group.after
				loop
					if not internal_shared.show_all_tab_stub_text then
						l_tab_group.item.set_text_size (l_tab_groups_max_size.item)
					end
					update_separators (l_tab_group.index = 1, l_tab_group.index = l_tab_group.count, l_tab_group.item)
					l_tab_group.forth
				end

				l_tab_groups.forth
				if not l_tab_groups_max_size.after then
					l_tab_groups_max_size.forth
				end
			end
		end

	update_separators (a_first, a_last: BOOLEAN; a_tab: SD_TAB_STUB)
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
			when {SD_ENUMERATION}.top then
				a_tab.set_draw_separator_right (False)
			when {SD_ENUMERATION}.bottom then
				a_tab.set_draw_separator_right (False)
			when {SD_ENUMERATION}.left then
				a_tab.set_draw_separator_bottom (False)
			when {SD_ENUMERATION}.right then
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

	on_add_tab_stub (a_stub: SD_TAB_STUB)
			-- Handle insert a tab stub event
		require
			a_stub_not_void: a_stub /= Void
		local
			l_spacer: SD_AUTO_HIDE_SEPARATOR
			l_tab_group: ARRAYED_LIST [SD_TAB_STUB]
		do
			if not internal_ignore_added_action then
				a_stub.set_auto_hide_panel (Current)
				extend (a_stub)
				disable_item_expand (a_stub)
				create l_tab_group.make (1)
				l_tab_group.extend (a_stub)
				tab_groups.extend (l_tab_group)

					-- Add spacer
				create l_spacer
				l_spacer.set_minimum_size (spacer_size, spacer_size)
				l_spacer.set_background_color (background_color)
				extend (l_spacer)
				disable_item_expand (l_spacer)

				update_size
			end
		ensure
			added_stub_and_space: not internal_ignore_added_action implies old count = count - 2 and has (a_stub)
		end

	on_pruned_tab_stub (a_stub: SD_TAB_STUB)
			-- Handle prune a tab sutb event
		require
			a_stub_not_void: a_stub /= Void
			has: has (a_stub)
		do
				-- Update Tab group
			if attached tab_group_internal (a_stub) as l_tab_group then
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
					-- Remove spacer
				if not off then
					remove
				end
				if l_tab_group.count = 0 then
					check a_spacer_or_a_tab_behind: not after end
					if attached {SD_AUTO_HIDE_SEPARATOR} item as l_separator then
						remove
					end
				end

				update_tab_group_max_size
				update_size
			else
				check from_precondition_has: False end
			end
		ensure
			removed: not has (a_stub)
		end

	tab_group_internal (a_tab: SD_TAB_STUB): detachable like internal_tab_group
			-- Get the group with `a_tab' (if any).
		require
			a_tab_not_void: a_tab /= Void
			has_tab: has (a_tab)
		do
			across
				tab_groups as c
			until
				attached Result
			loop
				if c.has (a_tab) then
					Result := c
				end
			end
		ensure
			not_void: Result /= Void
		end

feature {NONE} -- Impelementation attributes

	docking_manager: detachable SD_DOCKING_MANAGER

	tab_groups_max_size: ARRAYED_LIST [INTEGER]
			-- Max size of correspond tab group

	internal_tab_stubs: ACTIVE_LIST [SD_TAB_STUB]
			-- All tab stubs

	spacer_size: INTEGER = 10
			-- Spacer size

	internal_shared: SD_SHARED
			-- All singletons

	internal_tab_group: ARRAYED_LIST [SD_TAB_STUB]
			-- Tab group which stay together without separator. This is used for type signature
		require
			False
		do
			check False end -- Anchor type only, never executed
			create Result.make (0)
		end

	internal_direction: INTEGER
			-- Direction

	internal_ignore_added_action: BOOLEAN
			-- Ignore add action?

invariant

	internal_shared_not_void: internal_shared /= Void
	internal_tab_stubs_not_void: internal_tab_stubs /= Void
	tab_groups_not_void: tab_groups /= Void

note
	library: "SmartDocking: Library of reusable components for Eiffel."
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
