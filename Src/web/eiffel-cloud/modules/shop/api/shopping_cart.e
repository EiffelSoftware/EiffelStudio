note
	description: "Summary description for {SHOP_BASKET}."
	date: "$Date$"
	revision: "$Revision$"

class
	SHOPPING_CART

create
	make,
	make_guest,
	make_with_id,
	make_from_json

feature {NONE} -- Initialization

	make_guest (a_name: READABLE_STRING_8)
		do
			make (create {CMS_USER}.make ("Guest"), a_name)
			is_guest := True
		end

	make (a_user: like owner; a_name: READABLE_STRING_8)
		do
			currency := "usd"
			owner := a_user
			email := a_user.email
			create items.make (1)
			identifier := a_name
		end

	make_with_id (a_id: like id; a_user: like owner; a_name: READABLE_STRING_8)
		do
			id := a_id
			make (a_user, a_name)
		end

	make_from_json (a_json: READABLE_STRING_8)
		do
			make (create {CMS_PARTIAL_USER}.make_with_id (0), "undefined")
			import_json_string (a_json)
		end

feature -- Access

	id: INTEGER_64

	identifier: READABLE_STRING_8
			-- Shopping cart identifier (key)

	is_guest: BOOLEAN

	owner: CMS_USER assign set_owner

	email: detachable READABLE_STRING_8

	security: detachable IMMUTABLE_STRING_32

	items: ARRAYED_LIST [SHOPPING_ITEM]

	modification_date: detachable DATE_TIME

	data: detachable READABLE_STRING_8 assign set_data

	currency: IMMUTABLE_STRING_8

	default_currency: STRING_8 = "usd"

feature -- Status report

	has_details: BOOLEAN
		do
			across
				items as ic
			until
				Result
			loop
				if ic.item.has_details then
					Result := True
				end
			end
		end

