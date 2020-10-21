note
	description: "Summary description for {GRAPHICAL_WIZARD_INPUT_FIELD}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GRAPHICAL_WIZARD_INPUT_FIELD

inherit
	WIZARD_INPUT_FIELD

	GRAPHICAL_WIZARD_STYLER

	GRAPHICAL_WIZARD_PAGE_ITEM

feature -- Access

	item_id: detachable READABLE_STRING_8
			-- Optional id to identify related page item.
		do
			Result := id
		end

feature -- Conversion

	data: detachable ANY
		do
			Result := widget.data
		end

feature -- Element change

	set_data (d: like data)
		do
			widget.set_data (d)
		end

feature {NONE} -- Implementation

	append_cell_to (a_size: INTEGER; a_container: EV_BOX)
		local
			cl: EV_CELL
		do
			create cl
			if attached {EV_HORIZONTAL_BOX} a_container then
				cl.set_minimum_width (a_size)
			else
				cl.set_minimum_height (a_size)
			end
			a_container.extend (cl)
			a_container.disable_item_expand (cl)
		end

end
