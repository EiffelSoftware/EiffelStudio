note
	description: "Summary description for {GRAPHICAL_WIZARD_PAGE_WIDGET}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GRAPHICAL_WIZARD_PAGE_WIDGET

inherit
	GRAPHICAL_WIZARD_PAGE_ITEM

create
	make_with_widget

feature {NONE} -- Initialization

	make_with_widget (w: like widget)
		do
			widget := w
		end

feature -- Access

	item_id: detachable READABLE_STRING_8
			-- Optional id to identify related page item.

feature -- Element change

	set_item_id (a_id: like item_id)
			-- Set `item_id' to `a_id'.
		do
			item_id := a_id
		end

feature -- Conversion

	widget: EV_WIDGET

end
