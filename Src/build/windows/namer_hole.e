indexing
	description: "General namer hole."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class NAMER_HOLE 

inherit

	EDIT_BUTTON
		redefine
			make
		end

creation

	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
		local
			cmd: EV_ROUTINE_COMMAND
		do
			{EDIT_BUTTON} Precursor (par)
			create cmd.make (~process_rename)
			add_default_pnd_command (cmd, Void)
		end

--	create_focus_label is 
--		do
--			set_focus_string (Focus_labels.namer_label)
--		end

	symbol: EV_PIXMAP is
		do
			Result := Pixmaps.namer_pixmap
		end

feature {NAMER_HOLE} -- Command

	process_rename (arg: EV_ARGUMENT; ev_data: EV_PND_EVENT_DATA) is
		local
			namable: NAMABLE
		do
			namable ?= ev_data.data
			if namable /= Void and then namable.is_able_to_be_named then
				namer_window.popup_with (namable)
			end
		end

	create_empty_editor is
		do
		end

end -- class NAMER_HOLE

