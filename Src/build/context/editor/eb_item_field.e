indexing
	description: "Smart item field (with a label before).%
				% List with only one item, looking like a text field."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_ITEM_FIELD

inherit
	EV_LIST

creation
	make_with_label

feature -- Initialization

	make_with_label (par: EV_BOX; txt: STRING) is
			-- Create the item field with the text `txt' before.

		local
			hbox: EV_HORIZONTAL_BOX
		do
			create hbox.make (par)
			hbox.set_minimum_height (23) --XX size of one item
			par.set_child_expandable (hbox, False)
			create label.make_with_text (hbox, txt)
			hbox.set_child_expandable (label, False)
			make (hbox)
		end

feature -- Access

	label: EV_LABEL
			-- Label of the item field

	set_label (txt: STRING) is
			-- Set the text of the `label'.
		do
			label.set_text (txt)
		end

end -- class EB_ITEM_FIELD

