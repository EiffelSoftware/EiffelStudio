note
	description: "Generic {HTTP_ACCEPT_VARIANTS}.with common functionality to most header variants.."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	HTTP_ACCEPT_VARIANTS

feature {NONE} -- Initialization

	make
		do
		end

feature -- Change

	set_vary_header_value
			-- Set the `vary_header_value'
		deferred
		ensure
			is_valid_header_set : is_valid_header_name (vary_header_value)
		end

feature -- Access

	vary_header_value: detachable READABLE_STRING_8
			-- Name of header to be added to the Vary header of the response
			-- this indicates the Accept-* header source of the matched `variant_value' if any,
			-- if this is using the default, the `vary_header_value' is Void.

	supported_variants: detachable ITERABLE [READABLE_STRING_8]
			-- Set of supported variants for the response

	variant_value: detachable READABLE_STRING_8
			-- Associated value, it could be value of:
			-- 		content type
			--		language
			--		character set
			--		encoding.

feature -- Status_Report

	is_acceptable: BOOLEAN
			-- is the current variant accepted?

	is_valid_header_name (a_header_name: detachable READABLE_STRING_8): BOOLEAN
			-- is `a_header_name' a valid accept header name?
		note
			EIS:"name=Accept", "src=http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.1", "protocol=uri"
			EIS:"name=Accept-Charset", "src=http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.2", "protocol=uri"
			EIS:"name=Accept-Encoding", "src=http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.3", "protocol=uri"
			EIS:"name=Accept-Language", "src=http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.4", "protocol=uri"
		do
			if a_header_name /= Void then
				Result :=			a_header_name.same_string ({HTTP_HEADER_NAMES}.header_accept) 			-- "Accept",
							or else a_header_name.same_string ({HTTP_HEADER_NAMES}.header_accept_language)	-- "Accept-Language",
							or else a_header_name.same_string ({HTTP_HEADER_NAMES}.header_accept_encoding)	-- "Accept-Encoding",
							or else a_header_name.same_string ({HTTP_HEADER_NAMES}.header_accept_charset) 	-- "Accept-Charset"
			end
		end

feature -- Change Element

	set_variant_value (v: READABLE_STRING_8)
			-- Set `variant_value' as `v'
		do
			variant_value := v
		ensure
			type_set: attached variant_value as l_variant implies l_variant = v
		end

	set_acceptable (b: BOOLEAN)
			-- Set `is_acceptable' with `b'
		do
			is_acceptable := b
		ensure
			is_acceptable_set: is_acceptable = b
		end

	set_supported_variants (a_supported: ITERABLE [READABLE_STRING_8])
			-- Set `supported variants' with `a_supported'
		do
			supported_variants := a_supported
		ensure
			set_supported_variants: attached supported_variants as l_supported_variants  implies l_supported_variants = a_supported
		end

note
	copyright: "2011-2013, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"

end