feature -- Query

	is_identified_by (v: READABLE_STRING_GENERAL): BOOLEAN
		do
			if v.is_case_insensitive_equal (identifier) then
					-- Same shopping cart name
				Result := True
			elseif v.is_integer_64 and then v.to_integer_64 = id then
					-- Same shopping cart id
				Result := True
			else
				Result := False
			end
		end

	count: NATURAL_32
		do
			across
				items as ic
			loop
				Result := Result + ic.item.quantity
			end
		end

	is_onetime: BOOLEAN
		do
			Result := not is_empty
			across
				items as ic
			loop
				Result := Result and ic.item.is_onetime
			end
		end

	is_yearly: BOOLEAN
		do
			Result := not is_empty
			across
				items as ic
			loop
				Result := Result and ic.item.is_yearly
			end
		end

	is_monthly: BOOLEAN
		do
			Result := not is_empty
			across
				items as ic
			loop
				Result := Result and ic.item.is_monthly
			end
		end

	is_weekly: BOOLEAN
		do
			Result := not is_empty
			across
				items as ic
			loop
				Result := Result and ic.item.is_weekly
			end
		end

	is_daily: BOOLEAN
		do
			Result := not is_empty
			across
				items as ic
			loop
				Result := Result and ic.item.is_daily
			end
		end

	cart_title (a_dft: detachable READABLE_STRING_GENERAL): STRING_32
		local
			l_item: SHOPPING_ITEM
			l_has_conflict: BOOLEAN
			v: READABLE_STRING_32
		do
			create Result.make_empty
			across
				items as ic
			until
				l_has_conflict
			loop
				l_item := ic.item
				v := l_item.title
				if v = Void then
					v := l_item.code
				end
				if not Result.is_empty and then not v.is_case_insensitive_equal_general (Result) then
					Result.append (", ")
					l_has_conflict := True
				end
				Result.append (v)
			end
			if (Result.is_empty or l_has_conflict) and a_dft /= Void then
				create Result.make_from_string_general (a_dft)
			end
		end

	cart_name (a_dft: detachable READABLE_STRING_GENERAL): STRING_32
		local
			l_item: SHOPPING_ITEM
			l_has_conflict: BOOLEAN
			v: STRING_32
		do
			create Result.make_empty
			across
				items as ic
			until
				l_has_conflict
			loop
				l_item := ic.item
				v := l_item.code
				if not Result.is_empty and then not v.is_case_insensitive_equal_general (Result) then
					Result.append (", ")
					l_has_conflict := True
				end
				Result.append (v)
			end
			if (Result.is_empty or l_has_conflict) and a_dft /= Void then
				create Result.make_from_string_general (a_dft)
			end
		end

	provider_name (a_dft: READABLE_STRING_GENERAL): IMMUTABLE_STRING_32
		local
			l_item: SHOPPING_ITEM
			l_has_conflict: BOOLEAN
		do
			across
				items as ic
			until
				l_has_conflict
			loop
				l_item := ic.item
				if Result /= Void and then not l_item.provider.is_case_insensitive_equal_general (Result) then
					Result := Void
					l_has_conflict := True
				else
					Result := l_item.provider
				end
			end
			if Result = Void or l_has_conflict then
				create Result.make_from_string_general (a_dft)
			end
		end

	price_in_cents: NATURAL_32
		local
			l_item: SHOPPING_ITEM
			l_cart_currency: READABLE_STRING_8
		do
			l_cart_currency := currency
			across
				items as ic
			loop
				l_item := ic.item
				if attached l_item.details as l_details then
					if l_details.currency.is_case_insensitive_equal_general (l_cart_currency) then
						Result := Result + l_item.quantity * l_details.price_in_cents
					else
						check same_currency: False end
					end
				else
					check has_details: False end
				end
			end
		end

	currency_sign: detachable CHARACTER_32
		do
			Result := {SHOPPING_CURRENCY_HELPER}.iso_currency_as_sign (currency)
		end

	price_as_string: STRING_32
			-- Price as string, using currency symbol when possible.
		do
			Result := {SHOPPING_CURRENCY_HELPER}.price_in_cents_as_string (price_in_cents, currency)
		end

	price_as_iso_string: STRING_8
				-- Price as string, using ISO currency text.
		local
			l_total: NATURAL_32
			p,c: NATURAL_32
		do
			l_total := price_in_cents
			p := l_total // 100
			c := l_total \\ 100
			create Result.make (10)
			Result.append_natural_32 (p)
			if c > 0 then
				Result.append_character ('.')
				if c <= 9 then
					Result.append_integer (0)
				end
				Result.append_natural_32 (c)
			end
			Result.append_character (' ')
			Result.append_string (currency)
		end

	item (a_code, a_provider: READABLE_STRING_GENERAL): detachable SHOPPING_ITEM
		local
			i: detachable SHOPPING_ITEM
		do
			create i.make (a_code, a_provider)
			across
				items as ic
			until
				Result /= Void
			loop
				if i.same_item (ic.item) then
					Result := ic.item
				end
			end
		end

feature -- Status report

	has_id: BOOLEAN
		do
			Result := id > 0
		end

	is_empty: BOOLEAN
		do
			Result := items.is_empty or else across items as ic all ic.item.quantity = 0 end
		end

feature -- Validation

	is_currency_accepted (a_currency: READABLE_STRING_8): BOOLEAN
		do
			if attached currency as l_cart_currency then
				Result := a_currency.is_case_insensitive_equal (l_cart_currency)
			else
				Result := True
			end
		end

	is_item_compatible (a_item: SHOPPING_ITEM): BOOLEAN
		require
			has_details: a_item.has_details
		local
			l_interval_type: NATURAL_8
			nb: NATURAL_8
		do
			if count = 0 then
				Result := True
			elseif attached a_item.details as l_details then
				l_interval_type := l_details.interval_type
				nb := l_details.interval_count
				Result := True
				across
					items as ic
				until
					not Result
				loop
					if attached ic.item.details as d then
						Result := d.interval_type = l_interval_type and then d.interval_count = nb
					else
						Result := False
					end
				end
			end
		end

	has_incomplete_item: BOOLEAN
		do
			across
				items as ic
			until
				Result
			loop
				Result := ic.item.details = Void
			end
		end

	remove_incomplete_items
		require
			has_incomplete_item
		do
			from
				items.start
			until
				items.after
			loop
				if items.item.details = Void then
					items.remove
				else
					items.forth
				end
			end
		ensure
			not has_incomplete_item
		end

