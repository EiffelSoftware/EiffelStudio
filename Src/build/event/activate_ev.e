indexing
	description: "Item or text field activate event."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ACTIVATE_EV

inherit
	EVENT

creation
	make

feature -- Access

	identifier: INTEGER is
		do
			Result := - Event_const.activate_ev_id
		end

	symbol: EV_PIXMAP is
		do
			Result := Pixmaps.activate_pixmap
		end

	internal_name: STRING is
		do
			Result := Event_const.activate_label
		end

	eiffel_text: STRING is "add_activate_command ("

end -- class ACTIVATE_EV

