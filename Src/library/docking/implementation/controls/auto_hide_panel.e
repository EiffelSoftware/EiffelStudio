indexing
	description: "Panels that are hold SD_CONTENT's user widgets and be hided."
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

	make (a_vertical_style: BOOLEAN) is
			-- Creation method. If not vertical style, it'll be horizontal style.
		do
			create internal_shared
			init (a_vertical_style)
			create internal_tab_stubs
			internal_tab_stubs.compare_objects
			set_minimum_size (0, 0)
			internal_tab_stubs.add_actions.extend (agent on_add_tab_stub)
			internal_tab_stubs.remove_actions.extend (agent on_pruned_tab_stub)
			create tab_groups
		ensure

		end

feature -- Query

	tab_stubs: like internal_tab_stubs is
			-- Tab stubs current holded.
		do
			Result := internal_tab_stubs
		end

	tab_groups: ACTIVE_LIST [like internal_tab_group]
			-- All tab groups, 2nd integer is tab group width.

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
				Result := tab_stubs.item.title.is_equal (a_content.title)
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
					Result := l_group.item.title.is_equal (a_content.title)
					l_group.forth
				end
				tab_groups.forth
			end
		end

feature -- Command

	set_tab_group (a_contents: ARRAYED_LIST [SD_CONTENT]) is
			-- Set `a_contents' to a `tab_groups'.
		require
			a_contents_not_void: a_contents /= Void
			a_contents_more_than_one: a_contents.count > 1
		local
			l_tab_group: ARRAYED_LIST [SD_TAB_STUB]
			l_tab: SD_TAB_STUB
		do
			from
				a_contents.start
			until
				a_contents.after
			loop
				l_tab := tab_by_content (a_contents.item)
				if l_tab_group = Void then
					l_tab_group := tab_group (l_tab)
				else
					l_tab_group.extend (l_tab)
				end
				a_contents.forth
			end
			update_tab_group
		ensure
			set: contents_tab_group_set (a_contents)
		end

	tab_group (a_tab: SD_TAB_STUB):like internal_tab_group  is
			-- Get the group contain `a_tab', If not found, create a new one.
		require
			a_tab_not_void: a_tab /= Void
			has_tab: has (a_tab)
		local
			l_tab_group: like internal_tab_group
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

			if Result = Void then
				create 	l_tab_group.make (1)
				l_tab_group.extend (a_tab)
				tab_groups.extend (l_tab_group)
				Result := l_tab_group
			end
		ensure
			not_void: Result /= Void
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

	update_tab_group is
			-- Update tab stubs layout by tab group.
		do
			from
				tab_groups.start
			until
				tab_groups.after
			loop
				-- Remove stub seperator by group
				update_one_tab_group (tab_groups.item)
				tab_groups.forth
			end
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
				if internal_tab_stubs.item.title.is_equal (a_content.title) then
					Result := internal_tab_stubs.item
				end
				internal_tab_stubs.forth
			end
		ensure
			not_void: Result /= Void
		end

	on_add_tab_stub (a_stub: SD_TAB_STUB) is
			-- Handle insert a tab stub event.
		require
			a_stub_not_void: a_stub /= Void
		local
			l_spacer: SD_AUTO_HIDE_SEPERATOR
		do
			extend (a_stub)
			disable_item_expand (a_stub)
			-- Add spacer.
			create l_spacer
			l_spacer.set_minimum_size (spacer_size, spacer_size)
			extend (l_spacer)
			disable_item_expand (l_spacer)

			if count /= 0 then
				if internal_vertical_style then
					set_minimum_width (internal_shared.auto_hide_panel_width)
				else
					set_minimum_height (internal_shared.auto_hide_panel_width)
				end
			internal_shared.docking_manager.resize
			end
		ensure
			added_stub_and_space: old count = count - 2 and has (a_stub)
		end

	on_pruned_tab_stub (a_stub: SD_TAB_STUB) is
			-- Handle prune a tab sutb event.
		require
			a_stub_not_void: a_stub /= Void
			has: has (a_stub)
		local
			l_seperator: SD_AUTO_HIDE_SEPERATOR
		do
			start
			search (a_stub)
			check not off end
--			forth
			-- Remove spacer.
			if not off then
				remove
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
				internal_shared.docking_manager.resize
			end

		ensure
			removed: not has (a_stub)
		end

feature {NONE} -- Impelementation attributes.

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

invariant

	internal_shared_not_void: internal_shared /= Void
	internal_tab_stubs_not_void: internal_tab_stubs /= Void
	tab_groups_not_void: tab_groups /= Void

end
