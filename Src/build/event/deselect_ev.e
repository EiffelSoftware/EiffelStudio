indexing
	description: "Item deselect event."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DESELECT_EV

inherit
	EVENT

creation
	make


feature -- Access

	identifier: INTEGER is
		do
			Result := - Event_const.deselect_ev_id
		end

	symbol: EV_PIXMAP is
		do
			Result := Pixmaps.deselect_pixmap
		end

	internal_name: STRING is
		do
			Result := Event_const.deselect_label
		end

	eiffel_text: STRING is "add_desactivate_command ("

end -- class DESELECT_EV

