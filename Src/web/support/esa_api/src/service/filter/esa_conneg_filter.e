note
	description: "Summary description for {ESA_CONNEG_FILTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_CONNEG_FILTER

inherit
	WSF_URI_TEMPLATE_HANDLER

	ESA_ABSTRACT_HANDLER
		rename
			set_esa_config as make
		end
	WSF_FILTER



create
	make

feature -- Basic operations

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute the filter
		local
			media_variants: HTTP_ACCEPT_MEDIA_TYPE_VARIANTS
			l_compression_variants : HTTP_ACCEPT_ENCODING_VARIANTS
		do
			media_variants := media_type_variants (req)
			if media_variants.is_acceptable then
				if attached media_variants.media_type as l_type then
				    l_compression_variants := compression_variants (req)
				    if
				    	l_compression_variants.is_acceptable and then
				    	attached l_compression_variants.encoding as l_encoding
				    then
				    	req.set_execution_variable ("compression", l_encoding)
				    end
					req.set_execution_variable ("media_type", l_type)
					execute_next (req, res)
				else
					execute_next (req, res)
				end
			else
				execute_next (req, res)
			end
		end

end
