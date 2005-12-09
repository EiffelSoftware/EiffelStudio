indexing
	description: "Docking manager properties."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_DOCKING_MANAGER_PROPERTY

create
	make
	
feature {NONE}  -- Initlization
	
	make (a_docking_manager: SD_DOCKING_MANAGER) is
			-- Creation method.
		require
			a_docking_manager_not_void: a_docking_manager /= Void
		do
			internal_docking_manager := a_docking_manager
		ensure
			set: internal_docking_manager = a_docking_manager
		end

feature -- Properties
	
	last_focus_content: SD_CONTENT
			-- Last focused zone.
		
	set_last_focus_content (a_content: SD_CONTENT) is
			-- Set `last_focus_content'.
		require
			a_content_not_void: a_content /= Void
		do
			last_focus_content := a_content
		ensure
			set: last_focus_content = a_content
		end

feature {NONE}  -- Implementation
	
	internal_docking_manager: SD_DOCKING_MANAGER
			-- Docking manager which Current belong to.
end
