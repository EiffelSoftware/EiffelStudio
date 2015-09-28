note
	description: "Summary description for {JSON_ORDER_CONVERTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_ORDER_CONVERTER

inherit
	JSON_CONVERTER

create
	make

feature {NONE} -- Initialization

	make
		local
			l_c: CUSTOMER
		do
			create l_c.make ("", "")
			create object.make ("", "", "", l_c)
		end

feature -- Access

	object: ORDER

feature -- Conversion

	from_json (j: like to_json): detachable like object
		local
			l_id: INTEGER
			l_currency: detachable STRING
			l_status: detachable STRING
			l_placed: detachable STRING
			l_customer: detachable CUSTOMER
			l_line_items: detachable LINE_ITEM
		do
			if attached {INTEGER} json.object (j.item (id_key), Void) as l_ucs then
				l_id := l_ucs
			end
			if attached {STRING_32} json.object (j.item (currency_key), Void) as l_ucs then
				l_currency := l_ucs
			end
			if attached {STRING_32} json.object (j.item (status_key), Void) as l_ucs then
				l_status := l_ucs
			end
			if attached {STRING_32} json.object (j.item (placed_key), Void) as l_ucs then
				l_placed := l_ucs
			end
			if attached {CUSTOMER} json.object (j.item (customer_key), "CUSTOMER") as l_ucs then
				l_customer := l_ucs
			end
			if attached {LINE_ITEM} json.object (j.item (line_items_key), "LINE_ITEM") as l_ucs then
				l_line_items := l_ucs
			end
			check
				l_id > 0
			end
			check
				l_currency /= Void and l_status /= Void and	l_customer /= Void and l_line_items /= Void and	l_placed /= Void
			then
				create Result.make (l_line_items.name, l_currency, l_status, l_customer)
				Result.set_placed (l_placed)
			end
		end

	to_json (o: like object): JSON_OBJECT
		do
			create Result.make
			Result.put (json.value (o.id), id_key)
			Result.put (json.value (o.currency), currency_key)
			Result.put (json.value (o.placed), placed_key)
			Result.put (json.value (o.status), status_key)
			Result.put (json.value (o.customer), customer_key)
			Result.put (json.value (o.line_items), line_items_key)
		end

feature {NONE} -- Implementation

	id_key: JSON_STRING
		once
			create Result.make_from_string ("id")
		end

	name_key: JSON_STRING
		once
			create Result.make_from_string ("name")
		end

	currency_key: JSON_STRING
		once
			create Result.make_from_string ("currency")
		end

	status_key: JSON_STRING
		once
			create Result.make_from_string ("status")
		end

	placed_key: JSON_STRING
		once
			create Result.make_from_string ("placed")
		end

	customer_key: JSON_STRING
		once
			create Result.make_json ("customer")
		end

	line_items_key: JSON_STRING
		once
			create Result.make_json ("line_items")
		end

end
