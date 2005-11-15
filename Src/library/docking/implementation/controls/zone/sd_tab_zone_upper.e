indexing
	description: "Objects which tab is at top side"
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
			--
		do
			Precursor {SD_TAB_ZONE} (a_content, a_target_zone)

			prune_vertical_box (internal_notebook)

			create notebook.make (internal_notebook)

			extend_vertical_box (notebook)
		end

feature {NONE} -- Redefine

	on_select_tab is
			--
		local
			l_content: SD_CONTENT
		do
			Precursor {SD_TAB_ZONE}
			l_content := internal_contents.i_th (internal_notebook.selected_item_index)
			if l_content.mini_toolbar /= Void then
				notebook.set_mini_tool_bar (l_content.mini_toolbar)
			end

		end

feature {NONE}

	notebook: SD_NOTEBOOK

end
