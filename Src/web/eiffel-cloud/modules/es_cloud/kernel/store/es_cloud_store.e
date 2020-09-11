note
	description: "Summary description for {ES_CLOUD_STORE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_STORE

create
	make,
	make_with_currency

feature {NONE} -- Initialization

	make
		do
			make_with_currency (default_currency)
		end

	make_with_currency (a_curr: READABLE_STRING_8)
		do
			currency := a_curr.as_lower
			create items.make_caseless (3)
		end

feature -- Defaults

	default_currency: STRING_8 = "usd"

feature -- Access

	currency: IMMUTABLE_STRING_8

	item (a_id: READABLE_STRING_GENERAL): detachable ES_CLOUD_STORE_ITEM
		do
			Result := items.item (a_id)
		end

	items: STRING_TABLE [ES_CLOUD_STORE_ITEM]

feature -- Element change

	extend (a_item: ES_CLOUD_STORE_ITEM)
		require
			currency.is_case_insensitive_equal_general (a_item.currency)
		do
			items.force (a_item, a_item.id)
		end


end
