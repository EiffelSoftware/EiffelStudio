indexing
	description: "List item double click event."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DOUBLE_CLICK_EV

inherit
	EVENT

creation
	make

feature -- Access

	identifier: INTEGER is
		do
			Result := - Event_const.double_click_ev_id
		end

	symbol: EV_PIXMAP is
		do
			Result := Pixmaps.double_click_pixmap
		end

	internal_name: STRING is
		do
			Result := Event_const.double_click_label
		end

	eiffel_text: STRING is "add_double_click_command ("

end -- class DOUBLE_CLICK_EV

