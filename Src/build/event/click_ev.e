indexing
	description: "Button click event."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CLICK_EV

inherit
	EVENT

creation
	make

feature -- Access

	identifier: INTEGER is
		do
			Result := - Event_const.click_ev_id
		end

	symbol: EV_PIXMAP is
		do
			Result := Pixmaps.button_click_pixmap
		end

	internal_name: STRING is
		do
			Result := Event_const.button_click_label
		end

	eiffel_text: STRING is "add_click_command ("

end -- class CLICK_EV

