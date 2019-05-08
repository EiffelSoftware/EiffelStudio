note
	description: "SD_ZONE that contains mulit SD_CONTENTs."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SD_MULTI_CONTENT_ZONE

inherit
	SD_ZONE
		redefine
			set_last_floating_width,
			set_last_floating_height,
			has_content
		end

feature -- Query

	has_content: BOOLEAN
			-- Has content?
		do
			Result := count > 0
		end

	content: SD_CONTENT
			-- <Precursor>
		local
			i: INTEGER
		do
			i := internal_notebook.selected_item_index
			if i /= 0 and then contents.valid_index (i) then
				Result := contents.i_th (i)
			else
				check has_content: has_content then
					Result := last_content
				end
			end
		ensure then
			not_void: Result /= Void
		end

	contents: ARRAYED_LIST [SD_CONTENT]
			-- SD_CONTENTs managed by `Current'
		do
			Result := internal_notebook.contents
		end

	count: INTEGER
			-- How many SD_CONTENT in `Current'?
		do
			Result := contents.count
		end

	last_content: SD_CONTENT
			-- Last content when there is at least one widget
		require
			only_one_content: count > 0
		local
			l_contents: like contents
		do
			l_contents := contents
			l_contents.start
			Result := l_contents.item
		ensure
			not_void: Result /= Void
		end

	tabs_shown: HASH_TABLE [SD_NOTEBOOK_TAB, INTEGER]
			-- Tabs which is shown
		local
			l_tabs: ARRAYED_LIST [SD_NOTEBOOK_TAB]
		do
			create Result.make (10)
			l_tabs := internal_notebook.tabs_shown
			from
				l_tabs.start
			until
				l_tabs.after
			loop
				Result.extend (l_tabs.item, internal_notebook.index_of_tab (l_tabs.item))
				l_tabs.forth
			end
		end

feature -- Command

	extend (a_content: SD_CONTENT)
			-- <Precursor>
		do
			if not contents.has (a_content) then
				internal_notebook.extend (a_content)

				internal_notebook.select_item (a_content, True)
			end
		ensure then
			extended: contents.has (a_content)
			internal_notebook.has (a_content)
			selected: internal_notebook.selected_item_index = internal_notebook.index_of (a_content)
		end

	extend_contents (a_contents: LIST [SD_CONTENT])
			-- Extend `a_contents'
			-- This feature is faster than extend one by one
		require
			not_void: a_contents /= Void
		do
			internal_notebook.extend_contents (a_contents)
			if not a_contents.is_empty then
				internal_notebook.select_item (a_contents.last, True)
			end
			internal_notebook.set_focus_color (False)
		end

	replace_user_widget (a_content: SD_CONTENT)
			-- Replace `user_widget' which is related to `a_content'
		require
			has: has (a_content)
		do
			internal_notebook.replace (a_content)
		end

	update_mini_tool_bar (a_content: SD_CONTENT)
			-- Replace `mini_toolbar' which is related to `a_content'
		do
		end

	prune (a_content: SD_CONTENT; a_focus: BOOLEAN)
			-- Prune `a_content' from `Current'
		require
			a_content_not_void: a_content /= Void
			has_content: has (a_content)
		do
			internal_notebook.prune (a_content, a_focus)
		ensure
			pruned: not has (a_content)
			pruned: not internal_notebook.has (a_content)
		end

	set_last_floating_width (a_width: INTEGER)
			-- <Precursor>
		local
			l_content: ARRAYED_LIST [SD_CONTENT]
		do
			from
				l_content := contents
				l_content.start
			until
				l_content.after
			loop
				l_content.item.state.set_last_floating_width (a_width)
				l_content.forth
			end
		end

	set_last_floating_height (a_height: INTEGER)
			-- <Precursor>
		local
			l_content: ARRAYED_LIST [SD_CONTENT]
		do
			from
				l_content := contents
				l_content.start
			until
				l_content.after
			loop
				l_content.item.state.set_last_floating_height (a_height)
				l_content.forth
			end
		end

	change_tab_tooltip (a_content: SD_CONTENT; a_tooltip: detachable READABLE_STRING_GENERAL)
			-- Change `a_content' tab's tooltip to `a_tooltip'
		require
			not_void: a_content /= Void
			has: has (a_content)
		do
			internal_notebook.tab_by_content (a_content).set_tool_tip (a_tooltip)
		end

feature {SD_OPEN_CONFIG_MEDIATOR} -- Save config

	save_content_title (a_config_data: SD_INNER_CONTAINER_DATA)
			-- <Precursor>
		local
			l_contents: like contents
		do
			l_contents := contents
			from
				l_contents.start
			until
				l_contents.after
			loop
				a_config_data.add_title (l_contents.item.unique_title)
				l_contents.forth
			end
		end

feature -- States report

	has (a_content: SD_CONTENT): BOOLEAN
			-- <Precursor>
		do
			Result := contents.has (a_content)
		end

	only_one_content: BOOLEAN
			-- If there only one SD_CONTENT in `Current'?
		do
			Result := contents.count = 1
		end

	index_of (a_content: SD_CONTENT): INTEGER
			-- Index of `i'th occurrence of `a_content'
		require
			a_content_not_void: a_content /= Void
		do
			Result := internal_notebook.index_of (a_content)
		end

feature {NONE} -- Implementation

	internal_notebook: SD_NOTEBOOK;
			-- Container which `Current' belong to

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2018, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
