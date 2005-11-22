indexing
	description: "SD_ZONE that contains mulit SD_CONTENTs."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SD_MULTI_CONTENT_ZONE

inherit
	SD_ZONE
		rename
			internal_shared as internal_shared_not_used
		redefine
			extend
		end

feature -- Query

	content: SD_CONTENT is
			-- Redefine
		do
			if internal_notebook.selected_item_index /= 0 then
				Result := internal_contents.i_th (internal_notebook.selected_item_index)
			else
				Result := last_content
			end
		ensure then
			not_void: Result /= Void
		end

	count: INTEGER is
			-- How many SD_CONTENT in `Current'?
		do
			Result := internal_contents.count
		end

	last_content: SD_CONTENT is
			-- Last content when there is only one widget.
		require
--			only_one_content: only_one_content
		do
			internal_contents.start
			Result := internal_contents.item
		ensure
			not_void: Result /= Void
		end

feature -- Command

	extend (a_content: SD_CONTENT) is
			-- Redefine
		do
			internal_contents.extend (a_content)
			internal_notebook.extend (a_content.user_widget)
			internal_notebook.set_item_text (a_content.user_widget, a_content.title)
			internal_notebook.item_tab (a_content.user_widget).set_pixmap (a_content.pixmap)
			internal_notebook.item_tab (a_content.user_widget).enable_select
		ensure then
			extended: internal_contents.has (a_content)
			internal_notebook.has (a_content.user_widget)
			selected: internal_notebook.selected_item_index = internal_notebook.index_of (a_content.user_widget, 1)
		end

	prune (a_content: SD_CONTENT) is
			-- Prune `a_content' from `Current'.
		require
			a_content_not_void: a_content /= Void
			has_content: has (a_content)
		do
			disable_on_select_tab
			internal_contents.prune_all (a_content)
			internal_notebook.prune_all (a_content.user_widget)
			enable_on_select_tab
		ensure
			pruned: not has (a_content)
			pruned: not internal_notebook.has (a_content.user_widget)
		end

feature {SD_CONFIG_MEDIATOR} -- Save config

	save_content_title (a_config_data: SD_INNER_CONTAINER_DATA) is
			-- Redefine.
		do
			from
				internal_contents.start
			until
				internal_contents.after
			loop
				a_config_data.add_title (internal_contents.item.title)
				internal_contents.forth
			end
		end

feature {SD_STATE} -- Handle select tab.

	disable_on_select_tab is
			-- If `Current' pruning a zone, disable handle select tab events.
		do
			internal_diable_on_select_tab := True
		ensure
			set: internal_diable_on_select_tab = True
		end

	enable_on_select_tab is
			--If `Current' not pruning a zone, enable handle select tab events.
		do
			internal_diable_on_select_tab := False
		ensure
			set: internal_diable_on_select_tab = False
		end

feature -- States report

	has (a_content: SD_CONTENT): BOOLEAN is
			-- Redefine.
		do
			internal_contents.start
			Result := internal_contents.has (a_content)
		end

	only_one_content: BOOLEAN is
			-- If there only one SD_CONTENT in `Current'.
		do
			Result := internal_contents.count = 1
		end

	index_of (a_content: SD_CONTENT; i: INTEGER): INTEGER is
			-- Index of `i'th occurrence of `a_content'.
		require
			a_content_not_void: a_content /= Void
			positive_occurrences: i > 0
		do
			Result := internal_notebook.index_of (a_content.user_widget, i)
		end

feature {NONE} -- Implementation

	internal_contents: ARRAYED_LIST [SD_CONTENT]
			-- SD_CONTENTs managed by `Current'.

	internal_notebook: EV_NOTEBOOK
			-- Container which `Current' in.

	internal_diable_on_select_tab: BOOLEAN
			-- If `Current' pruning a zone?
end
