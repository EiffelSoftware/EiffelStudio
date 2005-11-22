indexing
	description: "SD_ZONE which tab is at top side without SD_TITLE_BAR"
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TAB_ZONE_UPPER

inherit
	SD_TAB_ZONE
		redefine
			make,
			on_select_tab
		end
create
	make

feature {NONE} -- Initlization

	make (a_content: SD_CONTENT; a_target_zone: SD_DOCKING_ZONE) is
			-- Redefine.
		do
			Precursor {SD_TAB_ZONE} (a_content, a_target_zone)
			prune_vertical_box (internal_notebook)
			create notebook.make (internal_notebook)
			extend_vertical_box (notebook)
			notebook.close_actions.extend (agent on_close)
		ensure then
			notebook_added: has_vertical_box (notebook)
		end


feature {NONE} -- Implementation

	on_select_tab is
			-- Redefine
		local
			l_content: SD_CONTENT
		do
			if not internal_diable_on_select_tab then
				Precursor {SD_TAB_ZONE}
				l_content := internal_contents.i_th (internal_notebook.selected_item_index)
				if l_content.mini_toolbar /= Void then
					notebook.set_mini_tool_bar (l_content.mini_toolbar)
				end
			end
		end

feature {NONE}

	notebook: SD_NOTEBOOK
			-- Notebook which tabs at top.

invariant

	notebook_not_void: notebook /= Void

end
