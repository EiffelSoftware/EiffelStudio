indexing
	description: "Text field return event: Key Enter pressed."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	RETURN_EV

inherit
	EVENT

creation
	make

feature -- Access

	identifier: INTEGER is
		do
			Result := - Event_const.return_ev_id
		end

	symbol: EV_PIXMAP is
		do
			Result := Pixmaps.key_return_pixmap
		end

	internal_name: STRING is
		do
			Result := Event_const.return_label
		end

	eiffel_text: STRING is "add_activate_command ("

end -- class RETURN_EV

