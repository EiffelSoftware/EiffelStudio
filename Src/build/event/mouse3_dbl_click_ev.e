indexing
	description: "Widget mouse button 3 double click event."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MOUSE3_DBL_CLICK_EV

inherit
	EVENT

creation
	make

feature -- Access

	identifier: INTEGER is
		do
			Result := - Event_const.mouse3_dbl_click_ev_id
		end

	symbol: EV_PIXMAP is
		do
			Result := Pixmaps.mouse3_dbl_click_pixmap
		end

	internal_name: STRING is
		do
			Result := Event_const.mouse3_dbl_click_label
		end

	eiffel_text: STRING is "add_double_click_command (3, "

end -- class MOUSE3_DBL_CLICK_EV

