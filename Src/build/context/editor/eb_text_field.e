indexing
	description: "Smart text field (with a label before)."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class EB_TEXT_FIELD

inherit
	EV_TEXT_FIELD

creation
	make_with_label

feature {NONE} -- Initialization

	make_with_label (par: EV_BOX; txt: STRING) is
			-- Create the text field with the text `txt' before.
		local
			hbox: EV_HORIZONTAL_BOX
		do
			create hbox.make (par)
			par.set_child_expandable (hbox, False)
			create label.make_with_text (hbox, txt)
			hbox.set_child_expandable (label, False)
			make (hbox)
		end

feature -- Access

	label: EV_LABEL
			-- Label of the text field

	set_label (txt: STRING) is
			-- Set the text of the `label'.
		do
			label.set_text (txt)
		end

end -- class EB_TEXT_FIELD

