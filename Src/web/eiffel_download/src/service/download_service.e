note
	description: "Summary description for {DOWNLOAD_SERVICE}."
	date: "$Date$"
	revision: "$Revision$"

class
	DOWNLOAD_SERVICE

create
	make

feature -- Initialization

	make (a_configuration: DOWNLOAD_CONFIGURATION)
			-- Create an object with a download configuration.
		do
			configuration := a_configuration
		ensure
			configuration_set: configuration = a_configuration
		end

feature -- Basic Operations

	enterprise: detachable DOWNLOAD_OPTIONS
		do
			create Result
			Result.set_mirrors (retrieve_mirror_enterprise)
			Result.set_product (retrieve_product_enterprise)
		end


feature -- Implementation

	retrieve_mirror_enterprise: detachable LIST[DOWNLOAD_MIRROR_MIRRORS]
		do
			if
				attached configuration.mirrors as l_mirrors and then
				attached l_mirrors.at ("eiffelstudio") as l_mirror
			then
				Result := l_mirror.mirrors
			end
		end

	retrieve_product_enterprise: detachable DOWNLOAD_PRODUCT
		do
			if attached configuration.products as l_products then
				Result := l_products.at (2)
			end
		end

	configuration : DOWNLOAD_CONFIGURATION
		-- Download configuration object.		



end
