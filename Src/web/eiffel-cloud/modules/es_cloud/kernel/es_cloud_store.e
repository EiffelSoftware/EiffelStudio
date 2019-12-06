note
	description: "Summary description for {ES_CLOUD_STORE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_STORE

create
	make

feature {NONE} -- Initialization

	make
		do
			create items.make_caseless (3)
		end

feature -- Access

	item (a_id: READABLE_STRING_GENERAL): detachable ES_CLOUD_STORE_ITEM
		do
			Result := items.item (a_id)
		end

	items: STRING_TABLE [ES_CLOUD_STORE_ITEM]

feature -- Element change

	extend (a_item: ES_CLOUD_STORE_ITEM)
		do
			items.force (a_item, a_item.id)
		end


end
