indexing
	description: "Widget mouse move event while button 1 is pressed."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MOUSE1_MOTION_EV

inherit
	EVENT

creation
	make

feature -- Access

	identifier: INTEGER is
		do
			Result := - Event_const.mouse1_motion_ev_id
		end

	symbol: EV_PIXMAP is
		do
			Result := Pixmaps.mouse1_motion_pixmap
		end

	internal_name: STRING is
		do
			Result := Event_const.mouse1_motion_label
		end

	eiffel_text: STRING is "add_button_motion_command (1, "

end -- class MOUSE1_MOTION_EV

