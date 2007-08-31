indexing
	description: "Commands that maximized whole editor area."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_MAXIMIZE_EDITOR_AREA_COMMAND

inherit
	EB_MENUABLE_COMMAND

	EB_DEVELOPMENT_WINDOW_COMMAND
		rename
			target as develop_window
		redefine
			make
		end

	EB_CONSTANTS

create
	make

feature {NONE} -- Initlization

	make (a_develop_window: EB_DEVELOPMENT_WINDOW) is
			-- Creation method
		do
			Precursor {EB_DEVELOPMENT_WINDOW_COMMAND}(a_develop_window)
			enable_sensitive
			a_develop_window.docking_manager.restore_editor_area_actions.extend (agent update_maximized_state)
		end

feature -- Query

	menu_name: STRING_GENERAL is
			-- Menu name
		do
			if not is_maximized then
				Result := interface_names.m_maximize_editor_area
			else
				Result := interface_names.m_restore_editor_area
			end
		end

	is_maximized: BOOLEAN
			-- If editor area maximized?

feature -- Command

	execute is
			-- Execute
		local
			l_manager: SD_DOCKING_MANAGER
		do
			l_manager := develop_window.docking_manager
			if l_manager.is_editor_area_maximized then
				l_manager.restore_editor_area
			else
				l_manager.maximize_editor_area
			end
			update_maximized_state
		end

	update_maximized_state is
			-- Update `is_maximized'
		local
			l_manager: SD_DOCKING_MANAGER
		do
			l_manager := develop_window.docking_manager
			if l_manager.is_editor_area_maximized then
				is_maximized := True
			else
				is_maximized := False
			end
			check only_one: managed_menu_items.count = 1 end
			managed_menu_items.first.set_text (menu_name)
		end

end
