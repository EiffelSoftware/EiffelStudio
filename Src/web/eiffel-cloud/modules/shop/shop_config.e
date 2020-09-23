note
	description: "Summary description for {SHOP_CONFIG}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SHOP_CONFIG

create
	make

feature {NONE} -- Initialization

	make (a_shop_name: READABLE_STRING_32)
		do
			shop_name := a_shop_name
			set_base_location (default_base_location)
			cookie_name := "roc-shop"
			shop_id := "shop"
			default_currency := "usd"
		end

feature -- Access

	base_path: IMMUTABLE_STRING_8

	base_location: IMMUTABLE_STRING_8

	shop_id: IMMUTABLE_STRING_8

	shop_name: IMMUTABLE_STRING_32

	cookie_name: IMMUTABLE_STRING_8

	default_base_path: STRING = "/shop"

	default_base_location: STRING = "shop"

	default_currency: IMMUTABLE_STRING_8

	is_valid: BOOLEAN
		do
			Result := True
		end

feature -- Element change

	set_base_location (p: READABLE_STRING_8)
		do
			base_location := p
			base_path := "/" + p
		end

	set_base_path (p: READABLE_STRING_8)
		require
			p.starts_with_general ("/")
		do
			base_path := p
			base_location := p.substring (2, p.count)
		end

	set_shop_id (a_id: READABLE_STRING_8)
		do
			shop_id := a_id
		end

	set_shop_name (a_name: READABLE_STRING_GENERAL)
		do
			create shop_name.make_from_string_general (a_name)
		end

	set_cookie_name (n: READABLE_STRING_8)
		do
			cookie_name := n
		end

	set_default_currency (v: READABLE_STRING_8)
		do
			default_currency := v
		end

end
