indexing
	description: "Abstract notion of a command to save a file."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_SAVE_COMMAND

obsolete "use EV_SAVE_FILE_COMMMAND instead"

inherit
	EB_GENERAL_DATA

	NEW_EB_CONSTANTS

	EB_EDITOR_COMMAND

	EB_COMMAND_FEEDBACK

feature -- Properties

--	unmodified_pixmap: EV_PIXMAP is 
--			-- Pixmap for the button.
--		once 
--			Result := Pixmaps.bm_Save 
--		end
--
--	modified_pixmap: EV_PIXMAP is
--			-- Pixmap for the button.
--		once
--			Result := Pixmaps.bm_Modified
--		end

feature {NONE} -- Attributes

	license_checked: BOOLEAN is True
			-- Is the license checked?

--	name: STRING is
--			-- Name of the command.
--		do
--			Result := Interface_names.f_Save
--		end

--	menu_name: STRING is
--			-- Name used in menu entry
--		do
--			Result := Interface_names.m_Save
--		end

--	accelerator: STRING is
--			-- Accelerator action for menu entry
--		do
--			Result := Interface_names.a_Save
--		end

feature -- Execution

	execute is deferred end

end -- class EB_SAVE_CMD
