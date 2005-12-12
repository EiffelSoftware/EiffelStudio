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
		do
			
		end
	
	on_drop_actions (a_any: ANY) is
			-- Handle drop actions.
		do
			internal_docking_manager.tab_drop_actions.call ([a_any, internal_notebook.selected_item])
		end
		
feature {NONE}  -- Implementation
	
	internal_notebook: SD_NOTEBOOK
			-- Notebook which Current belong to.
	
	internal_docking_manager: SD_DOCKING_MANAGER
			-- Docking manager which Current belong to.
end
