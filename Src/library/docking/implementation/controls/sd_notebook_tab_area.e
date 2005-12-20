indexing
	description: "Objects that manage tabs on SD_NOTEBOOK. A decorator."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_NOTEBOOK_TAB_AREA

inherit
	EV_HORIZONTAL_BOX

create
	make

feature {NONE}  -- Initlization

	make (a_notebook: SD_NOTEBOOK; a_docking_manager: SD_DOCKING_MANAGER) is
			-- Creation method.
		require
			a_notebook_not_void: a_notebook /= Void
			a_docking_manager_not_void: a_docking_manager /= Void
		do
			default_create
			internal_notebook := a_notebook
			internal_docking_manager := a_docking_manager

			if internal_docking_manager.tab_drop_actions.count > 0 then
				drop_actions.extend (agent on_drop_actions)
			end
			resize_actions.extend (agent on_resize)
		ensure
			set: internal_docking_manager = a_docking_manager
			set: internal_notebook = a_notebook
		end

feature {NONE}  -- Implementation

	on_resize (a_x: INTEGER; a_y: INTEGER; a_width: INTEGER; a_height: INTEGER) is
			-- Handle resize actions.
		local
			l_tabs: ARRAYED_LIST [SD_NOTEBOOK_TAB]
		do
			l_tabs := all_tabs
			
		end

	on_drop_actions (a_any: ANY) is
			-- Handle drop actions.
		do
			internal_docking_manager.tab_drop_actions.call ([a_any, internal_notebook.selected_item])
		end

	all_tabs: ARRAYED_LIST [SD_NOTEBOOK_TAB] is
			-- All tabs in Current.
		local
			l_temp_tab: SD_NOTEBOOK_TAB
		do
			create Result.make (1)
			from
				start
			until
				after
			loop
				l_temp_tab ?= item
				check only_has_sd_tab: l_temp_tab /= Void end
				Result.extend (l_temp_tab)
				forth
			end

		end

feature {NONE}  -- Implementation

	internal_notebook: SD_NOTEBOOK
			-- Notebook which Current belong to.

	internal_docking_manager: SD_DOCKING_MANAGER
			-- Docking manager which Current belong to.
end
