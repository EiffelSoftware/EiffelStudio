indexing
	description: "Drawing area repaint event."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PAINT_EV

inherit
	EVENT

creation
	make

feature -- Access

	identifier: INTEGER is
		do
			Result := - Event_const.paint_ev_id
		end

	symbol: EV_PIXMAP is
		do
			Result := Pixmaps.paint_pixmap
		end

	internal_name: STRING is
		do
			Result := Event_const.paint_label
		end

	eiffel_text: STRING is "add_paint_command ("

end -- class PAINT_EV

