indexing
	description: "Window close event."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CLOSE_EV

inherit
	EVENT

creation
	make

feature -- Initialization

	identifier: INTEGER is
		do
			Result := - Event_const.close_ev_id
		end

	symbol: EV_PIXMAP is
		do
			Result := Pixmaps.close_pixmap
		end

	internal_name: STRING is
		do
			Result := Event_const.close_label
		end

	eiffel_text: STRING is "add_close_command ("

end -- class CLOSE_EV

