note
	description: "API to handle Shop paymnent."
	date: "$Date$"
	revision: "$Revision$"

class
	SHOP_API

inherit
	CMS_MODULE_API
		rename
			make as make_api
		redefine
			initialize
		end

	REFACTORING_HELPER

create
	make

feature {NONE} -- Initialization

	make (a_api: CMS_API; a_config: SHOP_CONFIG)
		do
			config := a_config
			make_api (a_api)
			initialize
		end

	initialize
			-- <Precursor>
		do
			Precursor
				-- Storage initialization
			if attached cms_api.storage.as_sql_storage as l_storage_sql then
				create {SHOP_STORAGE_SQL} shop_storage.make (l_storage_sql)
			else
					-- FIXME: in case of NULL storage, should Current be disabled?
				create {SHOP_STORAGE_NULL} shop_storage
			end
		end

feature -- Access

	config: SHOP_CONFIG

feature {CMS_MODULE} -- Access shop storage.

	shop_storage: SHOP_STORAGE_I

feature -- Access

	active_shopping_cart (req: WSF_REQUEST): detachable SHOPPING_CART
		local
			s: STRING_32
			i: INTEGER

		do
			if attached cms_api.user as u then
				Result := user_shopping_cart (u)
			elseif attached {WSF_STRING} req.cookie (config.cookie_name) as p_cookie then
				s := p_cookie.value
				i := s.substring_index ("guest_shop_cid=", 1)
				if i = 1 then
					i := s.index_of ('=', i)
					if i > 0 then
						s.remove_head (i)
						i := s.index_of (';', 1)
						if i > 0 then
							s.keep_head (i - 1)
						end
					end
				end
				if s.is_integer_64 then
					Result := guest_shopping_cart (s.to_integer_64)
				end
--				create Result.make_guest
--				Result.set_items_from_json_string (utf_8_encoded (p_cookie.value))
			end
			if Result /= Void then
				Result.set_currency (config.default_currency)
				invoke_shop_fill_cart (Result)
				if Result.has_incomplete_item then
					Result.remove_incomplete_items
					if Result.is_guest then
						save_guest_shopping_cart (Result)
					else
						save_user_shopping_cart (Result)
					end
				end
			end
		end

	user_shopping_cart (a_user: CMS_USER): detachable SHOPPING_CART
		do
			Result := shop_storage.user_shopping_cart (a_user)
		end

	guest_shopping_cart (a_cart_id: like {SHOPPING_CART}.id): detachable SHOPPING_CART
		do
			Result := shop_storage.shopping_cart_by_id (a_cart_id)
		end

	clear_shopping_cart (a_cart: SHOPPING_CART)
		do
			a_cart.items.wipe_out
			if a_cart.is_guest then
				save_guest_shopping_cart (a_cart)
			else
				save_user_shopping_cart (a_cart)
			end
		end

	save_user_shopping_cart (a_cart: SHOPPING_CART)
		require
			not a_cart.is_guest
		do
			shop_storage.save_shopping_cart (a_cart)
		end

	save_guest_shopping_cart (a_cart: SHOPPING_CART)
		require
			a_cart.is_guest
		do
			shop_storage.save_shopping_cart (a_cart)
		end

	cart_to_order (a_cart: SHOPPING_CART): READABLE_STRING_GENERAL
		require
			not a_cart.is_guest
		do
			Result := cms_api.new_random_identifier (10, Void)
			shop_storage.cart_to_order (a_cart, Result)
		end

	order (a_order_id: READABLE_STRING_GENERAL): detachable SHOPPING_CART
		do
			Result := shop_storage.cart_from_order (a_order_id)
		end

feature -- Hook invokation		

	invoke_shop_fill_cart (a_cart: SHOPPING_CART)
		do
			if attached cms_api.hooks.subscribers ({SHOP_HOOK}) as lst then
				across
					lst as ic
				loop
					if attached {SHOP_HOOK} ic.item as h then
						h.fill_cart (a_cart)
					end
				end
			end
		end

	invoke_commit_cart (a_cart: SHOPPING_CART)
		do
			if attached cms_api.hooks.subscribers ({SHOP_HOOK}) as lst then
				across
					lst as ic
				loop
					if attached {SHOP_HOOK} ic.item as h then
						h.commit_cart (a_cart)
					end
				end
			end
		end

note
	copyright: "2011-2019, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

