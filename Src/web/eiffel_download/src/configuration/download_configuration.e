note
	description: "Summary description for {DOWNLOAD_CONFIGURATION}."
	date: "$Date$"
	revision: "$Revision$"

class
	DOWNLOAD_CONFIGURATION


feature -- Access

	platforms: detachable  LIST[DOWNLOAD_PLATFORM]
		-- Possible list of available platforms.

	mirrors: detachable STRING_TABLE[DOWNLOAD_MIRROR]
		-- Mirror table <id, mirror>.

	products: detachable LIST[DOWNLOAD_PRODUCT]
		-- Possible list of product downloads.

feature -- Element Change

	set_platforms (a_platforms: like platforms)
			-- Possible list of available platforms.
		do
			platforms := a_platforms
		end

	set_mirrors (a_mirrors: like mirrors)
			-- Mirror table <id, mirror>.
		do
			mirrors := a_mirrors
		end

	set_products (a_products: like products)
			-- Possible list of product downloads.			
		do
			products := a_products
		end
end
