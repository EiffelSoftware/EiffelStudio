indexing
	description: "Command to open a file"
	author: "Christophe Bonnard"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_OPEN_CMD

inherit
	SHARED_EIFFEL_PROJECT
	EB_EDITOR_COMMAND
	EB_SHARED_INTERFACE_TOOLS
	NEW_EB_CONSTANTS

	EB_CONFIRM_SAVE_CALLBACK

feature -- Properties

--	symbol: EV_PIXMAP is
--			-- Pixmap for the button.
--		once
--			Result := Pixmaps.bm_Open
--		end

feature {NONE} -- Attributes

--	name: STRING is
--			-- Name of the command.
--		do
--			Result := Interface_names.f_Open
--		end

--	menu_name: STRING is
--			-- Name used in menu entry
--		do
--			Result := Interface_names.m_Open
--		end

--	accelerator: STRING is
--			-- Accelerator action for menu entry
--		do
--			Result := Interface_names.a_Open
--		end

end -- class EB_OPEN_CMD
