indexing
	description: "Multi column list column click event."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	COLUMN_CLICK_EV

inherit
	EVENT

creation
	make

feature -- Access

	identifier: INTEGER is
		do
			Result := - Event_const.column_click_ev_id
		end

	symbol: EV_PIXMAP is
		do
			Result := Pixmaps.column_click_pixmap
		end

	internal_name: STRING is
		do
			Result := Event_const.column_click_label
		end

	eiffel_text: STRING is "add_column_click_command ("

end -- class COLUMN_CLICK_EV

