indexing
	description: "Tree item subtree event."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SUBTREE_EV

inherit
	EVENT

creation
	make

feature -- Access

	identifier: INTEGER is
		do
			Result := - Event_const.subtree_ev_id
		end

	symbol: EV_PIXMAP is
		do
			Result := Pixmaps.subtree_pixmap
		end

	internal_name: STRING is
		do
			Result := Event_const.subtree_label
		end

	eiffel_text: STRING is "add_subtree_command ("

end -- class SUBTREE_EV

