indexing
	description: "Toggle event."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TOGGLE_EV

inherit
	EVENT

creation
	make

feature -- Access

	identifier: INTEGER is
		do
			Result := - Event_const.toggle_ev_id
		end

	symbol: EV_PIXMAP is
		do
			Result := Pixmaps.toggle_pixmap
		end

	internal_name: STRING is
		do
			Result := Event_const.toggle_label
		end

	eiffel_text: STRING is "add_toggle_command ("

end -- class TOGGLE_EV

