indexing
	description: "Text change event."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CHANGE_EV

inherit
	EVENT

creation
	make

feature -- Access

	identifier: INTEGER is
		do
			Result := - Event_const.change_ev_id
		end

	symbol: EV_PIXMAP is
		do
			Result := Pixmaps.change_pixmap
		end

	internal_name: STRING is
		do
			Result := Event_const.change_label
		end

	eiffel_text: STRING is "add_change_command ("

end -- class CHANGE_EV

