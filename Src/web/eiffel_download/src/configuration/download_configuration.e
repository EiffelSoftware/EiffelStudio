note
	description: "Summary description for {DOWNLOAD_CONFIGURATION}."
	date: "$Date$"
	revision: "$Revision$"

class
	DOWNLOAD_CONFIGURATION


feature -- Access

	mirror: detachable READABLE_STRING_8
		-- url mirror.

	products: detachable LIST [DOWNLOAD_PRODUCT]
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
end
