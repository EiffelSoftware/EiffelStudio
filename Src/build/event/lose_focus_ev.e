indexing
	description: "Widget lose focus event."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LOSE_FOCUS_EV

inherit
	EVENT

creation
	make

feature -- Access

	identifier: INTEGER is
		do
			Result := - Event_const.lose_focus_ev_id
		end

	symbol: EV_PIXMAP is
		do
			Result := Pixmaps.lose_focus_pixmap
		end

	internal_name: STRING is
		do
			Result := Event_const.lose_focus_label
		end

	eiffel_text: STRING is "add_lose_focus_command ("

end -- class LOSE_FOCUS_EV

