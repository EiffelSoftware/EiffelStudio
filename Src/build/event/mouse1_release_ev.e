indexing
	description: "Widget mouse button 1 release event."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MOUSE1_RELEASE_EV

inherit
	EVENT

creation
	make

feature -- Access

	identifier: INTEGER is
		do
			Result := - Event_const.mouse1_release_ev_id
		end

	symbol: EV_PIXMAP is
		do
			Result := Pixmaps.mouse1_release_pixmap
		end

	internal_name: STRING is
		do
			Result := Event_const.mouse1_release_label
		end

	eiffel_text: STRING is "add_button_release_command (1, "

end -- class MOUSE1_RELEASE_EV

