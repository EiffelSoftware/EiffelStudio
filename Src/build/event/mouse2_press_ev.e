indexing
	description: "Widget mouse button 2 press event."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MOUSE2_PRESS_EV

inherit
	EVENT

creation
	make

feature -- Access

	identifier: INTEGER is
		do
			Result := - Event_const.mouse2_press_ev_id
		end

	symbol: EV_PIXMAP is
		do
			Result := Pixmaps.mouse2_press_pixmap
		end

	internal_name: STRING is
		do
			Result := Event_const.mouse2_press_label
		end

	eiffel_text: STRING is "add_button_press_command (2, "

end -- class MOUSE2_PRESS_EV

