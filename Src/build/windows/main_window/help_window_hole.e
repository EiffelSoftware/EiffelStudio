indexing
	description: "Help hole for the help window."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class HELP_WINDOW_HOLE 

inherit
	HELP_HOLE
		rename
			make as button_make
		redefine
			create_empty_editor
		end

creation
	make

feature {NONE} -- Initialization

	associated_window: HELP_WINDOW

	make (hw: HELP_WINDOW; par: EV_CONTAINER) is
		require
			valid_hw: hw /= Void
			valid_a_parent: par /= Void
		local
			cmd: EV_ROUTINE_COMMAND
		do
			associated_window := hw
			button_make (par)
			create cmd.make (hw~update_text)
			add_default_pnd_command (cmd, Void)
		end

feature {NONE}

	full_symbol: EV_PIXMAP is
		do
			Result := Pixmaps.full_help_pixmap
		end

feature {NONE} -- Command

	create_empty_editor is
		do
		end

feature

	set_empty_symbol is
		do
--			if pixmap /= symbol then
--				set_symbol (symbol)
--			end
		end

	set_full_symbol is
		do
--			if pixmap /= full_symbol then
--				set_symbol (full_symbol)
--			end
		end

end -- class HELP_WINDOW_HOLE

