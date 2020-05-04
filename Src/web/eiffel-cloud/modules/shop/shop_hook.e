note
	description: "Summary description for {SHOP_HOOK}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SHOP_HOOK

inherit
	CMS_HOOK

feature -- Hook

	fill_cart (a_cart: SHOPPING_CART)
		do
			across
				a_cart.items as ic
			loop
				fill_cart_item (a_cart, ic.item)
			end
		end

	fill_cart_item (a_cart: SHOPPING_CART; a_cart_item: SHOPPING_ITEM)
		deferred
		end

	commit_cart (a_cart: SHOPPING_CART)
		do
			across
				a_cart.items as ic
			loop
				commit_cart_item (a_cart, ic.item)
			end
		end

	commit_cart_item (a_cart: SHOPPING_CART; a_cart_item: SHOPPING_ITEM)
		deferred
		end

end
