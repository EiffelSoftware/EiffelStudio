indexing
	description: "Button to save a project."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class SAVE_BUTTON

inherit
	EB_BUTTON
		redefine
			make
		end

	WINDOWS

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
		local
			cmd: SAVE_PROJECT
		do
			{EB_BUTTON} Precursor (par)
			create cmd
			add_click_command (cmd, Void)
		end

feature {NONE} -- Button

--	create_focus_label is 
--		do
--			set_focus_string (Focus_labels.save_project_label)
--		end

	symbol: EV_PIXMAP is
		do
			Result := Pixmaps.save_pixmap
		end

	unsaved_symbol: EV_PIXMAP is
		do
			Result := Pixmaps.unsave_pixmap
		end

feature -- Status setting

	set_saved_symbol is
		do
			if pixmap /= symbol then
				set_pixmap (symbol)
			end
		end

	set_unsaved_symbol is
		do
			if pixmap /= unsaved_symbol then
				set_pixmap (unsaved_symbol)
			end
		end

end -- class SAVE_BUTTON

