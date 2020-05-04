note
	description: "Interface for accessing shop storage"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SHOP_STORAGE_I

feature -- Error Handling

	error_handler: ERROR_HANDLER
			-- Error handler.
		deferred
		end

feature -- Store

	user_shopping_cart (a_user: CMS_USER): detachable SHOPPING_CART
		require
			a_user.has_id
		deferred
		end

	shopping_cart_by_id (a_cart_id: like {SHOPPING_CART}.id): detachable SHOPPING_CART
		require
			a_cart_id > 0
		deferred
		end

	save_shopping_cart (a_cart: SHOPPING_CART)
		deferred
		end

	cart_to_order (a_cart: SHOPPING_CART; a_order_id: READABLE_STRING_GENERAL)
		require
			not a_cart.is_guest
		deferred
		end

	cart_from_order (a_order_id: READABLE_STRING_GENERAL): detachable SHOPPING_CART
		deferred
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

