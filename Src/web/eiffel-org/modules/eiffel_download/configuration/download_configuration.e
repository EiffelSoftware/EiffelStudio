note
	description: "Summary description for {DOWNLOAD_CONFIGURATION}."
	date: "$Date$"
	revision: "$Revision$"

class
	DOWNLOAD_CONFIGURATION


feature -- Access

	mirror: detachable READABLE_STRING_32
		-- url mirror.

	products: detachable ARRAYED_LIST [DOWNLOAD_PRODUCT]
		-- Possible list of product downloads.

feature -- Element Change

	set_mirror (a_mirror: like mirror)
			-- Set `mirror' with `a_mirror'.
		do
			mirror := a_mirror
		ensure
			mirror_set: mirror = a_mirror
		end

	set_products (a_products: like products)
			-- Possible list of product downloads.			
		do
			products := a_products
		end

	add_product (a_product: DOWNLOAD_PRODUCT)
			-- Add a product 'a_product' to the list of products 'products'.
		local
			l_products: like products
		do
			l_products := products
			if l_products /= Void then
				l_products.put_front (a_product)
			else
				create {ARRAYED_LIST [DOWNLOAD_PRODUCT]} l_products.make (1)
				l_products.put_front (a_product)
			end
			products := l_products
		end
end
