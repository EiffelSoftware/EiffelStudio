indexing
	description: "Item select event."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SELECT_EV

inherit
	EVENT

creation
	make

feature -- Access

	identifier: INTEGER is
		do
			Result := - Event_const.select_ev_id
		end

	symbol: EV_PIXMAP is
		do
			Result := Pixmaps.select_pixmap
		end

	internal_name: STRING is
		do
			Result := Event_const.select_label
		end

	eiffel_text: STRING is "add_activate_command ("

end -- class SELECT_EV

