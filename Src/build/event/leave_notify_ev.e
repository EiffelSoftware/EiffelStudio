indexing
	description: "Widget leave notify event."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LEAVE_NOTIFY_EV

inherit
	EVENT

creation
	make

feature -- Access

	identifier: INTEGER is
		do
			Result := - Event_const.leave_notify_ev_id
		end

	symbol: EV_PIXMAP is
		do
			Result := Pixmaps.leave_notify_pixmap
		end

	internal_name: STRING is
		do
			Result := Event_const.leave_notify_label
		end

	eiffel_text: STRING is "add_leave_notify_command ("

end -- class LEAVE_NOTIFY_EV

