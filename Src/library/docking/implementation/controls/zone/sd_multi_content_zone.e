indexing
	description: "Objects that contains mulit SD_CONTENTs."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SD_MULTI_CONTENT_ZONE
inherit
	SD_ZONE
		rename
			set_content as extend,
			internal_shared as internal_shared_not_used
		undefine
			is_equal, copy, default_create
		end
feature

	content: SD_CONTENT is
			--
		do
			if internal_notebook.selected_item_index /= 0 then
				Result := internal_contents.i_th (internal_notebook.selected_item_index)
			else
				Result := last_content
			end

		end

	extend (a_content: SD_CONTENT) is
			--
		do
			internal_contents.extend (a_content)
			internal_notebook.extend (a_content.user_widget)
			internal_notebook.set_item_text (a_content.user_widget, a_content.title)
			internal_notebook.item_tab (a_content.user_widget).set_pixmap (a_content.pixmap)
			internal_notebook.item_tab (a_content.user_widget).enable_select


--			init_focus_in (a_content.user_widget)			

		end

	prune (a_content: SD_CONTENT) is
			--
		do
			disable_on_select_tab
			internal_contents.prune_all (a_content)
			internal_notebook.prune_all (a_content.user_widget)
			enable_on_select_tab
		end

	count: INTEGER is
			--
		do
			Result := internal_contents.count
		end

	last_content: SD_CONTENT is
			--
		require
			only_one_content: only_one_content
		do
			internal_contents.start
			Result := internal_contents.item
		end

	only_one_content: BOOLEAN is
			--
		do
			Result := internal_contents.count = 1
		end


feature {SD_STATE}

	disable_on_select_tab is
			-- If `Current' pruning a zone?
		do
			internal_diable_on_select_tab := True
		end

	enable_on_select_tab is
			--
		do
			internal_diable_on_select_tab := False
		end

feature {NONE} -- Implementation



	internal_contents: ARRAYED_LIST [SD_CONTENT]
			-- SD_CONTENTs managed by `Current'.


	internal_notebook: EV_NOTEBOOK
			-- Container which `Current' in.

	internal_diable_on_select_tab: BOOLEAN
			-- If `Current' pruning a zone?
end
