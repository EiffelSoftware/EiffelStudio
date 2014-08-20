note
	description: "Summary description for {DOWNLOAD_OPTIONS}."
	date: "$Date$"
	revision: "$Revision$"

class
	DOWNLOAD_OPTIONS


feature -- Access

	mirrors: detachable LIST[DOWNLOAD_MIRROR_MIRRORS]
		-- Possible list of mirrors.

	product: detachable DOWNLOAD_PRODUCT

feature -- Element Change

	set_mirrors (a_mirrors: like mirrors)
		do
			mirrors := a_mirrors
		end

	set_product (a_product: like product)
		do
			product := a_product
		end
end
