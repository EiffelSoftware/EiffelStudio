indexing
	description: "Notebook switch page event."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SWITCH_EV

inherit
	EVENT

creation
	make

feature -- Access

	identifier: INTEGER is
		do
			Result := - Event_const.switch_ev_id
		end

	symbol: EV_PIXMAP is
		do
			Result := Pixmaps.switch_pixmap
		end

	internal_name: STRING is
		do
			Result := Event_const.switch_label
		end

	eiffel_text: STRING is "add_switch_command ("

end -- class SWITCH_EV