feature -- Conversion

	import_json_string (a_json: READABLE_STRING_8)
		local
			jp: JSON_PARSER
			htdate: HTTP_DATE
		do
			create jp.make_with_string (a_json)
			jp.parse_content
			if jp.is_parsed and then jp.is_valid and then attached jp.parsed_json_object as jo then
				if attached jo.number_item ("id") as j_id then
					id := j_id.integer_64_item
				end
				if attached jo.string_item ("name") as j_name then
					identifier := j_name.unescaped_string_8
				end
				if attached jo.number_item ("uid") as j_uid then
					create {CMS_PARTIAL_USER} owner.make_with_id (j_uid.integer_64_item)
				end
				if attached jo.string_item ("email") as j_email then
					set_email (j_email.unescaped_string_8)
				end
				if attached jo.boolean_item ("is_guest") as j_guest then
					is_guest := j_guest.item
				end

				if attached jo.string_item ("currency") as j_currency then
					currency := j_currency.unescaped_string_8
				end
				if attached jo.number_item ("changed_timestamp") as j_timestamp then
					create htdate.make_from_timestamp (j_timestamp.integer_64_item)
					modification_date := htdate.date_time
				end
				if attached jo.string_item ("items") as j_items then
					set_items_from_json_string (j_items.unescaped_string_8)
				end
				if attached jo.string_item ("data") as j_data then
					data := j_data.unescaped_string_8
				end
				if attached jo.string_item ("security") as j_security then
					security := j_security.unescaped_string_32
				end

			end
		end

	to_json_string: STRING
		local
			jo: JSON_OBJECT
			vis: JSON_SERIALIZATION_VISITOR
			htdate: HTTP_DATE
		do
			create jo.make_with_capacity (10)
			jo.put_integer (id, "id")
			if attached identifier as n then
				jo.put_string (n, "name")
			end
			jo.put_integer (owner.id, "uid")
			if attached email as e then
				jo.put_string (e, "email")
			end
			if is_guest then
				jo.put_boolean (True, "is_guest")
			end
			jo.put_string (currency, "currency")

			if attached modification_date as dt then
				create htdate.make_from_date_time (dt)
				jo.put_integer (htdate.timestamp, "changed_timestamp")
			end
			jo.put_string (items_to_json_string, "items")
			if attached data as l_data then
				jo.put_string (l_data, "data")
			end
			if attached security as l_security then
				jo.put_string (l_security, "security")
			end
			create Result.make (512)
			create vis.make (Result)
			jo.accept (vis)
		end

	items_to_json_string: STRING
		local
			j: JSON_ARRAY
			jo, jd: JSON_OBJECT
			vis: JSON_SERIALIZATION_VISITOR
		do
			create j.make_empty
			across
				items as ic
			loop
				if attached ic.item as l_shopping_item then
					create jo.make_with_capacity (4)
					jo.put_string (l_shopping_item.code, "code")
					jo.put_string (l_shopping_item.provider, "provider")
					jo.put_natural (l_shopping_item.quantity, "quantity")
					if attached l_shopping_item.details as d then
						create jd.make_with_capacity (5)
						jd.put_natural (d.price_in_cents, "price_in_cents")
						jd.put_string (d.currency, "currency")
						inspect
							d.interval_type
						when {SHOPPING_ITEM_DETAILS}.interval_type_daily then
							jd.put_string ("day", "interval")
						when {SHOPPING_ITEM_DETAILS}.interval_type_weekly then
							jd.put_string ("week", "interval")
						when {SHOPPING_ITEM_DETAILS}.interval_type_monthly then
							jd.put_string ("month", "interval")
						when {SHOPPING_ITEM_DETAILS}.interval_type_yearly then
							jd.put_string ("year", "interval")
						else
							-- onetime (default)
						end
						if d.interval_count /= 1 then
							jd.put_natural (d.interval_count, "interval_count")
						end
						jo.put (jd, "details")
					end
					if attached l_shopping_item.data as l_data then
						jo.put_string (l_data, "data")
					end
					j.add (jo)
				end
			end
			create Result.make (512)
			create vis.make (Result)
			j.accept (vis)
		end

	set_items_from_json_string (s: detachable READABLE_STRING_8)
		local
			jp: JSON_PARSER
			l_code, l_provider: READABLE_STRING_GENERAL
			l_item: SHOPPING_ITEM
			l_item_details: SHOPPING_ITEM_DETAILS
			l_currency: READABLE_STRING_8
			i: NATURAL_8
		do
			if s = Void then
				items.wipe_out
			else
				create jp.make_with_string (s)
				jp.parse_content
				if
					jp.is_parsed and then jp.is_valid and then
					attached jp.parsed_json_array as j_array
				then
					across
						j_array as ic
					loop
						if attached {JSON_OBJECT} ic.item as j then
							if
								attached j.string_item ("code") as j_code and then
								attached j.string_item ("provider") as j_provider
							then
								l_code := j_code.unescaped_string_32
								l_provider := j_provider.unescaped_string_32
								if
									l_code /= Void and then not l_code.is_whitespace and then
									l_provider /= Void and then not l_provider.is_whitespace
								then
									create l_item.make (l_code, l_provider)
									if attached j.number_item ("quantity") as j_qu then
										l_item.quantity := j_qu.natural_64_item.to_natural_32
									end
									if attached j.object_item ("details") as j_details then
										create l_item_details
										if attached j_details.string_item ("currency") as j_currency then
											l_currency := j_currency.unescaped_string_8
										end

										if attached j_details.number_item ("price_in_cents") as j_price_in_cents then
											l_item_details.set_price_in_cents (j_price_in_cents.natural_64_item.to_natural_32, l_item_details.currency)
										end
										if attached j_details.number_item ("interval_count") as j_interval_count then
											i := j_interval_count.natural_64_item.to_natural_8
										else
											i := 1
										end
										if attached j_details.string_item ("interval") as j_interval then
											if j_interval.same_caseless_string ("day") then
												l_item_details.set_daily (i)
											elseif j_interval.same_caseless_string ("week") then
												l_item_details.set_weekly (i)
											elseif j_interval.same_caseless_string ("month") then
												l_item_details.set_monthly (i)
											elseif j_interval.same_caseless_string ("year") then
												l_item_details.set_yearly (i)
											else
												l_item_details.set_onetime
											end
										end
									end
									if attached j.string_item ("data") as j_data then
										l_item.data := j_data.unescaped_string_8
									end
									add_item (l_item)
								end
							end
						end
					end
				end
			end
		end

