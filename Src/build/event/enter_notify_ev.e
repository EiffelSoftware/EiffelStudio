indexing
	description: "Widget enter notify event."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ENTER_NOTIFY_EV

inherit
	EVENT

creation
	make

feature -- Access

	identifier: INTEGER is
		do
			Result := - Event_const.enter_notify_ev_id
		end

	symbol: EV_PIXMAP is
		do
			Result := Pixmaps.enter_notify_pixmap
		end

	internal_name: STRING is
		do
			Result := Event_const.enter_notify_label
		end

	eiffel_text: STRING is "add_enter_notify_command ("

end -- class ENTER_NOTIFY_EV

