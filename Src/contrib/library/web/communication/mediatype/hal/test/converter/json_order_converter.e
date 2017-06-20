note
	description: "Summary description for {JSON_ORDER_CONVERTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_ORDER_CONVERTER

inherit
	JSON_SERIALIZER
	JSON_DESERIALIZER

feature -- Conversion

	from_json (a_json: detachable JSON_VALUE; ctx: JSON_DESERIALIZER_CONTEXT; a_type: detachable TYPE [detachable ANY]): detachable ORDER
		local
			l_id: INTEGER
			l_currency: detachable STRING
			l_status: detachable STRING
			l_placed: detachable STRING
			l_customer: detachable CUSTOMER
			l_line_items: detachable LINE_ITEM
		do
			if attached {JSON_OBJECT} a_json as j then
				if attached {JSON_NUMBER} j.item (id_key) as l_ucs then
					l_id := l_ucs.integer_64_item.to_integer_32
				end
				if attached {JSON_STRING} j.item (currency_key) as l_ucs then
					l_currency := l_ucs.unescaped_string_32
				end
				if attached {JSON_STRING} j.item (status_key) as l_ucs then
					l_status := l_ucs.unescaped_string_32
				end
				if attached {JSON_STRING} j.item (placed_key) as l_ucs then
					l_placed := l_ucs.unescaped_string_32
				end
				if attached {CUSTOMER} ctx.value_from_json (j.item (customer_key), {CUSTOMER}) as c then
					l_customer := c
				end
				if attached {LINE_ITEM} ctx.value_from_json (j.item (line_items_key), {LINE_ITEM}) as li then
					l_line_items := li
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
		end

	to_json (obj: detachable ANY; ctx: JSON_SERIALIZER_CONTEXT): JSON_VALUE
		local
			jo: JSON_OBJECT
		do
			if attached {ORDER} obj as o then
				create jo.make
				jo.put_integer (o.id, id_key)
				jo.put_string (o.currency, currency_key)
				jo.put_string (o.status, status_key)
				jo.put_string (o.placed, placed_key)
				jo.put (ctx.to_json (o.customer, create {JSON_CUSTOMER_CONVERTER}), customer_key)
				jo.put (ctx.to_json (o.line_items, create {JSON_LINE_ITEM_CONVERTER}), line_items_key)
				Result := jo
			else
				create {JSON_NULL} Result
			end
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
			create Result.make_from_string ("customer")
		end

	line_items_key: JSON_STRING
		once
			create Result.make_from_string ("line_items")
		end

end