feature -- Element change

	set_identifier (v: READABLE_STRING_8)
		do
			identifier := v
		end

	add_item (a_item: SHOPPING_ITEM)
		local
			l_existing_item: detachable SHOPPING_ITEM
		do
			across
				items as ic
			until
				l_existing_item /= Void
			loop
				if a_item.same_item (ic.item) then
					ic.item.increment_quantity (a_item.quantity)
					l_existing_item := ic.item
				end
			end
			if l_existing_item = Void then
				items.force (a_item)
			end
		end

	remove_item (a_item: SHOPPING_ITEM)
		local
			i: detachable SHOPPING_ITEM
		do
			from
				items.start
			until
				items.after
			loop
				i := items.item
				if i.same_item (a_item) then
					items.remove
				else
					items.forth
				end
			end
		end

	set_owner (u: like owner)
		do
			owner := u
			if u.has_email then
				set_email (u.email)
			end
			is_guest := not u.has_id
		end

	set_email (e: detachable READABLE_STRING_8)
		do
			email := e
		end

	set_security (v: detachable READABLE_STRING_GENERAL)
		do
			if v = Void then
				security := Void
			else
				create security.make_from_string_general (v)
			end
		end

	set_currency (v: detachable READABLE_STRING_8)
		do
			if v = Void then
				currency := default_currency
			else
				currency := v
			end
		end

	set_modification_date (dt: like modification_date)
		do
			modification_date := dt
		end

	set_data (v: like data)
		do
			data := v
		end

feature {CMS_STORAGE_SQL_I} -- Element change

	update_id (a_id: like id)
		do
			id := a_id
		end

end
