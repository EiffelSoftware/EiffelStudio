indexing
	description: "Widget mouse button 2 release event."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MOUSE2_RELEASE_EV

inherit
	EVENT

creation
	make

feature -- Access

	identifier: INTEGER is
		do
			Result := - Event_const.mouse2_release_ev_id
		end

	symbol: EV_PIXMAP is
		do
			Result := Pixmaps.mouse2_release_pixmap
		end

	internal_name: STRING is
		do
			Result := Event_const.mouse2_release_label
		end

	eiffel_text: STRING is "add_button_release_command (2, "

end -- class MOUSE2_RELEASE_EV

