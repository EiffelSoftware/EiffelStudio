note
	description: "Summary description for {CONSOLE_WIZARD_INPUT_FIELD}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CONSOLE_WIZARD_INPUT_FIELD

inherit
	WIZARD_INPUT_FIELD

	WIZARD_PAGE_ITEM

feature -- Access

	item_id: detachable READABLE_STRING_8
			-- Optional id to identify related page item.
		do
			Result := id
		end

feature -- Conversion

	data: detachable ANY

feature -- Element change

	set_data (d: like data)
		do
			data := d
		end

end
