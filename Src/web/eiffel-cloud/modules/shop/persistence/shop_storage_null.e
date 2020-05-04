note
	description: "Interface for accessing shop storage"
	date: "$Date$"
	revision: "$Revision$"

class
	SHOP_STORAGE_NULL

inherit
	SHOP_STORAGE_I

feature -- Error handler

	error_handler: ERROR_HANDLER
			-- Error handler.
		do
			create Result.make
		end

feature -- Store

	user_shopping_cart (a_user: CMS_USER): detachable SHOPPING_CART
		do
		end

	shopping_cart_by_id (a_cart_id: like {SHOPPING_CART}.id): detachable SHOPPING_CART
		do
		end

	save_shopping_cart (a_cart: SHOPPING_CART)
		do
		end

	cart_to_order (a_cart: SHOPPING_CART; a_order_id: READABLE_STRING_GENERAL)
		do
		end

	cart_from_order (a_order_id: READABLE_STRING_GENERAL): detachable SHOPPING_CART
		do
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

