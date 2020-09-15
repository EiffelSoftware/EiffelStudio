note
	description: "Summary description for {STRIPE_PAYMENT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STRIPE_PAYMENT

create
	make

feature {NONE} -- Initialization

	make (a_category: READABLE_STRING_GENERAL; a_checkout: READABLE_STRING_GENERAL)
		do
			create category.make_from_string_general (a_category)
			create checkout_id.make_from_string_general (a_checkout)
		end

feature -- Status

	is_prepared: BOOLEAN

	mark_prepared
		do
			is_prepared := True
		end

	is_empty: BOOLEAN
		local
			q: NATURAL_32
		do
			Result := True
			if attached items as lst then
				if not lst.is_empty then
					q := 0
					across
						lst as ic
					loop
						q := q + ic.item.quantity
					end
					Result := q = 0
				end
			end
		end

feature -- Access

	category: IMMUTABLE_STRING_32

	checkout_id: IMMUTABLE_STRING_32

	items: detachable ARRAYED_LIST [STRIPE_PAYMENT_ITEM]

	items_as_json_string: detachable STRING
		local
			arr: JSON_ARRAY
			obj: JSON_OBJECT
			l_printer: JSON_SERIALIZATION_VISITOR
		do
			if attached items as l_items and then not l_items.is_empty then
				create arr.make (l_items.count)
				across
					l_items as ic
				loop
					create obj.make_with_capacity (2)
					obj.put_string (ic.item.identifier, "identifier")
					if ic.item.quantity /= 1 then
						obj.put_natural (ic.item.quantity, "quantity")
					end
					arr.add (obj)
				end
				create Result.make (128)
				create l_printer.make (Result)
				l_printer.visit_json_array (arr)
			end
		end

	price_in_cents: NATURAL_32

	price_text: STRING
		local
			i: NATURAL_32
		do
			create Result.make_empty
			if currency.is_case_insensitive_equal_general ("usd") then
				Result.extend ('$')
			end
			i := price_in_cents // 100
			Result.append (i.out)
			i := price_in_cents \\ 100
			if i /= 0 then
				Result.extend ('.')
				if i < 10 then
					Result.extend ('0')
				end
				Result.append (i.out)
			end
			if not currency.is_case_insensitive_equal_general ("usd") then
				Result.extend (' ')
				Result.append (currency.as_upper)
			end
		end

	currency: IMMUTABLE_STRING_8
		do
			Result := internal_currency
			if Result = Void then
				Result := default_currency
			end
		end

	default_currency: IMMUTABLE_STRING_8
		once
			Result := "usd"
		end

feature -- Access: optional

	order_id: detachable IMMUTABLE_STRING_32
			-- To identify associated order.
		do
			if
				attached meta_data as md and then
				attached md ["order.id"] as l_order_id
			then
				create Result.make_from_string_general (l_order_id)
			end
		end

	business_name: detachable IMMUTABLE_STRING_32

	title: detachable IMMUTABLE_STRING_32
			-- Human title representing the content of the payment.
			-- (product name, ...)

	code: detachable IMMUTABLE_STRING_32
			-- Code representing the content of the payment.
			-- (product code, ...)	

	customer_name: detachable IMMUTABLE_STRING_32

	customer_email: detachable IMMUTABLE_STRING_8

	customer_user: detachable CMS_USER

	meta_data: detachable STRING_TABLE [READABLE_STRING_GENERAL]

	meta_data_as_json_string: detachable STRING
		local
			obj: JSON_OBJECT
			l_printer: JSON_SERIALIZATION_VISITOR
		do
			if attached meta_data as md and then not md.is_empty then
				create obj.make_with_capacity (md.count)
				across
					md as ic
				loop
					obj.put_string (ic.item, ic.key)
				end
				create Result.make (128)
				create l_printer.make (Result)
				l_printer.visit_json_object (obj)
			end
		end

feature -- Access: default

	title_or_code: IMMUTABLE_STRING_32
		do
			if attached title as t then
				Result := t
			else
				Result := code_or_checkout_id
			end
		end

	code_or_checkout_id: IMMUTABLE_STRING_32
		do
			if attached code as l_code then
				Result := l_code
			else
				Result := checkout_id
			end
		end

feature -- Access: internal

	internal_currency: detachable IMMUTABLE_STRING_8

feature -- Element change

	add_item (a_item: STRIPE_PAYMENT_ITEM)
		local
			lst: like items
		do
			lst := items
			if lst = Void then
				create lst.make (1)
				items := lst
			end
			lst.force (a_item)
		end

	set_meta_data (a_value: detachable READABLE_STRING_GENERAL; a_key: READABLE_STRING_GENERAL)
		local
			md: like meta_data
		do
			md := meta_data
			if md = Void then
				create md.make (1)
				meta_data := md
			end
			if a_value = Void then
				if md.has_key (a_key) then
					md.remove (a_key)
				end
			else
				md[a_key] := a_value
			end
		end

	set_order_id (v: READABLE_STRING_GENERAL)
		do
			set_meta_data (v, "order.id")
		end

	set_price (a_price_in_cents: NATURAL_32; a_currency: READABLE_STRING_8)
		do
			price_in_cents := a_price_in_cents
			create internal_currency.make_from_string (a_currency)
		end

	set_title (a_title: READABLE_STRING_GENERAL)
		do
			create title.make_from_string_general (a_title)
		end

	set_code (a_code: READABLE_STRING_GENERAL)
		do
			create code.make_from_string_general (a_code)
		end

	set_business_name (a_name: READABLE_STRING_GENERAL)
		do
			create business_name.make_from_string_general (a_name)
		end

	set_customer_name (a_name: READABLE_STRING_GENERAL)
		do
			create customer_name.make_from_string_general (a_name)
		end

	set_customer_email (v: detachable READABLE_STRING_8)
		do
			if v = Void then
				customer_email := Void
			else
				customer_email := v
			end
		end

end
