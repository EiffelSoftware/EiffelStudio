note
	description: "Summary description for {DOWNLOAD_OPTIONS}."
	date: "$Date$"
	revision: "$Revision$"

class
	DOWNLOAD_OPTIONS


feature -- Access

	product: detachable DOWNLOAD_PRODUCT

feature -- Element Change

	set_product (a_product: like product)
		do
			product := a_product
		end
end
