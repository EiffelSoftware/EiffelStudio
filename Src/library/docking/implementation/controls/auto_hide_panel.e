indexing
	description: "Objects that are panel can hold widgets and hide it self automatically."
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
			set_minimum_size (0, 0)

			internal_tab_stubs.add_actions.extend (agent handle_insert_tab_stub)
			internal_tab_stubs.remove_actions.extend (agent handle_pruned_tab_stub)

			create tab_groups.make (0)
		end

feature -- Access

	tab_stubs: like internal_tab_stubs is
			-- The tab stubs current holded.
		do
			Result := internal_tab_stubs
		end

	tab_groups: ARRAYED_LIST [like internal_tab_group]
			-- All tab groups.

	set_tab_group (a_contents: ARRAYED_LIST [SD_CONTENT]) is
			--
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
				end
				l_tab_group.extend (l_tab)
				a_contents.forth
			end

			update_tab_group
		end

feature -- States report

	has (a_tab: SD_TAB_STUB): BOOLEAN is
			-- If `Current' has a_tab ?
		do
			start
			Result := Precursor {SD_HOR_VER_BOX} (a_tab)
		end

	has_tab (a_content: SD_CONTENT): BOOLEAN is
			--
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
			--
		do

		end


feature {NONE} -- Implementation

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
		end

	tab_group (a_tab: SD_TAB_STUB):like internal_tab_group  is
			-- Get the group contain `a_tab', If not found, create a new one.
		require
			has_tab: has (a_tab)
			a_tab_not_void: a_tab /= Void
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

	tab_by_content (a_content: SD_CONTENT): SD_TAB_STUB is
			--
		require
			has_tab: has_tab (a_content)
			a_content_not_void: a_content /= Void
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

	handle_insert_tab_stub (a_stub: SD_TAB_STUB) is
			-- Handle insert a tab stub event.
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
			end
		end

	handle_pruned_tab_stub (a_stub: SD_TAB_STUB) is
			-- Handle prune a tab sutb event.
		require
			a_stub_not_void: a_stub /= Void
		local
			l_seperator: SD_AUTO_HIDE_SEPERATOR
		do
			start
			search (a_stub)
--			forth
--			-- Remove spacer.
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
			end
		end

	auto_host_panel: SD_AUTO_HIDE_ZONE
			-- a Panel that will host the actual EV_NOTEBOOK control,
            -- the Panel is resized to slide into/from view.

	internal_tab_stubs: ACTIVE_LIST [SD_TAB_STUB]

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

end
