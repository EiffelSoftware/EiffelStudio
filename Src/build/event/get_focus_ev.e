indexing
	description: "Widget get focus event."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GET_FOCUS_EV

inherit
	EVENT

creation
	make

feature -- Access

	identifier: INTEGER is
		do
			Result := - Event_const.get_focus_ev_id
		end

	symbol: EV_PIXMAP is
		do
			Result := Pixmaps.get_focus_pixmap
		end

	internal_name: STRING is
		do
			Result := Event_const.get_focus_label
		end

	eiffel_text: STRING is "add_get_focus_command ("

end -- class GET_FOCUS_EV

