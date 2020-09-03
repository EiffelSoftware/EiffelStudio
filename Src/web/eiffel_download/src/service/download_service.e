note
	description: "Summary description for {DOWNLOAD_SERVICE}."
	date: "$Date$"
	revision: "$Revision$"

class
	DOWNLOAD_SERVICE

create
	make

feature {NONE} -- Initialization

	make (a_configuration: DOWNLOAD_CONFIGURATION)
			-- Create an object with a download configuration.
		do
			configuration := a_configuration
		ensure
			configuration_set: configuration = a_configuration
		end

feature -- Query

	mirror: detachable READABLE_STRING_8
		do
			Result := configuration.mirror
		end

	products: detachable LIST [DOWNLOAD_PRODUCT]
			-- Get products.
		do
			Result := configuration.products
		end

	first_product: detachable DOWNLOAD_PRODUCT
			-- First product among all `products`.
			-- FIXME: it seems for now, we handle only first product, i.e a list of products with a unique element.
		do
			if attached products as l_products then
				Result := l_products.first
			end
		end

feature {NONE} -- Configuration		

	configuration : DOWNLOAD_CONFIGURATION
		-- Download configuration object.		

end
