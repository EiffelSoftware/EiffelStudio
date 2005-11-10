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

feature -- States report

	has (a_tab: SD_TAB_STUB): BOOLEAN is
			-- If `Current' has a_tab ?
		do
			start
			Result := Precursor {SD_HOR_VER_BOX} (a_tab)
		end

feature {NONE} -- Implementation

	handle_insert_tab_stub (a_stub: SD_TAB_STUB) is
			-- Handle insert a tab stub event.
		local
			l_spacer: EV_CELL
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
		do
			start
			search (a_stub)
--			forth
--			-- Remove spacer.
			if not off then
				remove
				check a_spacer_behind: not after end
				remove
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
