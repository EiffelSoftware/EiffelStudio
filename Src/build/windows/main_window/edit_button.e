indexing
	description: "Edit button hole for editable stones."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

deferred class EDIT_BUTTON 

inherit
	EB_BUTTON_COM

	WINDOWS

feature {NONE}

	execute (arg: EV_ARGUMENT; ev_data: EV_EVENT_DATA) is
		do
			if main_window.project_initialized then
				create_empty_editor
			end
		end	

	create_empty_editor is
		deferred
		end

end -- class EDIT_BUTTON

