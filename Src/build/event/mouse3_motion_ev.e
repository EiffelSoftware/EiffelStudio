indexing
	description: "Widget mouse move event while button 3 is pressed."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MOUSE3_MOTION_EV

inherit
	EVENT

creation
	make

feature -- Access

	identifier: INTEGER is
		do
			Result := - Event_const.mouse3_motion_ev_id
		end

	symbol: EV_PIXMAP is
		do
			Result := Pixmaps.mouse3_motion_pixmap
		end

	internal_name: STRING is
		do
			Result := Event_const.mouse3_motion_label
		end

	eiffel_text: STRING is "add_button_motion_command (3, "

end -- class MOUSE3_MOTION_EV

